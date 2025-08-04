-- Create multiple managers support table
CREATE TABLE IF NOT EXISTS public.user_managers (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES public.profiles(user_id) ON DELETE CASCADE,
  manager_id UUID NOT NULL REFERENCES public.profiles(user_id) ON DELETE CASCADE,
  manager_type TEXT NOT NULL DEFAULT 'direct' CHECK (manager_type IN ('direct', 'functional', 'project', 'dotted')),
  is_primary BOOLEAN NOT NULL DEFAULT false,
  assigned_by UUID REFERENCES public.profiles(user_id) ON DELETE SET NULL,
  assigned_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  -- Prevent duplicate manager assignments
  UNIQUE(user_id, manager_id, manager_type)
);

-- Create comprehensive audit log table
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  action_type TEXT NOT NULL, -- 'create', 'update', 'delete', 'assign', 'login', 'logout', etc.
  table_name TEXT NOT NULL, -- Which table was affected
  record_id UUID, -- ID of the affected record
  user_id UUID REFERENCES public.profiles(user_id) ON DELETE SET NULL, -- Who performed the action
  old_values JSONB, -- Previous values
  new_values JSONB, -- New values
  changes_made JSONB, -- Specific changes
  ip_address INET, -- User's IP address
  user_agent TEXT, -- Browser/app info
  session_id UUID, -- Session identifier
  additional_data JSONB, -- Any additional context
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create role hierarchy mapping table for better role management
CREATE TABLE IF NOT EXISTS public.role_hierarchy (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  role_name TEXT NOT NULL UNIQUE,
  hierarchy_level INTEGER NOT NULL,
  can_manage_roles TEXT[], -- Array of roles this role can manage
  permissions JSONB NOT NULL DEFAULT '{}', -- Specific permissions
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Insert role hierarchy data
INSERT INTO public.role_hierarchy (role_name, hierarchy_level, can_manage_roles, permissions) VALUES
  ('super_admin', 8, ARRAY['admin', 'senior_manager', 'manager', 'assistant_manager', 'team_lead', 'senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": true, "can_view_all": true, "can_manage_org_units": true}'),
  ('admin', 7, ARRAY['senior_manager', 'manager', 'assistant_manager', 'team_lead', 'senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": true, "can_view_department": true}'),
  ('senior_manager', 6, ARRAY['manager', 'assistant_manager', 'team_lead', 'senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": true, "can_view_department": true}'),
  ('manager', 5, ARRAY['assistant_manager', 'team_lead', 'senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": false, "can_view_team": true}'),
  ('assistant_manager', 4, ARRAY['team_lead', 'senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": false, "can_view_team": true}'),
  ('team_lead', 3, ARRAY['senior_employee', 'salesperson', 'employee'], '{"can_create_users": true, "can_assign_managers": false, "can_view_team": true}'),
  ('senior_employee', 2, ARRAY['salesperson'], '{"can_create_users": false, "can_assign_managers": false, "can_view_own": true}'),
  ('salesperson', 1, ARRAY[]::TEXT[], '{"can_create_users": false, "can_assign_managers": false, "can_view_own": true}'),
  ('employee', 1, ARRAY[]::TEXT[], '{"can_create_users": false, "can_assign_managers": false, "can_view_own": true}')
ON CONFLICT (role_name) DO UPDATE SET
  hierarchy_level = EXCLUDED.hierarchy_level,
  can_manage_roles = EXCLUDED.can_manage_roles,
  permissions = EXCLUDED.permissions;

-- Enable RLS on new tables
ALTER TABLE public.user_managers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_hierarchy ENABLE ROW LEVEL SECURITY;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_managers_user_id ON public.user_managers(user_id);
CREATE INDEX IF NOT EXISTS idx_user_managers_manager_id ON public.user_managers(manager_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id ON public.audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_table_name ON public.audit_logs(table_name);
CREATE INDEX IF NOT EXISTS idx_audit_logs_action_type ON public.audit_logs(action_type);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON public.audit_logs(created_at);

-- RLS policies for user_managers
CREATE POLICY "Users can view their manager assignments" 
ON public.user_managers 
FOR SELECT 
USING (
  auth.uid() = user_id OR 
  auth.uid() = manager_id OR
  EXISTS (SELECT 1 FROM public.profiles WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')) OR
  can_user_manage(auth.uid(), user_managers.user_id)
);

CREATE POLICY "Managers can assign subordinates" 
ON public.user_managers 
FOR INSERT 
WITH CHECK (
  EXISTS (SELECT 1 FROM public.profiles WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')) OR
  can_user_manage(auth.uid(), user_managers.user_id)
);

CREATE POLICY "Managers can update manager assignments" 
ON public.user_managers 
FOR UPDATE 
USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')) OR
  can_user_manage(auth.uid(), user_managers.user_id)
);

-- RLS policies for audit_logs
CREATE POLICY "Users can view their own audit logs" 
ON public.audit_logs 
FOR SELECT 
USING (
  auth.uid() = user_id OR 
  EXISTS (SELECT 1 FROM public.profiles WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin'))
);

-- RLS policies for role_hierarchy
CREATE POLICY "All authenticated users can view role hierarchy" 
ON public.role_hierarchy 
FOR SELECT 
USING (auth.uid() IS NOT NULL);

-- Function to log actions
CREATE OR REPLACE FUNCTION public.log_action(
  p_action_type TEXT,
  p_table_name TEXT,
  p_record_id UUID DEFAULT NULL,
  p_old_values JSONB DEFAULT NULL,
  p_new_values JSONB DEFAULT NULL,
  p_additional_data JSONB DEFAULT NULL
) RETURNS UUID AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update profiles table trigger for hierarchy level setting
CREATE OR REPLACE FUNCTION public.set_hierarchy_level()
RETURNS TRIGGER AS $$
BEGIN
  NEW.hierarchy_level := CASE 
    WHEN NEW.role = 'employee' or NEW.role = 'salesperson' THEN 1
    WHEN NEW.role = 'senior_employee' THEN 2
    WHEN NEW.role = 'team_lead' THEN 3
    WHEN NEW.role = 'assistant_manager' THEN 4
    WHEN NEW.role = 'manager' THEN 5
    WHEN NEW.role = 'senior_manager' THEN 6
    WHEN NEW.role = 'admin' THEN 7
    WHEN NEW.role = 'super_admin' THEN 8
    ELSE 1 -- Default to employee level
  END;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for hierarchy level setting
DROP TRIGGER IF EXISTS set_profile_hierarchy_level ON public.profiles;
CREATE TRIGGER set_profile_hierarchy_level
    BEFORE INSERT OR UPDATE OF role ON public.profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.set_hierarchy_level();

-- Function to get user's managers (multiple managers support)
CREATE OR REPLACE FUNCTION public.get_user_managers(p_user_id UUID)
RETURNS TABLE(
  manager_id UUID,
  manager_name TEXT,
  manager_role TEXT,
  manager_type TEXT,
  is_primary BOOLEAN
) AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to assign multiple managers
CREATE OR REPLACE FUNCTION public.assign_multiple_managers(
  p_user_id UUID,
  p_manager_ids UUID[],
  p_manager_types TEXT[] DEFAULT NULL,
  p_primary_manager_id UUID DEFAULT NULL
) RETURNS BOOLEAN AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;