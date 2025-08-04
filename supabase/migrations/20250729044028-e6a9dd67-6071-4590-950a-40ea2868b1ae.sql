-- Drop existing RLS policies on profiles table
DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;

-- Create new comprehensive RLS policies for profiles table
CREATE POLICY "Users can view profiles based on hierarchy" 
ON public.profiles 
FOR SELECT 
USING (
  auth.uid() = user_id OR  -- Users can see their own profile
  (EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE user_id = auth.uid() 
    AND role IN ('super_admin', 'admin')
  )) OR  -- Super admins and admins can see all profiles
  (EXISTS (
    SELECT 1 FROM get_subordinates(auth.uid()) 
    WHERE user_id = profiles.user_id
  ))  -- Users can see their subordinates
);

-- Keep existing update and insert policies
CREATE POLICY "Users can update their own profile" 
ON public.profiles 
FOR UPDATE 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);