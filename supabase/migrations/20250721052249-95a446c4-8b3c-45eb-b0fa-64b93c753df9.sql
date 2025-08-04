-- Add columns for selfie images and location to attendance table
ALTER TABLE public.attendance 
ADD COLUMN punch_in_image_url TEXT,
ADD COLUMN punch_in_latitude DECIMAL(10, 8),
ADD COLUMN punch_in_longitude DECIMAL(11, 8),
ADD COLUMN punch_out_image_url TEXT,
ADD COLUMN punch_out_latitude DECIMAL(10, 8),
ADD COLUMN punch_out_longitude DECIMAL(11, 8);

-- Create storage bucket for attendance selfies
INSERT INTO storage.buckets (id, name, public) VALUES ('attendance-selfies', 'attendance-selfies', true);

-- Create storage policies for attendance selfies
CREATE POLICY "Users can upload their own attendance selfies" 
ON storage.objects 
FOR INSERT 
WITH CHECK (bucket_id = 'attendance-selfies' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "Users can view their own attendance selfies" 
ON storage.objects 
FOR SELECT 
USING (bucket_id = 'attendance-selfies' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "Attendance selfies are publicly viewable" 
ON storage.objects 
FOR SELECT 
USING (bucket_id = 'attendance-selfies');