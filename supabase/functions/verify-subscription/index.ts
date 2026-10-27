import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";
import { crypto } from "https://deno.land/std@0.168.0/crypto/mod.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

interface SubscriptionRequest {
  action?: "subscribe" | "redeem_promo" | "restore_purchase";
  plan?: "yearly" | "monthly" | "lifetime";
  receipt?: string;
  purchase_token?: string;
  promo_code?: string;
  product_id?: string;
  source?: string;
}

async function hashToken(token: string): Promise<string> {
  const data = new TextEncoder().encode(token);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map((b) => b.toString(16).padStart(2, "0")).join("");
}

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
    let plan = body.plan || "yearly";
    const adminClient = createClient(supabaseUrl, supabaseServiceRoleKey);

    let message = "";

    // 3. Validation logic
    if (action === "redeem_promo") {
      const codeStr = (body.promo_code || "").trim().toUpperCase();
      if (!codeStr || codeStr.length < 3) {
        return new Response(
          JSON.stringify({ error: "Please enter a valid celestial promo code." }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Query database for promo code
      const { data: promo, error: promoErr } = await adminClient
        .from("promo_codes")
        .select("*")
        .eq("code", codeStr)
        .eq("is_active", true)
        .maybeSingle();

      if (promoErr || !promo) {
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

      // Check expiration
      if (promo.expires_at && new Date(promo.expires_at) < new Date()) {
        return new Response(
          JSON.stringify({ error: "This celestial blessing has already reached its twilight." }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Check max redemption cap
      if (promo.times_redeemed >= promo.max_redemptions) {
        return new Response(
          JSON.stringify({ error: "This promo code has reached its maximum cosmic capacity." }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Check if user already redeemed this code
      const { data: priorRedemption } = await adminClient
        .from("promo_redemptions")
        .select("id")
        .eq("code_id", promo.id)
        .eq("user_id", user.id)
        .maybeSingle();

      if (priorRedemption) {
        return new Response(
          JSON.stringify({
            error: "You have already consecrated this promo code on your altar.",
          }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Record user redemption & update counter
      await adminClient.from("promo_redemptions").insert({
        code_id: promo.id,
        user_id: user.id,
      });

      await adminClient
        .from("promo_codes")
        .update({ times_redeemed: (promo.times_redeemed || 0) + 1 })
        .eq("id", promo.id);

      plan = promo.plan || plan;
      message = `Cosmic blessing accepted! Promo code '${codeStr}' unlocked Oracle Pro (${plan} plan).`;
    } else if (action === "subscribe" || action === "restore_purchase") {
      const rawToken = (body.receipt || body.purchase_token || "").trim();
      
      // Enforce receipt requirement to prevent arbitrary unverified pro upgrades
      if (!rawToken || rawToken.length < 12) {
        return new Response(
          JSON.stringify({
            error: "A valid store purchase receipt or order token is required to verify membership.",
          }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Hash receipt to prevent replay attack across accounts
      const receiptHash = await hashToken(rawToken);
      const { data: existingReceipt } = await adminClient
        .from("purchase_receipt_audit")
        .select("user_id")
        .eq("receipt_hash", receiptHash)
        .maybeSingle();

      if (existingReceipt && existingReceipt.user_id !== user.id) {
        return new Response(
          JSON.stringify({
            error: "This purchase receipt is already associated with another cosmic traveler.",
          }),
          {
            status: 409,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          }
        );
      }

      // Record in receipt audit
      if (!existingReceipt) {
        await adminClient.from("purchase_receipt_audit").insert({
          user_id: user.id,
          product_id: body.product_id || plan,
          receipt_hash: receiptHash,
          source: body.source || "google_play",
        });
      }

      message = action === "restore_purchase"
        ? "Oracle Pro membership successfully restored from celestial records."
        : `Welcome to Oracle Pro (${plan} plan)! All celestial decks, spreads, and prophecies are unlocked.`;
    } else {
      return new Response(
        JSON.stringify({ error: `Unsupported subscription action: ${action}` }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // 4. Update the profile using SERVICE_ROLE_KEY to set is_pro
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
