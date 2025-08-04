-- Fix security definer function by setting proper search path
CREATE OR REPLACE FUNCTION public.get_subordinates(manager_user_id uuid)
RETURNS TABLE(user_id uuid, full_name text, role text, hierarchy_level integer, department text, position_title text)
LANGUAGE sql
SECURITY DEFINER
SET search_path = 'public'
AS $function$ 
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
$function$;