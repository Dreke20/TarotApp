import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

interface SubscriptionRequest {
  action?: "subscribe" | "redeem_promo" | "restore_purchase";
  plan?: "yearly" | "monthly" | "lifetime";
  receipt?: string;
  promo_code?: string;
}

const VALID_PROMO_CODES = new Set([
  "CELESTIAL_PRO",
  "ORACULUM_2026",
  "MYSTIC_SEEKER",
  "COSMIC_LIFETIME",
]);

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({
          error: "Authorization header required. Please sign in to activate Oracle Pro.",
        }),
        {
          status: 401,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
    const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!supabaseUrl || !supabaseAnonKey || !supabaseServiceRoleKey) {
      return new Response(
        JSON.stringify({ error: "Server configuration error (missing keys)." }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 1. Verify user identity using their auth token
    const clientAuth = createClient(supabaseUrl, supabaseAnonKey, {
      global: { headers: { Authorization: authHeader } },
    });

    const {
      data: { user },
      error: userError,
    } = await clientAuth.auth.getUser();

    if (userError || !user) {
      return new Response(
        JSON.stringify({
          error: "Invalid or expired session. Please sign in to verify membership.",
        }),
        {
          status: 401,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 2. Parse request payload
    const body: SubscriptionRequest = await req.json().catch(() => ({}));
    const action = body.action || "subscribe";
    const plan = body.plan || "yearly";

    // 3. Validation logic
    let verified = false;
    let message = "";

    if (action === "redeem_promo") {
      const code = (body.promo_code || "").trim().toUpperCase();
      if (VALID_PROMO_CODES.has(code)) {
        verified = true;
        message = `Cosmic blessing accepted! Promo code '${code}' granted Oracle Pro access.`;
      } else {
        return new Response(
          JSON.stringify({
            error: "The celestial promo code provided is invalid or expired.",
          }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }
    } else if (action === "subscribe" || action === "restore_purchase") {
      // In production, validate Apple StoreKit 2 or Google Play Billing purchase token.
      // For development/store-sandbox: simulate successful receipt validation.
      verified = true;
      message = action === "restore_purchase"
        ? "Oracle Pro membership successfully restored from celestial records."
        : `Welcome to Oracle Pro (${plan} plan)! All celestial decks, spreads, and prophecies are unlocked.`;
    }

    if (!verified) {
      return new Response(
        JSON.stringify({ error: "Purchase verification failed." }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 4. Update the profile using SERVICE_ROLE_KEY to bypass client trigger restriction
    const adminClient = createClient(supabaseUrl, supabaseServiceRoleKey);

    const { error: updateError } = await adminClient
      .from("profiles")
      .update({
        is_pro: true,
        updated_at: new Date().toISOString(),
      })
      .eq("id", user.id);

    if (updateError) {
      console.error("Failed to update profile to Pro:", updateError);
      return new Response(
        JSON.stringify({ error: "Failed to persist Oracle Pro status in database." }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    return new Response(
      JSON.stringify({
        success: true,
        is_pro: true,
        plan: plan,
        message: message,
        user_id: user.id,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : String(err);
    console.error("Unhandled error in verify-subscription:", message);
    return new Response(JSON.stringify({ error: message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
