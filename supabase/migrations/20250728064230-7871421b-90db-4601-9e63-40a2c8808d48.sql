-- Create RLS Policies for CRM Tables and Fix Security Issues

-- Step 1: Create secure functions to avoid infinite recursion in RLS policies
CREATE OR REPLACE FUNCTION public.get_current_user_role()
RETURNS TEXT
LANGUAGE SQL
SECURITY DEFINER
STABLE
SET search_path = 'public'
AS $$
  SELECT role FROM public.profiles WHERE user_id = auth.uid();
$$;

CREATE OR REPLACE FUNCTION public.can_manage_crm_data(target_user_id UUID)
RETURNS BOOLEAN
LANGUAGE SQL
SECURITY DEFINER
STABLE
SET search_path = 'public'
AS $$
  SELECT 
    CASE 
      WHEN auth.uid() = target_user_id THEN true
      WHEN EXISTS (
        SELECT 1 FROM public.profiles 
        WHERE user_id = auth.uid() 
        AND role IN ('super_admin', 'admin', 'senior_manager', 'manager')
      ) THEN true
      WHEN public.can_user_manage(auth.uid(), target_user_id) THEN true
      ELSE false
    END;
$$;

-- Step 2: RLS Policies for contacts table
CREATE POLICY "Users can view contacts they created or are assigned to"
ON public.contacts FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR 
    auth.uid() = assigned_to OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by) OR
    public.can_user_manage(auth.uid(), assigned_to)
  )
);

CREATE POLICY "Users can create contacts"
ON public.contacts FOR INSERT
WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update contacts they manage"
ON public.contacts FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR 
    auth.uid() = assigned_to OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by) OR
    public.can_user_manage(auth.uid(), assigned_to)
  )
);

CREATE POLICY "Admins can delete contacts"
ON public.contacts FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 3: RLS Policies for demo_requests table
CREATE POLICY "Users can view demo requests they manage"
ON public.demo_requests FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR 
    auth.uid() = assigned_to OR
    auth.uid() = demo_performed_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by) OR
    public.can_user_manage(auth.uid(), assigned_to)
  )
);

CREATE POLICY "Users can create demo requests"
ON public.demo_requests FOR INSERT
WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update demo requests they manage"
ON public.demo_requests FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR 
    auth.uid() = assigned_to OR
    auth.uid() = demo_performed_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by) OR
    public.can_user_manage(auth.uid(), assigned_to)
  )
);

CREATE POLICY "Admins can delete demo requests"
ON public.demo_requests FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 4: RLS Policies for call_recordings table
CREATE POLICY "Users can view call recordings they made or manage"
ON public.call_recordings FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = caller_id OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), caller_id)
  )
);

CREATE POLICY "Users can create call recordings"
ON public.call_recordings FOR INSERT
WITH CHECK (auth.uid() = caller_id);

CREATE POLICY "Users can update their call recordings"
ON public.call_recordings FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = caller_id OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), caller_id)
  )
);

CREATE POLICY "Admins can delete call recordings"
ON public.call_recordings FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 5: RLS Policies for call_notes table
CREATE POLICY "Users can view call notes for recordings they access"
ON public.call_notes FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR
    EXISTS (
      SELECT 1 FROM public.call_recordings cr 
      WHERE cr.id = call_recording_id 
      AND (cr.caller_id = auth.uid() OR public.can_user_manage(auth.uid(), cr.caller_id))
    ) OR
    public.get_current_user_role() IN ('super_admin', 'admin')
  )
);

CREATE POLICY "Users can create call notes"
ON public.call_notes FOR INSERT
WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update their call notes"
ON public.call_notes FOR UPDATE
USING (auth.uid() = created_by OR public.get_current_user_role() IN ('super_admin', 'admin'));

CREATE POLICY "Users can delete their call notes"
ON public.call_notes FOR DELETE
USING (auth.uid() = created_by OR public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 6: RLS Policies for communications table
CREATE POLICY "Users can view communications they created or manage"
ON public.communications FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by)
  )
);

