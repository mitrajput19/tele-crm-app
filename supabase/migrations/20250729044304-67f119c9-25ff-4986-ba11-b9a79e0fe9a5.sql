-- First, let's drop the problematic policy
DROP POLICY IF EXISTS "Users can view profiles based on hierarchy" ON public.profiles;

-- Create a security definer function to check if user can view a profile
CREATE OR REPLACE FUNCTION public.can_view_profile(target_user_id uuid)
RETURNS boolean
LANGUAGE sql
STABLE SECURITY DEFINER
SET search_path = 'public'
AS $$
  SELECT 
    -- User can view their own profile
    auth.uid() = target_user_id OR
    -- Super admins and admins can view all profiles
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE user_id = auth.uid() 
      AND role IN ('super_admin', 'admin')
    ) OR
    -- Users can view their subordinates
    EXISTS (
      SELECT 1 FROM public.get_subordinates(auth.uid()) 
      WHERE user_id = target_user_id
    );
$$;

-- Create new RLS policy using the security definer function
CREATE POLICY "Users can view profiles based on hierarchy" 
ON public.profiles 
FOR SELECT 
USING (public.can_view_profile(user_id));