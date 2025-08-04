-- Fix remaining security issues with proper type casting

-- Add missing RLS policy for audit_logs with proper type casting
CREATE POLICY "Users can view audit logs they have access to"
ON public.audit_logs FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = user_id::uuid OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    (user_id IS NOT NULL AND public.can_user_manage(auth.uid(), user_id::uuid))
  )
);

CREATE POLICY "System can insert audit logs"
ON public.audit_logs FOR INSERT
WITH CHECK (true); -- Allow system inserts for auditing

-- Drop the security definer view and recreate as a regular view
DROP VIEW IF EXISTS public.hierarchy_view;

CREATE VIEW public.hierarchy_view AS
SELECT 
  p.user_id,
  p.full_name,
  p.role,
  p.hierarchy_level,
  p.department,
  p.position_title,
  p.can_manage_others,
  p.manager_id,
  p.org_unit_id,
  p.created_at,
  p.updated_at,
  m.full_name as manager_name,
  m.role as manager_role,
  ou.name as org_unit_name,
  ou.unit_type as org_unit_type
FROM public.profiles p
LEFT JOIN public.profiles m ON p.manager_id = m.user_id
LEFT JOIN public.organizational_units ou ON p.org_unit_id = ou.id;

-- Fix remaining function search paths
CREATE OR REPLACE FUNCTION public.update_hierarchy_level()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
BEGIN
  IF NEW.manager_id IS NULL THEN
    -- Top level (super admin or no manager)
    NEW.hierarchy_level = 0;
  ELSE
    -- Set level to manager's level + 1
    SELECT hierarchy_level + 1 
    INTO NEW.hierarchy_level
    FROM public.profiles 
    WHERE user_id = NEW.manager_id;
  END IF;
  
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.cascade_hierarchy_updates()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
BEGIN
  -- Only cascade if manager_id actually changed
  IF OLD.manager_id IS DISTINCT FROM NEW.manager_id THEN
    -- Update all subordinates recursively
    WITH RECURSIVE subordinate_updates AS (
      -- Direct reports
      SELECT user_id, NEW.hierarchy_level + 1 as new_level, 1 as depth
      FROM public.profiles 
      WHERE manager_id = NEW.user_id
      
      UNION ALL
      
      -- Indirect reports
      SELECT p.user_id, s.new_level + 1, s.depth + 1
      FROM public.profiles p
      JOIN subordinate_updates s ON p.manager_id = s.user_id
      WHERE s.depth < 10 -- Prevent infinite recursion
    )
    UPDATE public.profiles 
    SET hierarchy_level = subordinate_updates.new_level
    FROM subordinate_updates 
    WHERE profiles.user_id = subordinate_updates.user_id;
  END IF;
  
  RETURN NEW;
END;
$$;