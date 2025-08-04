-- Enable RLS on hierarchy_view table
ALTER TABLE public.hierarchy_view ENABLE ROW LEVEL SECURITY;

-- Create policy for hierarchy_view
CREATE POLICY "Users can view hierarchy data they have access to"
ON public.hierarchy_view
FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = user_id OR
    auth.uid() = manager_id OR
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE user_id = auth.uid() 
      AND role IN ('super_admin', 'admin')
    ) OR
    can_user_manage(auth.uid(), user_id)
  )
);

-- Fix the function search path issues
CREATE OR REPLACE FUNCTION public.assign_manager_with_validation(
  employee_user_id UUID,
  new_manager_user_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
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