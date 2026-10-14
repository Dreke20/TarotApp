-- =============================================================================
-- Security hardening & schema sync
-- -----------------------------------------------------------------------------
-- 1. Adds columns the Flutter models already write but the DB was missing
--    (profiles: moon_sign, rising_sign, is_pro | readings: notes, is_favorite).
-- 2. Replaces over-permissive RLS policies:
--    - profiles were world-readable (leaked every user's email)
--    - readings were readable by any anonymous request and insertable for
--      arbitrary user_ids; no UPDATE policy existed for notes/favorites.
-- 3. Protects privileged columns (is_pro) from client-side tampering via a
--    trigger. Only service_role / postgres (Edge Functions, payment webhooks,
--    dashboard) can change is_pro.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Schema sync
-- -----------------------------------------------------------------------------
ALTER TABLE public.profiles
    ADD COLUMN IF NOT EXISTS moon_sign   TEXT,
    ADD COLUMN IF NOT EXISTS rising_sign TEXT,
    ADD COLUMN IF NOT EXISTS is_pro      BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE public.readings
    ADD COLUMN IF NOT EXISTS notes       TEXT    NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS is_favorite BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_readings_user_favorite
    ON public.readings(user_id, is_favorite);

-- -----------------------------------------------------------------------------
-- 2a. Profiles RLS: owner-only access
-- -----------------------------------------------------------------------------
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON public.profiles;
DROP POLICY IF EXISTS "Users can insert their own profile"      ON public.profiles;
DROP POLICY IF EXISTS "Users can update their own profile"      ON public.profiles;

CREATE POLICY "Users can view their own profile"
ON public.profiles FOR SELECT
TO authenticated
USING ((SELECT auth.uid()) = id);

CREATE POLICY "Users can insert their own profile"
ON public.profiles FOR INSERT
TO authenticated
WITH CHECK ((SELECT auth.uid()) = id);

CREATE POLICY "Users can update their own profile"
ON public.profiles FOR UPDATE
TO authenticated
USING ((SELECT auth.uid()) = id)
WITH CHECK ((SELECT auth.uid()) = id);

-- -----------------------------------------------------------------------------
-- 2b. Readings RLS: owner-only access
-- Guest (signed-out) readings stay on-device and are never sent to the cloud.
-- -----------------------------------------------------------------------------
ALTER TABLE public.readings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view their own readings or guest readings" ON public.readings;
DROP POLICY IF EXISTS "Anyone can insert readings"                         ON public.readings;
DROP POLICY IF EXISTS "Users can delete their own readings"                ON public.readings;

CREATE POLICY "Users can view their own readings"
ON public.readings FOR SELECT
TO authenticated
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can insert their own readings"
ON public.readings FOR INSERT
TO authenticated
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update their own readings"
ON public.readings FOR UPDATE
TO authenticated
USING ((SELECT auth.uid()) = user_id)
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete their own readings"
ON public.readings FOR DELETE
TO authenticated
USING ((SELECT auth.uid()) = user_id);

-- -----------------------------------------------------------------------------
-- 3. Privileged column guard for profiles
-- Not SECURITY DEFINER on purpose: current_user reflects the PostgREST role
-- ('anon' / 'authenticated' for app clients, 'service_role' for Edge
-- Functions, 'postgres' for the dashboard SQL editor).
-- Client writes to is_pro are silently ignored so full-row upserts from the
-- app keep working for the other columns.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.guard_profile_privileged_columns()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
    IF current_user IN ('anon', 'authenticated') THEN
        IF TG_OP = 'INSERT' THEN
            NEW.is_pro := false;
        ELSE
            NEW.is_pro := OLD.is_pro;
        END IF;
    END IF;

    IF TG_OP = 'UPDATE' THEN
        NEW.updated_at := timezone('utc'::text, now());
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_guard_profile_privileged_columns ON public.profiles;
CREATE TRIGGER trg_guard_profile_privileged_columns
BEFORE INSERT OR UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.guard_profile_privileged_columns();
