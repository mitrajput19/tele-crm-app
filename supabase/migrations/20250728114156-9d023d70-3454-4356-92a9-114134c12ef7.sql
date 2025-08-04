-- Update hierarchy levels based on roles to fix the broken hierarchy
UPDATE public.profiles 
SET hierarchy_level = CASE 
    WHEN role = 'super_admin' THEN 8
    WHEN role = 'admin' THEN 7
    WHEN role = 'senior_manager' THEN 6
    WHEN role = 'manager' THEN 5
    WHEN role = 'assistant_manager' THEN 4
    WHEN role = 'team_lead' THEN 3
    WHEN role = 'senior_employee' THEN 2
    WHEN role = 'employee' OR role = 'salesperson' THEN 1
    ELSE 1
END
WHERE hierarchy_level = 0 OR hierarchy_level IS NULL;

-- Set can_manage_others based on role
UPDATE public.profiles 
SET can_manage_others = CASE 
    WHEN role IN ('super_admin', 'admin', 'senior_manager', 'manager', 'assistant_manager', 'team_lead') THEN true
    ELSE false
END;

-- Example: Assign some employees to the admin as manager (you can modify these based on your actual structure)
-- This sets Harshad Patil (admin) as manager for some employees
UPDATE public.profiles 
SET manager_id = (SELECT user_id FROM public.profiles WHERE full_name = 'Harshad Patil' AND role = 'admin' LIMIT 1)
WHERE role IN ('employee', 'salesperson') 
  AND manager_id IS NULL 
  AND full_name NOT LIKE '%Harshad%'
  AND user_id != (SELECT user_id FROM public.profiles WHERE full_name = 'Harshad Patil' AND role = 'admin' LIMIT 1);

-- Create a function to properly assign managers with validation
CREATE OR REPLACE FUNCTION public.assign_manager_with_validation(
  employee_user_id UUID,
  new_manager_user_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  employee_role TEXT;
  manager_role TEXT;
  employee_level INTEGER;
  manager_level INTEGER;
BEGIN
  -- Get employee details
  SELECT role, hierarchy_level INTO employee_role, employee_level
  FROM public.profiles
  WHERE user_id = employee_user_id;
  
  -- Get manager details
  SELECT role, hierarchy_level INTO manager_role, manager_level
  FROM public.profiles
  WHERE user_id = new_manager_user_id;
  
  -- Validate that manager has higher hierarchy level
  IF manager_level <= employee_level THEN
    RAISE EXCEPTION 'Manager must have higher hierarchy level than employee';
  END IF;
  
  -- Validate that manager can manage others
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE user_id = new_manager_user_id 
    AND can_manage_others = true
  ) THEN
    RAISE EXCEPTION 'Selected user cannot manage others';
  END IF;
  
  -- Prevent circular references
  IF EXISTS (
    WITH RECURSIVE management_chain AS (
      SELECT user_id, manager_id FROM public.profiles WHERE user_id = new_manager_user_id
      UNION ALL
      SELECT p.user_id, p.manager_id 
      FROM public.profiles p
      JOIN management_chain mc ON p.user_id = mc.manager_id
    )
    SELECT 1 FROM management_chain WHERE user_id = employee_user_id
  ) THEN
    RAISE EXCEPTION 'Cannot create circular management structure';
  END IF;
  
  -- Update the manager
  UPDATE public.profiles
  SET manager_id = new_manager_user_id,
      updated_at = NOW()
  WHERE user_id = employee_user_id;
  
  -- Log the action
  PERFORM public.log_action(
    'assign_manager',
    'profiles',
    employee_user_id::text,
    NULL,
    jsonb_build_object('new_manager_id', new_manager_user_id),
    jsonb_build_object('assigned_by', auth.uid())
  );
  
  RETURN TRUE;
END;
$$;