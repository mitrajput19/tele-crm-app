-- Fix the remaining function search path issues

-- Update functions with missing search path settings
CREATE OR REPLACE FUNCTION public.get_subordinate(manager_user_id uuid)
RETURNS TABLE(profile_id uuid, user_id uuid, full_name text, role text, hierarchy_level integer, department text, position_title text)
LANGUAGE sql
SECURITY DEFINER
SET search_path = 'public'
AS $$
WITH RECURSIVE subordinates AS (
  SELECT 
    p.id AS profile_id,
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.department,
    p.position_title,
    1 AS depth
  FROM public.profiles p
  WHERE p.manager_id = manager_user_id

  UNION ALL

  SELECT 
    p.id AS profile_id,
    p.user_id,
    p.full_name,
    p.role,
    p.hierarchy_level,
    p.department,
    p.position_title,
    s.depth + 1
  FROM public.profiles p
  INNER JOIN subordinates s ON p.manager_id = s.profile_id
  WHERE s.depth < 10
)
SELECT 
  profile_id,
  user_id,
  full_name,
  role,
  hierarchy_level,
  department,
  position_title
FROM subordinates 
ORDER BY hierarchy_level, full_name;
$$;

CREATE OR REPLACE FUNCTION public.get_team_members(employee_user_id uuid)
RETURNS TABLE(user_id uuid, full_name text, role text, position_title text)
LANGUAGE sql
SECURITY DEFINER
SET search_path = 'public'
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

CREATE OR REPLACE FUNCTION public.log_action(p_action_type text, p_table_name text, p_record_id text, p_old_values jsonb DEFAULT NULL::jsonb, p_new_values jsonb DEFAULT NULL::jsonb, p_additional_data jsonb DEFAULT NULL::jsonb)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
BEGIN
    INSERT INTO audit_logs (
        action_type,
        table_name,
        record_id,
        user_id,
        old_values,
        new_values,
        changes_made,
        created_at
    ) VALUES (
        p_action_type,
        p_table_name,
        p_record_id,
        auth.uid()::text,
        p_old_values,
        p_new_values,
        p_additional_data,
        NOW()
    );
END;
$$;

-- Fix the security definer view issue by dropping any remaining security definer views
DO $$
DECLARE
    view_name text;
BEGIN
    FOR view_name IN 
        SELECT viewname FROM pg_views 
        WHERE schemaname = 'public' 
        AND viewname != 'hierarchy_view'
    LOOP
        EXECUTE 'DROP VIEW IF EXISTS public.' || quote_ident(view_name) || ' CASCADE';
    END LOOP;
END $$;