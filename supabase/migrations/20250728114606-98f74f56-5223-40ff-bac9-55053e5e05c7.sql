-- Add foreign key constraint for manager_id to reference user_id in the same table
ALTER TABLE public.profiles 
ADD CONSTRAINT profiles_manager_id_fkey 
FOREIGN KEY (manager_id) REFERENCES public.profiles(user_id) 
ON DELETE SET NULL;

-- Update the trigger to ensure new users get proper hierarchy levels
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
BEGIN
    INSERT INTO public.profiles (user_id, full_name, role, hierarchy_level, can_manage_others)
    VALUES (
        NEW.id, 
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email), 
        'employee',  -- Default role
        1,           -- Default hierarchy level for employees
        false        -- Default can_manage_others for employees
    );
    RETURN NEW;
END;
$$;

-- Update any existing users with null hierarchy levels
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
END,
can_manage_others = CASE 
    WHEN role IN ('super_admin', 'admin', 'senior_manager', 'manager', 'assistant_manager', 'team_lead') THEN true
    ELSE false
END
WHERE hierarchy_level IS NULL OR can_manage_others IS NULL;