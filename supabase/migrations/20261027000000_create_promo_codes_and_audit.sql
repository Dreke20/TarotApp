-- =============================================================================
-- Migration: Create Promo Codes & Purchase Audit Tables with Strict RLS
-- -----------------------------------------------------------------------------
-- 1. Table: public.promo_codes
--    Stores authorized promo codes, expiration dates, and maximum usage caps.
-- 2. Table: public.promo_redemptions
--    Enforces strict 1-per-user redemption limit via composite unique index.
-- 3. Table: public.purchase_receipt_audit
--    Stores hashed purchase tokens to prevent receipt replay attacks.
-- =============================================================================

CREATE TABLE IF NOT EXISTS public.promo_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code TEXT NOT NULL UNIQUE,
    plan TEXT NOT NULL DEFAULT 'yearly' CHECK (plan IN ('monthly', 'yearly', 'lifetime')),
    max_redemptions INTEGER NOT NULL DEFAULT 500,
    times_redeemed INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT true,
    expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS public.promo_redemptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code_id UUID NOT NULL REFERENCES public.promo_codes(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    redeemed_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    CONSTRAINT uq_user_promo_code UNIQUE (code_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.purchase_receipt_audit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    product_id TEXT NOT NULL,
    receipt_hash TEXT NOT NULL UNIQUE,
    source TEXT NOT NULL DEFAULT 'google_play',
    verified_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.promo_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.promo_redemptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase_receipt_audit ENABLE ROW LEVEL SECURITY;

-- RLS: Authenticated users can view active promo codes for verification
CREATE POLICY "Authenticated users can query active promo codes"
ON public.promo_codes FOR SELECT
TO authenticated
USING (is_active = true AND (expires_at IS NULL OR expires_at > now()));

-- RLS: Users can only see their own redemptions
CREATE POLICY "Users can view their own promo redemptions"
ON public.promo_redemptions FOR SELECT
TO authenticated
USING ((SELECT auth.uid()) = user_id);

-- RLS: Only service_role can insert or update redemptions & audit records
CREATE POLICY "Service role manages promo redemptions"
ON public.promo_redemptions FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

CREATE POLICY "Service role manages purchase receipts"
ON public.purchase_receipt_audit FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

-- Seed initial secure promo codes with caps & expiration
INSERT INTO public.promo_codes (code, plan, max_redemptions, is_active, expires_at)
VALUES 
    ('CELESTIAL_PRO', 'yearly', 100, true, now() + interval '90 days'),
    ('ORACULUM_2026', 'yearly', 250, true, now() + interval '180 days'),
    ('MYSTIC_SEEKER', 'monthly', 500, true, now() + interval '365 days'),
    ('COSMIC_LIFETIME', 'lifetime', 25, true, now() + interval '30 days')
ON CONFLICT (code) DO NOTHING;
