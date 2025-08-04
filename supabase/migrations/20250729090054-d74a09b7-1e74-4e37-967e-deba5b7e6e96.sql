-- Enable RLS on tables that are missing it
ALTER TABLE public.demo_status_changes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.demo_notes ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for demo_status_changes
CREATE POLICY "Users can view status changes for demos they manage"
ON public.demo_status_changes
FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    EXISTS (
      SELECT 1 FROM demos d 
      WHERE d.id = demo_status_changes.demo_id 
      AND (d.assigned_to = auth.uid() OR d.created_by = auth.uid())
    ) OR
    get_current_user_role() = ANY(ARRAY['super_admin', 'admin'])
  )
);

CREATE POLICY "Users can create status changes for demos they manage"
ON public.demo_status_changes
FOR INSERT
WITH CHECK (
  auth.uid() = changed_by AND
  EXISTS (
    SELECT 1 FROM demos d 
    WHERE d.id = demo_status_changes.demo_id 
    AND (d.assigned_to = auth.uid() OR d.created_by = auth.uid())
  )
);

-- Create RLS policies for demo_notes
CREATE POLICY "Users can view notes for demos they manage"
ON public.demo_notes
FOR SELECT
USING (
  auth.uid() IS NOT NULL AND (
    EXISTS (
      SELECT 1 FROM demos d 
      WHERE d.id = demo_notes.demo_id 
      AND (d.assigned_to = auth.uid() OR d.created_by = auth.uid())
    ) OR
    get_current_user_role() = ANY(ARRAY['super_admin', 'admin'])
  )
);

CREATE POLICY "Users can create notes for demos they manage"
ON public.demo_notes
FOR INSERT
WITH CHECK (
  auth.uid() = created_by AND
  EXISTS (
    SELECT 1 FROM demos d 
    WHERE d.id = demo_notes.demo_id 
    AND (d.assigned_to = auth.uid() OR d.created_by = auth.uid())
  )
);