-- Update existing demos table to support lead management features
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS campaign_id UUID;
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS lead_score INTEGER DEFAULT 0;
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS stage TEXT DEFAULT 'new';
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS priority TEXT DEFAULT 'medium';
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS last_contact_date TIMESTAMP WITH TIME ZONE;
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS custom_fields JSONB DEFAULT '{}';
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS tags TEXT[];
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS is_duplicate BOOLEAN DEFAULT false;
ALTER TABLE public.demos ADD COLUMN IF NOT EXISTS duplicate_of UUID;

-- Create demo_uploads table for tracking Excel uploads (renaming lead_uploads)
CREATE TABLE IF NOT EXISTS public.demo_uploads (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  campaign_id UUID,
  file_name TEXT NOT NULL,
  file_path TEXT,
  total_records INTEGER DEFAULT 0,
  valid_records INTEGER DEFAULT 0,
  duplicate_records INTEGER DEFAULT 0,
  error_records INTEGER DEFAULT 0,
  upload_status TEXT DEFAULT 'processing',
  uploaded_by UUID NOT NULL,
  upload_logs JSONB DEFAULT '[]',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create demo_activities table for tracking interactions (renaming lead_activities)
CREATE TABLE IF NOT EXISTS public.demo_activities (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  demo_id UUID NOT NULL,
  activity_type TEXT NOT NULL,
  subject TEXT,
  description TEXT,
  status TEXT DEFAULT 'completed',
  scheduled_at TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  duration_minutes INTEGER,
  outcome TEXT,
  notes TEXT,
  created_by UUID NOT NULL,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Update call_sessions to reference demo_id instead of lead_id
ALTER TABLE public.call_sessions ADD COLUMN IF NOT EXISTS demo_id UUID;

-- Create demo_stages table for pipeline management (renaming lead_stages)
CREATE TABLE IF NOT EXISTS public.demo_stages (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  stage_order INTEGER NOT NULL,
  is_closed BOOLEAN DEFAULT false,
  is_won BOOLEAN DEFAULT false,
  probability_percentage INTEGER DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Insert default demo stages
INSERT INTO public.demo_stages (name, stage_order, probability_percentage) VALUES
('Fresh Lead', 1, 10),
('Contacted', 2, 25),
('Qualified', 3, 50),
('Demo Scheduled', 4, 75),
('Proposal Sent', 5, 85),
('Negotiation', 6, 90),
('Closed Won', 7, 100),
('Closed Lost', 8, 0)
ON CONFLICT DO NOTHING;

-- Enable RLS on new tables
ALTER TABLE public.demo_uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.demo_activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.demo_stages ENABLE ROW LEVEL SECURITY;

-- RLS Policies for demo_uploads
CREATE POLICY "Users can view their uploads" ON public.demo_uploads
FOR SELECT USING (
  auth.uid() = uploaded_by OR
  get_current_user_role() = ANY(ARRAY['super_admin', 'admin', 'senior_manager', 'manager'])
);

CREATE POLICY "Users can create uploads" ON public.demo_uploads
FOR INSERT WITH CHECK (auth.uid() = uploaded_by);

-- RLS Policies for demo_activities
CREATE POLICY "Users can view activities for demos they manage" ON public.demo_activities
FOR SELECT USING (
  auth.uid() = created_by OR
  EXISTS (
    SELECT 1 FROM demos d 
    WHERE d.id = demo_activities.demo_id 
    AND (
      d.assigned_to = auth.uid() OR 
      d.created_by = auth.uid() OR
      can_user_manage(auth.uid(), d.assigned_to) OR
      can_user_manage(auth.uid(), d.created_by)
    )
  ) OR
  get_current_user_role() = ANY(ARRAY['super_admin', 'admin'])
);

CREATE POLICY "Users can create activities" ON public.demo_activities
FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update their activities" ON public.demo_activities
FOR UPDATE USING (auth.uid() = created_by);

-- RLS Policies for demo_stages
CREATE POLICY "All authenticated users can view demo stages" ON public.demo_stages
FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Admins can manage demo stages" ON public.demo_stages
FOR ALL USING (get_current_user_role() = ANY(ARRAY['super_admin', 'admin']))
WITH CHECK (get_current_user_role() = ANY(ARRAY['super_admin', 'admin']));

-- Update call_sessions RLS to include demo_id
DROP POLICY IF EXISTS "Users can view call sessions they made or manage" ON public.call_sessions;
CREATE POLICY "Users can view call sessions they made or manage" ON public.call_sessions
FOR SELECT USING (
  auth.uid() = caller_id OR
  EXISTS (
    SELECT 1 FROM leads l 
    WHERE l.id = call_sessions.lead_id 
    AND (
      l.assigned_to = auth.uid() OR 
      can_user_manage(auth.uid(), l.assigned_to)
    )
  ) OR
  EXISTS (
    SELECT 1 FROM demos d 
    WHERE d.id = call_sessions.demo_id 
    AND (
      d.assigned_to = auth.uid() OR 
      can_user_manage(auth.uid(), d.assigned_to)
    )
  ) OR
  get_current_user_role() = ANY(ARRAY['super_admin', 'admin'])
);