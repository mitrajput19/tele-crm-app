-- Fix Security Issues and Create CRM System with Demo Management and Call Recording (Fixed)

-- Step 1: Fix existing security issues - Enable RLS on all tables (if not already enabled)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.demos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_managers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_hierarchy ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.organizational_units ENABLE ROW LEVEL SECURITY;

-- Step 2: Create CRM Core Tables

-- Contacts/Leads table (enhanced from existing demos)
CREATE TABLE public.contacts (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE,
  phone TEXT,
  alternate_phone TEXT,
  company_name TEXT,
  job_title TEXT,
  address TEXT,
  city TEXT,
  state TEXT,
  country TEXT DEFAULT 'India',
  postal_code TEXT,
  source TEXT, -- website, referral, cold_call, marketing, etc.
  lead_score INTEGER DEFAULT 0,
  status TEXT DEFAULT 'new', -- new, contacted, qualified, demo_scheduled, demo_completed, customer, lost
  assigned_to UUID REFERENCES public.profiles(user_id),
  created_by UUID NOT NULL REFERENCES public.profiles(user_id),
  notes TEXT,
  last_contact_date TIMESTAMPTZ,
  next_follow_up TIMESTAMPTZ,
  tags TEXT[],
  custom_fields JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Demo Management table (enhanced)
CREATE TABLE public.demo_requests (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id UUID NOT NULL REFERENCES public.contacts(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT 'Product Demo',
  demo_type TEXT DEFAULT 'online', -- online, onsite, phone
  scheduled_date TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  demo_link TEXT, -- for online demos
  meeting_location TEXT, -- for onsite demos
  status TEXT DEFAULT 'scheduled', -- scheduled, completed, no_show, rescheduled, cancelled
  outcome TEXT, -- interested, not_interested, follow_up_needed, converted, rescheduled
  demo_performed_by UUID REFERENCES public.profiles(user_id),
  assigned_to UUID NOT NULL REFERENCES public.profiles(user_id),
  created_by UUID NOT NULL REFERENCES public.profiles(user_id),
  preparation_notes TEXT,
  demo_notes TEXT,
  follow_up_required BOOLEAN DEFAULT false,
  follow_up_date TIMESTAMPTZ,
  conversion_probability INTEGER CHECK (conversion_probability >= 0 AND conversion_probability <= 100),
  demo_materials JSONB DEFAULT '[]', -- array of file references
  attendees JSONB DEFAULT '[]', -- array of attendee objects
  feedback_rating INTEGER CHECK (feedback_rating >= 1 AND feedback_rating <= 5),
  feedback_comments TEXT,
  recording_consent BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Call Recording and Management
CREATE TABLE public.call_recordings (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id UUID REFERENCES public.contacts(id) ON DELETE SET NULL,
  demo_request_id UUID REFERENCES public.demo_requests(id) ON DELETE SET NULL,
  caller_id UUID NOT NULL REFERENCES public.profiles(user_id),
  call_type TEXT DEFAULT 'outbound', -- inbound, outbound, demo, follow_up
  phone_number TEXT NOT NULL,
  call_direction TEXT DEFAULT 'outbound', -- inbound, outbound
  call_status TEXT DEFAULT 'completed', -- completed, missed, failed, busy, no_answer
  start_time TIMESTAMPTZ NOT NULL DEFAULT now(),
  end_time TIMESTAMPTZ,
  duration_seconds INTEGER,
  recording_file_url TEXT, -- URL to audio file in storage
  recording_file_path TEXT, -- storage bucket path
  file_size_bytes BIGINT,
  audio_format TEXT DEFAULT 'mp3', -- mp3, wav, m4a
  transcription_text TEXT,
  transcription_status TEXT DEFAULT 'pending', -- pending, processing, completed, failed
  call_outcome TEXT, -- interested, not_interested, callback_requested, demo_scheduled, converted
  call_quality_rating INTEGER CHECK (call_quality_rating >= 1 AND call_quality_rating <= 5),
  call_notes TEXT,
  follow_up_required BOOLEAN DEFAULT false,
  follow_up_date TIMESTAMPTZ,
  tags TEXT[],
  metadata JSONB DEFAULT '{}', -- additional call metadata
  consent_recorded BOOLEAN DEFAULT false,
  is_archived BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Call Notes with Timestamps (for annotation during playback)
CREATE TABLE public.call_notes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  call_recording_id UUID NOT NULL REFERENCES public.call_recordings(id) ON DELETE CASCADE,
  timestamp_seconds INTEGER NOT NULL, -- timestamp in recording
  note_text TEXT NOT NULL,
  note_type TEXT DEFAULT 'general', -- general, action_item, important, follow_up
  created_by UUID NOT NULL REFERENCES public.profiles(user_id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Communication History (emails, SMS, calls, meetings)
CREATE TABLE public.communications (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id UUID NOT NULL REFERENCES public.contacts(id) ON DELETE CASCADE,
  call_recording_id UUID REFERENCES public.call_recordings(id) ON DELETE SET NULL,
  demo_request_id UUID REFERENCES public.demo_requests(id) ON DELETE SET NULL,
  communication_type TEXT NOT NULL, -- call, email, sms, meeting, demo
  direction TEXT DEFAULT 'outbound', -- inbound, outbound
  subject TEXT,
  content TEXT,
  attachments JSONB DEFAULT '[]',
  status TEXT DEFAULT 'completed', -- scheduled, completed, failed, cancelled
  scheduled_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_by UUID NOT NULL REFERENCES public.profiles(user_id),
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- CRM Pipeline Stages (created_by is nullable for system defaults)
CREATE TABLE public.pipeline_stages (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  stage_order INTEGER NOT NULL,
  is_closed BOOLEAN DEFAULT false, -- true for won/lost stages
  is_won BOOLEAN DEFAULT false, -- true for won stages
  probability_percentage INTEGER DEFAULT 0 CHECK (probability_percentage >= 0 AND probability_percentage <= 100),
  created_by UUID REFERENCES public.profiles(user_id), -- nullable for system defaults
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Contact Pipeline tracking
CREATE TABLE public.contact_pipeline (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id UUID NOT NULL REFERENCES public.contacts(id) ON DELETE CASCADE,
  stage_id UUID NOT NULL REFERENCES public.pipeline_stages(id),
  estimated_value DECIMAL(10,2),
  estimated_close_date DATE,
  entered_stage_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  stage_duration_days INTEGER,
  notes TEXT,
  moved_by UUID NOT NULL REFERENCES public.profiles(user_id),
  is_current BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- CRM Tasks and Follow-ups
CREATE TABLE public.crm_tasks (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  contact_id UUID REFERENCES public.contacts(id) ON DELETE CASCADE,
  demo_request_id UUID REFERENCES public.demo_requests(id) ON DELETE CASCADE,
  call_recording_id UUID REFERENCES public.call_recordings(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  description TEXT,
  task_type TEXT DEFAULT 'follow_up', -- follow_up, demo_prep, call_back, email, meeting
  priority TEXT DEFAULT 'medium', -- low, medium, high, urgent
  status TEXT DEFAULT 'pending', -- pending, in_progress, completed, cancelled
  due_date TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  assigned_to UUID NOT NULL REFERENCES public.profiles(user_id),
  created_by UUID NOT NULL REFERENCES public.profiles(user_id),
  reminder_at TIMESTAMPTZ,
  tags TEXT[],
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Step 3: Enable RLS on new tables
ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.demo_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.call_recordings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.call_notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.communications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pipeline_stages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contact_pipeline ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.crm_tasks ENABLE ROW LEVEL SECURITY;

-- Step 4: Create Storage Bucket for Call Recordings
INSERT INTO storage.buckets (id, name, public) 
VALUES ('call-recordings', 'call-recordings', false);

-- Step 5: Create indexes for performance
CREATE INDEX idx_contacts_assigned_to ON public.contacts(assigned_to);
CREATE INDEX idx_contacts_status ON public.contacts(status);
CREATE INDEX idx_contacts_created_by ON public.contacts(created_by);
CREATE INDEX idx_contacts_email ON public.contacts(email);
CREATE INDEX idx_contacts_phone ON public.contacts(phone);

CREATE INDEX idx_demo_requests_contact_id ON public.demo_requests(contact_id);
CREATE INDEX idx_demo_requests_scheduled_date ON public.demo_requests(scheduled_date);
CREATE INDEX idx_demo_requests_status ON public.demo_requests(status);
CREATE INDEX idx_demo_requests_assigned_to ON public.demo_requests(assigned_to);

CREATE INDEX idx_call_recordings_contact_id ON public.call_recordings(contact_id);
CREATE INDEX idx_call_recordings_caller_id ON public.call_recordings(caller_id);
CREATE INDEX idx_call_recordings_start_time ON public.call_recordings(start_time);
CREATE INDEX idx_call_recordings_call_type ON public.call_recordings(call_type);

CREATE INDEX idx_communications_contact_id ON public.communications(contact_id);
CREATE INDEX idx_communications_type ON public.communications(communication_type);
CREATE INDEX idx_communications_created_by ON public.communications(created_by);

CREATE INDEX idx_crm_tasks_assigned_to ON public.crm_tasks(assigned_to);
CREATE INDEX idx_crm_tasks_due_date ON public.crm_tasks(due_date);
CREATE INDEX idx_crm_tasks_status ON public.crm_tasks(status);

-- Step 6: Create triggers for automatic timestamp updates
CREATE TRIGGER update_contacts_updated_at BEFORE UPDATE ON public.contacts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_demo_requests_updated_at BEFORE UPDATE ON public.demo_requests FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_call_recordings_updated_at BEFORE UPDATE ON public.call_recordings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_crm_tasks_updated_at BEFORE UPDATE ON public.crm_tasks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Step 7: Insert default pipeline stages
INSERT INTO public.pipeline_stages (name, description, stage_order, probability_percentage) VALUES
('Lead', 'Initial contact made', 1, 10),
('Qualified', 'Lead has been qualified', 2, 25),
('Demo Scheduled', 'Demo has been scheduled', 3, 40),
('Demo Completed', 'Demo has been conducted', 4, 60),
('Proposal Sent', 'Proposal has been sent', 5, 75),
('Negotiation', 'Price/terms negotiation', 6, 85),
('Won', 'Deal closed successfully', 7, 100),
('Lost', 'Deal lost to competitor or no decision', 8, 0);

-- Update the won/lost flags
UPDATE public.pipeline_stages SET is_closed = true, is_won = true WHERE name = 'Won';
UPDATE public.pipeline_stages SET is_closed = true, is_won = false WHERE name = 'Lost';