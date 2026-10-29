-- Reports of AI output. The app inserts through submit_ai_report, which
-- runs as the caller so the INSERT policy applies. There is no SELECT
-- policy, and authenticated has no SELECT grant, so clients cannot read
-- reports. Review them in the dashboard with the service role.

CREATE TABLE IF NOT EXISTS public.ai_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    reason TEXT NOT NULL CHECK (char_length(reason) BETWEEN 1 AND 200),
    reading_id TEXT,
    excerpt TEXT CHECK (excerpt IS NULL OR char_length(excerpt) <= 500),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

ALTER TABLE public.ai_reports ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE public.ai_reports FROM PUBLIC;
REVOKE ALL ON TABLE public.ai_reports FROM anon;
REVOKE ALL ON TABLE public.ai_reports FROM authenticated;
GRANT INSERT ON TABLE public.ai_reports TO authenticated;
GRANT SELECT, INSERT, DELETE ON TABLE public.ai_reports TO service_role;

CREATE POLICY "Users insert their own AI reports"
ON public.ai_reports
FOR INSERT
TO authenticated
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE OR REPLACE FUNCTION public.submit_ai_report(
    p_reason TEXT,
    p_reading_id TEXT DEFAULT NULL,
    p_excerpt TEXT DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
    uid UUID := auth.uid();
    clean_reason TEXT := left(btrim(COALESCE(p_reason, '')), 200);
BEGIN
    IF uid IS NULL THEN
        RAISE EXCEPTION 'not authenticated';
    END IF;
    IF char_length(clean_reason) = 0 THEN
        RAISE EXCEPTION 'reason required';
    END IF;

    INSERT INTO public.ai_reports (user_id, reason, reading_id, excerpt)
    VALUES (
        uid,
        clean_reason,
        NULLIF(left(btrim(COALESCE(p_reading_id, '')), 80), ''),
        NULLIF(left(btrim(COALESCE(p_excerpt, '')), 500), '')
    );
END;
$$;

REVOKE ALL ON FUNCTION public.submit_ai_report(TEXT, TEXT, TEXT) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.submit_ai_report(TEXT, TEXT, TEXT) FROM anon;
GRANT EXECUTE ON FUNCTION public.submit_ai_report(TEXT, TEXT, TEXT) TO authenticated;
