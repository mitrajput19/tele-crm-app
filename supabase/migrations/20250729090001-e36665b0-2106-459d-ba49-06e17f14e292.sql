-- Update the cron job to run at 11:59 PM every day
SELECT cron.unschedule('auto-punch-out');

SELECT cron.schedule(
    'auto-punch-out',
    '59 23 * * *', -- 11:59 PM every day
    $$
    SELECT auto_punch_out_system();
    $$
);