-- Add foreign key constraint to demo_status_changes table
ALTER TABLE public.demo_status_changes 
ADD CONSTRAINT fk_demo_status_changes_demo_id 
FOREIGN KEY (demo_id) REFERENCES public.demos(id) ON DELETE CASCADE;

-- Add all required columns to demos table
DO $$ 
BEGIN
    -- Add quote_amount if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'quote_amount'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN quote_amount NUMERIC;
    END IF;
    
    -- Add postpone_date if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'postpone_date'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN postpone_date TIMESTAMP WITH TIME ZONE;
    END IF;
    
    -- Add postpone_note if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'postpone_note'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN postpone_note TEXT;
    END IF;
    
    -- Add follow_up_date if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'follow_up_date'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN follow_up_date TIMESTAMP WITH TIME ZONE;
    END IF;
    
    -- Add follow_up_note if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'follow_up_note'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN follow_up_note TEXT;
    END IF;
    
    -- Add not_interested_reason if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'not_interested_reason'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN not_interested_reason TEXT;
    END IF;
    
    -- Add finalized_amount if not exists
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'demos' AND column_name = 'finalized_amount'
    ) THEN
        ALTER TABLE public.demos ADD COLUMN finalized_amount NUMERIC;
    END IF;
END $$;