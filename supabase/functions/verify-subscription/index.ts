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
import { claimReceipt } from "./receipt_claim.ts";

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
      return await claimReceipt({
        insertIfAbsent: async (row) => {
          const { error } = await admin.from("purchase_receipt_audit").insert({
            user_id: row.userId,
            product_id: row.productId,
            receipt_hash: row.receiptHash,
            source: row.source,
            expires_at: row.expiresAt,
          });
          // 23505 is the unique violation. The existing row keeps its user_id.
          if (error && error.code !== "23505") throw new Error("receipt_audit_failed");
        },
        ownerOf: async (receiptHash) => {
          const { data, error } = await admin
            .from("purchase_receipt_audit")
            .select("user_id")
            .eq("receipt_hash", receiptHash)
            .maybeSingle();
          if (error) throw new Error("receipt_audit_failed");
          return data?.user_id ?? null;
        },
      }, input);
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
    saveVerifiedPurchase: async () => false,
    setPro: async () => {},
  };
}
