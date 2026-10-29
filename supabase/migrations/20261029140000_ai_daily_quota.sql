-- Per-user daily AI reading quota. Clients cannot read or write this table.
-- consume_ai_reading is service-role only. Limits in the Edge Function
-- (FREE_DAILY_READINGS = 3, PRO_DAILY_READINGS = 50) must stay within 1..50.

CREATE TABLE IF NOT EXISTS public.ai_daily_usage (
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    usage_date DATE NOT NULL,
    reading_count INTEGER NOT NULL DEFAULT 0 CHECK (reading_count >= 0),
    PRIMARY KEY (user_id, usage_date)
);

ALTER TABLE public.ai_daily_usage ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE public.ai_daily_usage FROM PUBLIC;
REVOKE ALL ON TABLE public.ai_daily_usage FROM anon;
REVOKE ALL ON TABLE public.ai_daily_usage FROM authenticated;
GRANT SELECT, INSERT, UPDATE ON TABLE public.ai_daily_usage TO service_role;

CREATE OR REPLACE FUNCTION public.consume_ai_reading(p_user_id UUID, p_limit INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
    used INTEGER;
BEGIN
    IF p_user_id IS NULL THEN
        RAISE EXCEPTION 'user id required';
    END IF;
    IF p_limit IS NULL OR p_limit < 1 OR p_limit > 50 THEN
        RAISE EXCEPTION 'invalid daily limit';
    END IF;

    INSERT INTO public.ai_daily_usage AS usage (user_id, usage_date, reading_count)
    VALUES (p_user_id, (timezone('utc', now()))::date, 1)
    ON CONFLICT (user_id, usage_date)
    DO UPDATE
        SET reading_count = usage.reading_count + 1
        WHERE usage.reading_count < p_limit
    RETURNING usage.reading_count INTO used;

    RETURN used;
END;
$$;

REVOKE ALL ON FUNCTION public.consume_ai_reading(UUID, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.consume_ai_reading(UUID, INTEGER) FROM anon;
REVOKE ALL ON FUNCTION public.consume_ai_reading(UUID, INTEGER) FROM authenticated;
GRANT EXECUTE ON FUNCTION public.consume_ai_reading(UUID, INTEGER) TO service_role;
