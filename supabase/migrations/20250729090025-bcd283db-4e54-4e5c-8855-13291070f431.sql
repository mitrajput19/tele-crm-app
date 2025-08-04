-- Enable pg_cron extension if not already enabled
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule the auto punch-out job to run at 11:59 PM every day
SELECT cron.schedule(
    'auto-punch-out',
    '59 23 * * *', -- 11:59 PM every day
    $$
    SELECT auto_punch_out_system();
    $$
);