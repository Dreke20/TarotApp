-- Promo codes are not a client-readable catalog and are not an entitlement.
-- verify-subscription rejects redeem_promo. This migration removes the
-- SELECT policies that let any signed-in user list active codes, revokes
-- table grants from anon and authenticated, and deletes any rows left from
-- the original seed. RLS stays enabled, so the default is deny.
--
-- There is no redeem function. A future redeem path must be a SECURITY
-- DEFINER function with search_path set, rate-limited, and single-use per
-- user, and it must not grant SELECT on this table to clients.

DROP POLICY IF EXISTS "Authenticated users can query active promo codes" ON public.promo_codes;
DROP POLICY IF EXISTS "Users can view their own promo redemptions" ON public.promo_redemptions;

REVOKE ALL ON TABLE public.promo_codes FROM PUBLIC;
REVOKE ALL ON TABLE public.promo_codes FROM anon;
REVOKE ALL ON TABLE public.promo_codes FROM authenticated;

REVOKE ALL ON TABLE public.promo_redemptions FROM PUBLIC;
REVOKE ALL ON TABLE public.promo_redemptions FROM anon;
REVOKE ALL ON TABLE public.promo_redemptions FROM authenticated;

ALTER TABLE public.promo_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.promo_redemptions ENABLE ROW LEVEL SECURITY;

DELETE FROM public.promo_redemptions;
DELETE FROM public.promo_codes;
