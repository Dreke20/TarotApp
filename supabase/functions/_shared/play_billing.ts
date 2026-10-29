// Google Play purchase verification. The service-account JSON is read from
// GOOGLE_PLAY_SERVICE_ACCOUNT_JSON (a Supabase secret). Never commit a value.

export const GOOGLE_PLAY_SERVICE_ACCOUNT_ENV = "GOOGLE_PLAY_SERVICE_ACCOUNT_JSON";
export const PLAY_PACKAGE_NAME = "com.tarotapp.tarot_app";
export const LIFETIME_PRODUCT_ID = "oracle_pro_lifetime";
export const SUBSCRIPTION_PRODUCT_IDS = [
  "oracle_pro_yearly",
  "oracle_pro_monthly",
] as const;

const ANDROID_PUBLISHER_SCOPE = "https://www.googleapis.com/auth/androidpublisher";
const TOKEN_URL = "https://oauth2.googleapis.com/token";

/** States that still entitle the buyer while expiryTime is in the future. */
export const ENTITLED_SUBSCRIPTION_STATES = new Set([
  "SUBSCRIPTION_STATE_ACTIVE",
  "SUBSCRIPTION_STATE_IN_GRACE_PERIOD",
  "SUBSCRIPTION_STATE_CANCELED",
]);

export interface ServiceAccount {
  client_email: string;
  private_key: string;
  token_uri?: string;
}

export interface VerifiedPurchase {
  productId: string;
  orderId: string | null;
  /** Null only for a purchased lifetime product. */
  expiresAt: string | null;
  lifetime: boolean;
}

/** entitled grants Pro, inactive revokes it, unverified changes nothing. */
export type PlayCheck =
  | { status: "entitled"; purchase: VerifiedPurchase }
  | { status: "inactive"; expiresAt: string | null }
  | { status: "unverified" };

export function parseServiceAccount(raw: string): ServiceAccount {
  let parsed: unknown;
  try {
    parsed = JSON.parse(raw);
  } catch {
    throw new Error("GOOGLE_PLAY_SERVICE_ACCOUNT_JSON is not valid JSON.");
  }
  if (!parsed || typeof parsed !== "object") {
    throw new Error("GOOGLE_PLAY_SERVICE_ACCOUNT_JSON is not an object.");
  }
  const record = parsed as Record<string, unknown>;
  const clientEmail = record.client_email;
  const privateKey = record.private_key;
  if (typeof clientEmail !== "string" || !clientEmail.includes("@")) {
    throw new Error("Service account JSON is missing client_email.");
  }
  if (typeof privateKey !== "string" || !privateKey.includes("PRIVATE KEY")) {
    throw new Error("Service account JSON is missing private_key.");
  }
  const tokenUri = record.token_uri;
  return {
    client_email: clientEmail,
    private_key: privateKey,
    token_uri: typeof tokenUri === "string" ? tokenUri : TOKEN_URL,
  };
}

export function productIdForPlan(plan: string | undefined, productId: string | undefined): string {
  const explicit = (productId ?? "").trim();
  if (explicit) return explicit;
  switch ((plan ?? "").trim()) {
    case "monthly":
      return "oracle_pro_monthly";
    case "lifetime":
      return LIFETIME_PRODUCT_ID;
    default:
      return "oracle_pro_yearly";
  }
}

export function isLifetimeProduct(productId: string, plan?: string): boolean {
  return productId === LIFETIME_PRODUCT_ID || plan === "lifetime";
}

/**
 * A subscription is Pro only while Google says it is entitled and the latest
 * line-item expiry is still in the future. Lifetime products have no expiry.
 */
export function proStillActive(
  isPro: boolean,
  expiresAt: string | null | undefined,
  now: Date,
): boolean {
  if (!isPro) return false;
  if (expiresAt == null || expiresAt === "") return true;
  const expiry = new Date(expiresAt);
  if (Number.isNaN(expiry.getTime())) return false;
  return expiry.getTime() > now.getTime();
}

export function entitlementFromSubscription(
  body: unknown,
  expectedProductId: string,
  now: Date,
): PlayCheck {
  if (!body || typeof body !== "object") return { status: "unverified" };
  const record = body as Record<string, unknown>;
  const state = record.subscriptionState;
  if (typeof state !== "string") return { status: "unverified" };
  const lineItems = Array.isArray(record.lineItems) ? record.lineItems : [];
  let bestExpiry: string | null = null;
  let matchedProduct = expectedProductId;
  const orderId = typeof record.latestOrderId === "string" ? record.latestOrderId : null;
  for (const item of lineItems) {
    if (!item || typeof item !== "object") continue;
    const line = item as Record<string, unknown>;
    const productId = typeof line.productId === "string" ? line.productId : "";
    if (expectedProductId && productId && productId !== expectedProductId) continue;
    const expiry = typeof line.expiryTime === "string" ? line.expiryTime : "";
    if (!expiry) continue;
    if (bestExpiry == null || new Date(expiry).getTime() > new Date(bestExpiry).getTime()) {
      bestExpiry = expiry;
      if (productId) matchedProduct = productId;
    }
  }
  const entitled = ENTITLED_SUBSCRIPTION_STATES.has(state) &&
    proStillActive(true, bestExpiry, now);
  if (!entitled) {
    return { status: "inactive", expiresAt: bestExpiry };
  }
  return {
    status: "entitled",
    purchase: {
      productId: matchedProduct,
      orderId,
      expiresAt: bestExpiry,
      lifetime: false,
    },
  };
}

