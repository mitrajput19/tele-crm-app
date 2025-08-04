-- Fix critical security issues

-- Enable RLS on tables that need it
ALTER TABLE public.user_managers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_hierarchy ENABLE ROW LEVEL SECURITY;

-- Fix function search paths for security
CREATE OR REPLACE FUNCTION public.get_subordinates(manager_user_id UUID)
RETURNS TABLE(
  user_id UUID,
  full_name TEXT,
  role TEXT,
  hierarchy_level INTEGER,
  department TEXT,
  position_title TEXT
) 
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$ 
WITH RECURSIVE subordinates AS (
  -- Base case: direct reports
  SELECT 
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.department,
    p.position_title,
    1 as depth
  FROM public.profiles p
  WHERE p.manager_id = manager_user_id
  
  UNION ALL
  
  -- Recursive case: subordinates of subordinates
  SELECT 
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.department,
    p.position_title,
    s.depth + 1
  FROM public.profiles p
  INNER JOIN subordinates s ON p.manager_id = s.user_id
  WHERE s.depth < 10 -- Prevent infinite recursion
)
SELECT 
  user_id,
  full_name,
  role,
  hierarchy_level,
  department,
  position_title
FROM subordinates 
ORDER BY hierarchy_level, full_name;
$$;

CREATE OR REPLACE FUNCTION public.get_management_chain(employee_user_id UUID)
RETURNS TABLE(
  user_id UUID,
  full_name TEXT,
  role TEXT,
  hierarchy_level INTEGER,
  position_title TEXT
) 
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$ 
WITH RECURSIVE management_chain AS (
  -- Base case: the employee
  SELECT 
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.position_title,
    p.manager_id,
    0 as depth
  FROM public.profiles p
  WHERE p.user_id = employee_user_id
  
  UNION ALL
  
  -- Recursive case: managers up the chain
  SELECT 
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.position_title,
    p.manager_id,
    m.depth + 1
  FROM public.profiles p
  INNER JOIN management_chain m ON p.user_id = m.manager_id
  WHERE m.depth < 10 -- Prevent infinite recursion
)
SELECT 
  user_id,
  full_name,
  role,
  hierarchy_level,
  position_title
FROM management_chain 
WHERE depth > 0 -- Exclude the employee themselves
ORDER BY hierarchy_level DESC;
$$;

CREATE OR REPLACE FUNCTION public.can_user_manage(manager_user_id UUID, employee_user_id UUID)
RETURNS BOOLEAN 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Super admin can manage everyone
  IF EXISTS (SELECT 1 FROM public.profiles WHERE user_id = manager_user_id AND role = 'super_admin') THEN
    RETURN TRUE;
  END IF;
  
  -- Check if employee is in manager's subordinate tree
  RETURN EXISTS (
    SELECT 1 FROM get_subordinates(manager_user_id) 
    WHERE user_id = employee_user_id
  );
END;
$$;

CREATE OR REPLACE FUNCTION public.get_team_members(employee_user_id UUID)
RETURNS TABLE(
  user_id UUID,
  full_name TEXT,
  role TEXT,
  position_title TEXT
) 
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
SELECT 
  p.user_id,
  p.full_name,
  p.role,
  p.position_title
FROM public.profiles p
WHERE p.manager_id = (
  SELECT manager_id FROM public.profiles WHERE user_id = employee_user_id
) 
AND p.user_id != employee_user_id
ORDER BY p.full_name;
$$;

CREATE OR REPLACE FUNCTION public.assign_manager(employee_user_id UUID, new_manager_user_id UUID)
RETURNS BOOLEAN 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  current_user_role TEXT;
BEGIN
  -- Check if current user can make this assignment
  SELECT role INTO current_user_role FROM public.profiles WHERE user_id = auth.uid();
  
  IF current_user_role != 'super_admin' AND NOT can_user_manage(auth.uid(), employee_user_id) THEN
    RAISE EXCEPTION 'Insufficient permissions to assign manager';
  END IF;
  
  -- Prevent circular references
  IF EXISTS (
    SELECT 1 FROM get_management_chain(new_manager_user_id) 
    WHERE user_id = employee_user_id
  ) THEN
    RAISE EXCEPTION 'Cannot create circular management structure';
  END IF;
  
  -- Update the manager
  UPDATE public.profiles 
  SET manager_id = new_manager_user_id,
      updated_at = now()
  WHERE user_id = employee_user_id;
  
  RETURN TRUE;
