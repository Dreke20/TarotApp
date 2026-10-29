-- Store Google Play expiry and stop clients from writing it.
-- A null pro_expires_at means lifetime Pro. A timestamp in the past means
-- the subscription is over even if is_pro has not been cleared yet.
-- Edge Functions decide Pro with: is_pro AND (pro_expires_at IS NULL OR pro_expires_at > now()).

ALTER TABLE public.profiles
    ADD COLUMN IF NOT EXISTS pro_expires_at TIMESTAMPTZ;

ALTER TABLE public.purchase_receipt_audit
    ADD COLUMN IF NOT EXISTS expires_at TIMESTAMPTZ;

COMMENT ON COLUMN public.profiles.pro_expires_at IS
    'UTC expiry from Google Play. Null is lifetime. Past means not Pro.';

CREATE OR REPLACE FUNCTION public.guard_profile_privileged_columns()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
    IF current_user IN ('anon', 'authenticated') THEN
        IF TG_OP = 'INSERT' THEN
            NEW.is_pro := false;
            NEW.pro_expires_at := NULL;
        ELSE
            NEW.is_pro := OLD.is_pro;
            NEW.pro_expires_at := OLD.pro_expires_at;
        END IF;
    END IF;

    IF TG_OP = 'UPDATE' THEN
        NEW.updated_at := timezone('utc'::text, now());
    END IF;

    RETURN NEW;
END;
$$;

-- Service role only. Edge Functions pass the user id from auth.getUser.
CREATE OR REPLACE FUNCTION public.profile_pro_active(p_user_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = ''
AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.profiles
        WHERE id = p_user_id
          AND is_pro
          AND (pro_expires_at IS NULL OR pro_expires_at > timezone('utc'::text, now()))
    );
$$;

REVOKE ALL ON FUNCTION public.profile_pro_active(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.profile_pro_active(UUID) FROM anon;
REVOKE ALL ON FUNCTION public.profile_pro_active(UUID) FROM authenticated;
GRANT EXECUTE ON FUNCTION public.profile_pro_active(UUID) TO service_role;
