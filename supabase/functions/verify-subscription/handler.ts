import { proStillActive, type PlayCheck } from "../_shared/play_billing.ts";

export const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

export interface SubscriptionRequest {
  action?: string;
  plan?: "yearly" | "monthly" | "lifetime";
  receipt?: string;
  purchase_token?: string;
  promo_code?: string;
  product_id?: string;
  source?: string;
}

export interface PlayVerifier {
  verify(input: {
    productId: string;
    purchaseToken: string;
    plan?: string;
  }): Promise<PlayCheck>;
}

export interface ProRecord {
  isPro: boolean;
  expiresAt: string | null;
  plan: string;
  productId: string;
  receiptHash: string;
}

export interface ProStore {
  receiptOwner(receiptHash: string): Promise<string | null>;
  /** True only when this caller owns the receipt. Must not replace another user. */
  saveVerifiedPurchase(input: {
    userId: string;
    productId: string;
    receiptHash: string;
    source: string;
    expiresAt: string | null;
  }): Promise<boolean>;
  setPro(input: {
    userId: string;
    isPro: boolean;
    expiresAt: string | null;
  }): Promise<void>;
}

export interface VerifyDeps {
  getUser: (authHeader: string) => Promise<{ id: string } | null>;
  play: PlayVerifier;
  store: ProStore;
  now?: Date;
  hashToken?: (token: string) => Promise<string>;
}

function json(status: number, body: Record<string, unknown>): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

export async function sha256Hex(token: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(token));
  return Array.from(new Uint8Array(digest))
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

export async function handleVerifySubscription(
  req: Request,
  deps: VerifyDeps,
): Promise<Response> {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization") ?? req.headers.get("authorization");
    if (!authHeader || !authHeader.toLowerCase().startsWith("bearer ")) {
      return json(401, {
        error: "Authorization header required. Please sign in to activate Oracle Pro.",
      });
    }

    const user = await deps.getUser(authHeader);
    if (!user?.id) {
      return json(401, {
        error: "Invalid or expired session. Please sign in to verify membership.",
      });
    }

    const body = await req.json().catch(() => ({})) as SubscriptionRequest;
    const action = body.action || "subscribe";
    const plan = body.plan || "yearly";
    const promoCode = (body.promo_code || "").trim();
    if (action === "redeem_promo" || promoCode.length > 0) {
      return json(400, {
        error:
          "Promo codes are not accepted. Oracle Pro is unlocked only through a store purchase.",
      });
    }
    if (action !== "subscribe" && action !== "restore_purchase") {
      return json(400, { error: `Unsupported subscription action: ${action}` });
    }

    const rawToken = (body.receipt || body.purchase_token || "").trim();
    if (!rawToken) {
      return json(400, {
        error: "A valid store purchase receipt or order token is required to verify membership.",
      });
    }

    let check: PlayCheck;
    try {
      check = await deps.play.verify({
        productId: body.product_id || "",
        purchaseToken: rawToken,
        plan,
      });
    } catch (err) {
      console.error("Play verification failed closed:", err instanceof Error ? err.message : "error");
      return json(503, {
        error: "Google Play could not be reached. Oracle Pro was not unlocked.",
      });
    }

    const now = deps.now ?? new Date();
    if (check.status === "unverified") {
      return json(400, {
        error: "Purchase could not be verified with Google Play. Oracle Pro was not unlocked.",
      });
    }
    if (check.status === "inactive") {
      await deps.store.setPro({
        userId: user.id,
        isPro: false,
        expiresAt: check.expiresAt,
      });
      return json(400, {
        error: "This Google Play purchase is not active. Oracle Pro was not unlocked.",
      });
    }

    const purchase = check.purchase;
    if (!proStillActive(true, purchase.lifetime ? null : purchase.expiresAt, now)) {
      await deps.store.setPro({
        userId: user.id,
        isPro: false,
        expiresAt: purchase.expiresAt,
      });
      return json(400, {
        error: "This Google Play purchase is not active. Oracle Pro was not unlocked.",
      });
    }

    const hashToken = deps.hashToken ?? sha256Hex;
    const receiptHash = await hashToken(rawToken);
    const owned = await deps.store.saveVerifiedPurchase({
      userId: user.id,
      productId: purchase.productId || body.product_id || plan,
      receiptHash,
      source: body.source || "google_play",
      expiresAt: purchase.expiresAt,
    });
    if (!owned) {
      return json(409, {
        error: "This purchase receipt is already associated with another cosmic traveler.",
      });
    }

    await deps.store.setPro({
      userId: user.id,
      isPro: true,
      expiresAt: purchase.expiresAt,
    });

    const message = action === "restore_purchase"
      ? "Oracle Pro membership successfully restored from celestial records."
      : `Welcome to Oracle Pro (${plan} plan)! All celestial decks, spreads, and prophecies are unlocked.`;

    return json(200, {
      success: true,
      is_pro: true,
      plan,
      expires_at: purchase.expiresAt,
      lifetime: purchase.lifetime,
      message,
      user_id: user.id,
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    console.error("Unhandled error in verify-subscription:", message);
    return json(500, { error: "Subscription verification failed." });
  }
}
