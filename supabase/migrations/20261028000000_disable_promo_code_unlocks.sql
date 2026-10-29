-- =============================================================================
-- NOT APPLIED. Do not run this against production from the agent workflow.
-- =============================================================================
-- Promo-code unlocks are no longer an entitlement. If 20261027000000 was
-- already applied, this removes every stored code and its redemptions.
-- The verify-subscription source also rejects redeem_promo, but that
-- rejection is live only after the function is redeployed separately.
-- =============================================================================

DELETE FROM public.promo_redemptions;
DELETE FROM public.promo_codes;