END;
$$;

CREATE OR REPLACE FUNCTION public.get_user_managers(p_user_id UUID)
RETURNS TABLE(
  manager_id UUID,
  manager_name TEXT,
  manager_role TEXT,
  manager_type TEXT,
  is_primary BOOLEAN
) 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    um.manager_id,
    p.full_name as manager_name,
    p.role as manager_role,
    um.manager_type,
    um.is_primary
  FROM public.user_managers um
  JOIN public.profiles p ON um.manager_id = p.user_id
  WHERE um.user_id = p_user_id 
    AND um.is_active = true
  ORDER BY um.is_primary DESC, um.created_at ASC;
END;
$$;

CREATE OR REPLACE FUNCTION public.assign_multiple_managers(
  p_user_id UUID,
  p_manager_ids UUID[],
  p_manager_types TEXT[] DEFAULT NULL,
  p_primary_manager_id UUID DEFAULT NULL
) RETURNS BOOLEAN 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  manager_id UUID;
  manager_type TEXT;
  i INTEGER;
BEGIN
  -- Validate permissions
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE user_id = auth.uid() 
    AND role IN ('super_admin', 'admin', 'senior_manager', 'manager')
  ) THEN
    RAISE EXCEPTION 'Insufficient permissions to assign managers';
  END IF;

  -- Deactivate existing manager assignments
  UPDATE public.user_managers 
  SET is_active = false, updated_at = now()
  WHERE user_id = p_user_id;

  -- Assign new managers
  FOR i IN 1..array_length(p_manager_ids, 1) LOOP
    manager_id := p_manager_ids[i];
    manager_type := COALESCE(p_manager_types[i], 'direct');
    
    INSERT INTO public.user_managers (
      user_id,
      manager_id,
      manager_type,
      is_primary,
      assigned_by,
      is_active
    ) VALUES (
      p_user_id,
      manager_id,
      manager_type,
      manager_id = p_primary_manager_id,
      auth.uid(),
      true
    );
  END LOOP;

  -- Log the action
  PERFORM public.log_action(
    'assign_managers',
    'user_managers',
    p_user_id,
    NULL,
    jsonb_build_object('manager_ids', p_manager_ids, 'primary_manager', p_primary_manager_id),
    jsonb_build_object('assigned_by', auth.uid())
  );

  RETURN true;
END;
$$;

CREATE OR REPLACE FUNCTION public.log_action(
  p_action_type TEXT,
  p_table_name TEXT,
  p_record_id UUID DEFAULT NULL,
  p_old_values JSONB DEFAULT NULL,
  p_new_values JSONB DEFAULT NULL,
  p_additional_data JSONB DEFAULT NULL
) RETURNS UUID 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  log_id UUID;
  changes_made JSONB := '{}';
BEGIN
  -- Calculate changes if both old and new values are provided
  IF p_old_values IS NOT NULL AND p_new_values IS NOT NULL THEN
    SELECT jsonb_object_agg(key, jsonb_build_object('old', p_old_values->key, 'new', p_new_values->key))
    INTO changes_made
    FROM jsonb_each(p_new_values)
    WHERE p_old_values->key IS DISTINCT FROM p_new_values->key;
  END IF;

  INSERT INTO public.audit_logs (
    action_type,
    table_name,
    record_id,
    user_id,
    old_values,
    new_values,
    changes_made,
    additional_data
  ) VALUES (
    p_action_type,
    p_table_name,
    p_record_id,
    auth.uid(),
    p_old_values,
    p_new_values,
    changes_made,
    p_additional_data
  ) RETURNING id INTO log_id;

  RETURN log_id;
END;
$$;