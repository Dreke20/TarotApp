import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";
import {
  GOOGLE_PLAY_SERVICE_ACCOUNT_ENV,
  verifierFromEnv,
} from "../_shared/play_billing.ts";
import {
  handleVerifySubscription,
  type ProStore,
} from "./handler.ts";

function serviceClient() {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !serviceKey) {
    throw new Error("missing_supabase_keys");
  }
  return createClient(supabaseUrl, serviceKey);
}

function storeFrom(admin: ReturnType<typeof serviceClient>): ProStore {
  return {
    async receiptOwner(receiptHash) {
      const { data } = await admin
        .from("purchase_receipt_audit")
        .select("user_id")
        .eq("receipt_hash", receiptHash)
        .maybeSingle();
      return data?.user_id ?? null;
    },
    async saveVerifiedPurchase(input) {
      const { error } = await admin.from("purchase_receipt_audit").upsert({
        user_id: input.userId,
        product_id: input.productId,
        receipt_hash: input.receiptHash,
        source: input.source,
        expires_at: input.expiresAt,
        verified_at: new Date().toISOString(),
      }, { onConflict: "receipt_hash" });
      if (error) throw new Error("receipt_audit_failed");
    },
    async setPro(input) {
      const { error } = await admin.from("profiles").upsert({
        id: input.userId,
        is_pro: input.isPro,
        pro_expires_at: input.expiresAt,
        updated_at: new Date().toISOString(),
      }, { onConflict: "id" });
      if (error) throw new Error("profile_update_failed");
    },
  };
}

serve(async (req: Request) => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  if (!supabaseUrl || !anonKey) {
    return new Response(JSON.stringify({ error: "Server configuration error (missing keys)." }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  let play;
  try {
    play = verifierFromEnv({
      [GOOGLE_PLAY_SERVICE_ACCOUNT_ENV]: Deno.env.get(GOOGLE_PLAY_SERVICE_ACCOUNT_ENV),
      PLAY_PACKAGE_NAME: Deno.env.get("PLAY_PACKAGE_NAME"),
    });
  } catch (err) {
    const missing = err instanceof Error && err.message === "missing_service_account";
    if (req.method === "OPTIONS") {
      return handleVerifySubscription(req, {
        getUser: async () => null,
        play: { verify: () => Promise.resolve({ status: "unverified" as const }) },
        store: unusedStore(),
      });
    }
    if (missing || (err instanceof Error && err.message.startsWith("Service account")) ||
      (err instanceof Error && err.message.includes("GOOGLE_PLAY_SERVICE_ACCOUNT_JSON"))) {
      return new Response(JSON.stringify({
        error: "Play billing verification is not configured. Oracle Pro was not unlocked.",
      }), {
        status: 503,
        headers: { "Content-Type": "application/json" },
      });
    }
    throw err;
  }

  const admin = serviceClient();
  return await handleVerifySubscription(req, {
    play,
    store: storeFrom(admin),
    getUser: async (authHeader) => {
      const client = createClient(supabaseUrl, anonKey, {
        global: { headers: { Authorization: authHeader } },
      });
      const token = authHeader.replace(/^Bearer\s+/i, "");
      const { data, error } = await client.auth.getUser(token);
      if (error || !data.user) return null;
      return { id: data.user.id };
    },
  });
});

function unusedStore(): ProStore {
  return {
    receiptOwner: async () => null,
    saveVerifiedPurchase: async () => {},
    setPro: async () => {},
  };
}
