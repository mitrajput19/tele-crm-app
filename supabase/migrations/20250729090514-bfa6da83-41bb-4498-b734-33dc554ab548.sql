-- Add quote_amount field to demos table
ALTER TABLE public.demos ADD COLUMN quote_amount NUMERIC;

-- Create demo_status_changes table for tracking status changes with notes
CREATE TABLE public.demo_status_changes (
    id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    demo_id UUID NOT NULL,
    old_status TEXT NOT NULL,
    new_status TEXT NOT NULL,
    changed_by UUID NOT NULL,
    change_reason TEXT,
    postpone_date TIMESTAMP WITH TIME ZONE,
    postpone_note TEXT,
    follow_up_date TIMESTAMP WITH TIME ZONE,
    follow_up_note TEXT,
    not_interested_reason TEXT,
    finalized_amount NUMERIC,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create demo_notes table for additional notes
CREATE TABLE public.demo_notes (
    id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    demo_id UUID NOT NULL,
    note_text TEXT NOT NULL,
    note_type TEXT DEFAULT 'general',
    created_by UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS on new tables
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