export function entitlementFromProduct(
  body: unknown,
  productId: string,
): PlayCheck {
  if (!body || typeof body !== "object") return { status: "unverified" };
  const record = body as Record<string, unknown>;
  if (typeof record.purchaseState !== "number") return { status: "unverified" };
  // 0 purchased, 1 canceled, 2 pending.
  if (record.purchaseState !== 0) {
    return { status: "inactive", expiresAt: null };
  }
  const orderId = typeof record.orderId === "string" ? record.orderId : null;
  return {
    status: "entitled",
    purchase: {
      productId,
      orderId,
      expiresAt: null,
      lifetime: true,
    },
  };
}

function bytesToBase64Url(bytes: Uint8Array): string {
  let binary = "";
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary).replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
}

function textToBase64Url(text: string): string {
  return bytesToBase64Url(new TextEncoder().encode(text));
}

function pemToPkcs8(pem: string): ArrayBuffer {
  const b64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/g, "")
    .replace(/-----END PRIVATE KEY-----/g, "")
    .replace(/\s+/g, "");
  const binary = atob(b64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes.buffer;
}

export async function signServiceAccountJwt(
  account: ServiceAccount,
  nowSeconds: number,
): Promise<string> {
  const header = { alg: "RS256", typ: "JWT" };
  const claim = {
    iss: account.client_email,
    scope: ANDROID_PUBLISHER_SCOPE,
    aud: account.token_uri || TOKEN_URL,
    iat: nowSeconds,
    exp: nowSeconds + 3600,
  };
  const unsigned = `${textToBase64Url(JSON.stringify(header))}.${textToBase64Url(JSON.stringify(claim))}`;
  const key = await crypto.subtle.importKey(
    "pkcs8",
    pemToPkcs8(account.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    new TextEncoder().encode(unsigned),
  );
  return `${unsigned}.${bytesToBase64Url(new Uint8Array(signature))}`;
}

export interface PlayFetch {
  (input: string, init?: RequestInit): Promise<Response>;
}

export class GooglePlayPurchaseVerifier {
  private cachedToken: { value: string; expiresAtMs: number } | null = null;

  constructor(
    private readonly account: ServiceAccount,
    private readonly packageName: string,
    private readonly fetchImpl: PlayFetch = fetch,
    private readonly now: () => Date = () => new Date(),
  ) {}

  async accessToken(): Promise<string> {
    const nowMs = this.now().getTime();
    if (this.cachedToken && this.cachedToken.expiresAtMs - 60_000 > nowMs) {
      return this.cachedToken.value;
    }
    const jwt = await signServiceAccountJwt(
      this.account,
      Math.floor(nowMs / 1000),
    );
    const tokenUrl = this.account.token_uri || TOKEN_URL;
    const response = await this.fetchImpl(tokenUrl, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion: jwt,
      }),
    });
    if (!response.ok) return Promise.reject(new Error("google_token_exchange_failed"));
    const payload = await response.json();
    const token = payload?.access_token;
    if (typeof token !== "string" || token.length === 0) {
      throw new Error("google_token_missing");
    }
    const expiresIn = Number(payload.expires_in ?? 3600);
    this.cachedToken = {
      value: token,
      expiresAtMs: nowMs + expiresIn * 1000,
    };
    return token;
  }

  async verify(input: {
    productId: string;
    purchaseToken: string;
    plan?: string;
  }): Promise<PlayCheck> {
    const token = input.purchaseToken.trim();
    if (token.length < 12) return { status: "unverified" };
    const productId = productIdForPlan(input.plan, input.productId);
    const access = await this.accessToken();
    if (isLifetimeProduct(productId, input.plan)) {
      return await this.getProduct(productId, token, access);
    }
    return await this.getSubscription(productId, token, access);
  }

  private async getSubscription(
    productId: string,
    purchaseToken: string,
    accessToken: string,
  ): Promise<PlayCheck> {
    const url =
      `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${
        encodeURIComponent(this.packageName)
      }/purchases/subscriptionsv2/tokens/${encodeURIComponent(purchaseToken)}`;
    const response = await this.fetchImpl(url, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });
    if (!response.ok) return { status: "unverified" };
    return entitlementFromSubscription(await response.json(), productId, this.now());
  }

  private async getProduct(
    productId: string,
    purchaseToken: string,
    accessToken: string,
  ): Promise<PlayCheck> {
    const url =
      `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${
        encodeURIComponent(this.packageName)
      }/purchases/products/${encodeURIComponent(productId)}/tokens/${
        encodeURIComponent(purchaseToken)
      }`;
    const response = await this.fetchImpl(url, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });
    if (!response.ok) return { status: "unverified" };
    return entitlementFromProduct(await response.json(), productId);
  }
}

export function verifierFromEnv(
  env: Record<string, string | undefined>,
  fetchImpl?: PlayFetch,
): GooglePlayPurchaseVerifier {
  const raw = env[GOOGLE_PLAY_SERVICE_ACCOUNT_ENV];
  if (!raw || raw.trim().length === 0) {
    throw new Error("missing_service_account");
  }
  const packageName = env.PLAY_PACKAGE_NAME?.trim() || PLAY_PACKAGE_NAME;
  return new GooglePlayPurchaseVerifier(parseServiceAccount(raw), packageName, fetchImpl);
}
