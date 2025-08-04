-- Fix the hierarchy levels that got corrupted
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
END;