CREATE POLICY "Users can create communications"
ON public.communications FOR INSERT
WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update communications they created"
ON public.communications FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = created_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), created_by)
  )
);

CREATE POLICY "Admins can delete communications"
ON public.communications FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 7: RLS Policies for pipeline_stages table
CREATE POLICY "All authenticated users can view pipeline stages"
ON public.pipeline_stages FOR SELECT
USING (auth.uid() IS NOT NULL);

CREATE POLICY "Admins can manage pipeline stages"
ON public.pipeline_stages FOR ALL
USING (public.get_current_user_role() IN ('super_admin', 'admin'))
WITH CHECK (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 8: RLS Policies for contact_pipeline table
CREATE POLICY "Users can view contact pipeline for contacts they manage"
ON public.contact_pipeline FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = moved_by OR
    EXISTS (
      SELECT 1 FROM public.contacts c 
      WHERE c.id = contact_id 
      AND (c.created_by = auth.uid() OR c.assigned_to = auth.uid() OR public.can_user_manage(auth.uid(), c.created_by))
    ) OR
    public.get_current_user_role() IN ('super_admin', 'admin')
  )
);

CREATE POLICY "Users can create contact pipeline entries"
ON public.contact_pipeline FOR INSERT
WITH CHECK (auth.uid() = moved_by);

CREATE POLICY "Users can update contact pipeline entries"
ON public.contact_pipeline FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = moved_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    EXISTS (
      SELECT 1 FROM public.contacts c 
      WHERE c.id = contact_id 
      AND (c.created_by = auth.uid() OR c.assigned_to = auth.uid())
    )
  )
);

CREATE POLICY "Admins can delete contact pipeline entries"
ON public.contact_pipeline FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 9: RLS Policies for crm_tasks table
CREATE POLICY "Users can view tasks assigned to them or created by them"
ON public.crm_tasks FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = assigned_to OR 
    auth.uid() = created_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), assigned_to) OR
    public.can_user_manage(auth.uid(), created_by)
  )
);

CREATE POLICY "Users can create CRM tasks"
ON public.crm_tasks FOR INSERT
WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update tasks they manage"
ON public.crm_tasks FOR UPDATE
USING (
  auth.uid() IS NOT NULL AND (
    auth.uid() = assigned_to OR 
    auth.uid() = created_by OR
    public.get_current_user_role() IN ('super_admin', 'admin') OR
    public.can_user_manage(auth.uid(), assigned_to) OR
    public.can_user_manage(auth.uid(), created_by)
  )
);

CREATE POLICY "Admins can delete CRM tasks"
ON public.crm_tasks FOR DELETE
USING (public.get_current_user_role() IN ('super_admin', 'admin'));

-- Step 10: Storage policies for call recordings
CREATE POLICY "Users can view call recordings they made or manage"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'call-recordings' AND (
    auth.uid()::text = (storage.foldername(name))[1] OR
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE user_id = auth.uid() 
      AND role IN ('super_admin', 'admin')
    )
  )
);

CREATE POLICY "Users can upload their call recordings"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'call-recordings' AND 
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can update their call recordings"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'call-recordings' AND (
    auth.uid()::text = (storage.foldername(name))[1] OR
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE user_id = auth.uid() 
      AND role IN ('super_admin', 'admin')
    )
  )
);

CREATE POLICY "Admins can delete call recordings"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'call-recordings' AND
  EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE user_id = auth.uid() 
    AND role IN ('super_admin', 'admin')
  )
);

-- Step 11: Update function search paths for security
CREATE OR REPLACE FUNCTION public.set_hierarchy_level()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
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
$$;

CREATE OR REPLACE FUNCTION public.calculate_total_hours()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public'
AS $$
BEGIN
    IF NEW.punch_out IS NOT NULL THEN
        NEW.total_hours = EXTRACT(EPOCH FROM (NEW.punch_out - NEW.punch_in)) / 3600;
    END IF;
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public', 'auth'
AS $$
BEGIN
    INSERT INTO public.profiles (user_id, full_name, role)
    VALUES (
        NEW.id, 
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email), 
        'salesperson'
    );
    RETURN NEW;
END;
$$;