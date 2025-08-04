-- Create activities table
CREATE TABLE public.activities (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id UUID NOT NULL,
  activity_name TEXT NOT NULL,
  description TEXT,
  start_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  end_time TIMESTAMP WITH TIME ZONE,
  status TEXT NOT NULL DEFAULT 'active', -- active, completed, paused
  start_latitude NUMERIC NOT NULL,
  start_longitude NUMERIC NOT NULL,
  end_latitude NUMERIC,
  end_longitude NUMERIC,
  total_duration_minutes INTEGER,
  attendance_id UUID, -- Link to attendance record
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create activity_transitions table for tracking activity switches
CREATE TABLE public.activity_transitions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id UUID NOT NULL,
  from_activity_id UUID,
  to_activity_id UUID NOT NULL,
  transition_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  latitude NUMERIC NOT NULL,
  longitude NUMERIC NOT NULL,
  transition_type TEXT NOT NULL, -- start, switch, end, pause, resume
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activity_transitions ENABLE ROW LEVEL SECURITY;

-- RLS Policies for activities
CREATE POLICY "Users can view their own activities" 
ON public.activities 
FOR SELECT 
USING (auth.uid() = profile_id);

CREATE POLICY "Users can create their own activities" 
ON public.activities 
FOR INSERT 
WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Users can update their own activities" 
ON public.activities 
FOR UPDATE 
USING (auth.uid() = profile_id);

CREATE POLICY "Managers can view subordinate activities" 
ON public.activities 
FOR SELECT 
USING (
  auth.uid() = profile_id OR 
  EXISTS (
    SELECT 1 FROM profiles 
    WHERE user_id = auth.uid() 
    AND role IN ('super_admin', 'admin')
  ) OR 
  can_user_manage(auth.uid(), profile_id)
);

-- RLS Policies for activity_transitions
CREATE POLICY "Users can view their own activity transitions" 
ON public.activity_transitions 
FOR SELECT 
USING (auth.uid() = profile_id);

CREATE POLICY "Users can create their own activity transitions" 
ON public.activity_transitions 
FOR INSERT 
WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Managers can view subordinate activity transitions" 
ON public.activity_transitions 
FOR SELECT 
USING (
  auth.uid() = profile_id OR 
  EXISTS (
    SELECT 1 FROM profiles 
    WHERE user_id = auth.uid() 
    AND role IN ('super_admin', 'admin')
  ) OR 
  can_user_manage(auth.uid(), profile_id)
);

-- Create function to update activity duration
CREATE OR REPLACE FUNCTION public.update_activity_duration()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.end_time IS NOT NULL AND NEW.start_time IS NOT NULL THEN
    NEW.total_duration_minutes = EXTRACT(EPOCH FROM (NEW.end_time - NEW.start_time)) / 60;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic duration calculation
CREATE TRIGGER update_activity_duration_trigger
BEFORE UPDATE ON public.activities
FOR EACH ROW
EXECUTE FUNCTION public.update_activity_duration();

-- Create function to get user's current activity
CREATE OR REPLACE FUNCTION public.get_current_activity(user_profile_id UUID)
RETURNS TABLE(
  id UUID,
  activity_name TEXT,
  description TEXT,
  start_time TIMESTAMP WITH TIME ZONE,
  status TEXT,
  start_latitude NUMERIC,
  start_longitude NUMERIC
)
LANGUAGE SQL
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    a.id,
    a.activity_name,
    a.description,
    a.start_time,
    a.status,
    a.start_latitude,
    a.start_longitude
  FROM activities a
  WHERE a.profile_id = user_profile_id 
    AND a.status = 'active'
  ORDER BY a.start_time DESC
  LIMIT 1;
$$;

-- Create function to get user activities for date range
CREATE OR REPLACE FUNCTION public.get_user_activities_for_date(
  user_profile_id UUID,
  start_date DATE,
  end_date DATE
)
RETURNS TABLE(
  id UUID,
  activity_name TEXT,
  description TEXT,
  start_time TIMESTAMP WITH TIME ZONE,
  end_time TIMESTAMP WITH TIME ZONE,
  status TEXT,
  start_latitude NUMERIC,
  start_longitude NUMERIC,
  end_latitude NUMERIC,
  end_longitude NUMERIC,
  total_duration_minutes INTEGER
)
LANGUAGE SQL
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    a.id,
    a.activity_name,
    a.description,
    a.start_time,
    a.end_time,
    a.status,
    a.start_latitude,
    a.start_longitude,
    a.end_latitude,
    a.end_longitude,
    a.total_duration_minutes
  FROM activities a
  WHERE a.profile_id = user_profile_id 
    AND DATE(a.start_time) >= start_date
    AND DATE(a.start_time) <= end_date
  ORDER BY a.start_time DESC;
$$;

-- Add updated_at trigger
CREATE TRIGGER update_activities_updated_at
BEFORE UPDATE ON public.activities
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_activity_transitions_updated_at
BEFORE UPDATE ON public.activity_transitions
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();