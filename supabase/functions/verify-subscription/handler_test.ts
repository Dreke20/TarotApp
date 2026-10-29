import { assertEquals } from "jsr:@std/assert@1";
import {
  entitlementFromProduct,
  entitlementFromSubscription,
  GooglePlayPurchaseVerifier,
  parseServiceAccount,
  PLAY_PACKAGE_NAME,
  proStillActive,
  signServiceAccountJwt,
} from "../_shared/play_billing.ts";
import { handleVerifySubscription, type ProRecord, type ProStore } from "./handler.ts";

class MemoryStore implements ProStore {
  receipts = new Map<string, { userId: string; expiresAt: string | null }>();
  profiles = new Map<string, ProRecord>();

  receiptOwner(receiptHash: string): Promise<string | null> {
    return Promise.resolve(this.receipts.get(receiptHash)?.userId ?? null);
  }

  saveVerifiedPurchase(input: {
    userId: string;
    productId: string;
    receiptHash: string;
    source: string;
    expiresAt: string | null;
  }): Promise<boolean> {
    const existing = this.receipts.get(input.receiptHash);
    if (existing && existing.userId !== input.userId) return Promise.resolve(false);
    if (!existing) {
      this.receipts.set(input.receiptHash, {
        userId: input.userId,
        expiresAt: input.expiresAt,
      });
    }
    return Promise.resolve(true);
  }

  setPro(input: { userId: string; isPro: boolean; expiresAt: string | null }): Promise<void> {
    const previous = this.profiles.get(input.userId);
    this.profiles.set(input.userId, {
      isPro: input.isPro,
      expiresAt: input.expiresAt,
      plan: previous?.plan ?? "",
      productId: previous?.productId ?? "",
      receiptHash: previous?.receiptHash ?? "",
    });
    return Promise.resolve();
  }
}

function request(input: {
  authorization?: string;
  body?: unknown;
}): Request {
  return new Request("https://example.test/verify-subscription", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...(input.authorization ? { Authorization: input.authorization } : {}),
    },
    body: JSON.stringify(input.body ?? {}),
  });
}

const FUTURE = "2030-01-01T00:00:00.000Z";
const PAST = "2020-01-01T00:00:00.000Z";

Deno.test("missing or invalid JWT returns 401 and does not grant Pro", async () => {
  const store = new MemoryStore();
  const missing = await handleVerifySubscription(request({
    body: { receipt: "fake-receipt-token-value" },
  }), {
    getUser: async () => ({ id: "should-not-run" }),
    play: { verify: () => Promise.reject(new Error("play was called")) },
    store,
  });
  assertEquals(missing.status, 401);

  const invalid = await handleVerifySubscription(request({
    authorization: "Bearer not-a-user-jwt",
    body: { receipt: "fake-receipt-token-value", product_id: "oracle_pro_yearly" },
  }), {
    getUser: async () => null,
    play: { verify: () => Promise.reject(new Error("play was called")) },
    store,
  });
  assertEquals(invalid.status, 401);
  assertEquals(store.profiles.size, 0);
});

Deno.test("a fake Play receipt is rejected and does not set Pro", async () => {
  const store = new MemoryStore();
  let sawToken = "";
  const response = await handleVerifySubscription(request({
    authorization: "Bearer user-jwt",
    body: {
      action: "subscribe",
      plan: "yearly",
      receipt: "this-is-a-fake-receipt-token",
      product_id: "oracle_pro_yearly",
    },
  }), {
    getUser: async () => ({ id: "user-1" }),
    play: {
      verify: (input) => {
        sawToken = input.purchaseToken;
        return Promise.resolve({ status: "unverified" as const });
      },
    },
    store,
  });
  assertEquals(response.status, 400);
  const body = await response.json();
  assertEquals(body.is_pro, undefined);
  assertEquals(sawToken, "this-is-a-fake-receipt-token");
  assertEquals(store.profiles.has("user-1"), false);
  assertEquals(store.receipts.size, 0);
});

Deno.test("a verified subscription stores expiry and a lifetime product has none", async () => {
  const store = new MemoryStore();
  const sub = await handleVerifySubscription(request({
    authorization: "Bearer user-jwt",
    body: {
      action: "subscribe",
      plan: "yearly",
      receipt: "real-subscription-token",
      product_id: "oracle_pro_yearly",
    },
  }), {
    getUser: async () => ({ id: "user-1" }),
    play: {
      verify: () => Promise.resolve({
        status: "entitled" as const,
        purchase: {
          productId: "oracle_pro_yearly",
          orderId: "GPA.1234",
          expiresAt: FUTURE,
          lifetime: false,
        },
      }),
    },
    store,
  });
  assertEquals(sub.status, 200);
  const subBody = await sub.json();
  assertEquals(subBody.is_pro, true);
  assertEquals(subBody.expires_at, FUTURE);
  assertEquals(store.profiles.get("user-1")?.expiresAt, FUTURE);
  assertEquals(store.receipts.size, 1);

  const life = await handleVerifySubscription(request({
    authorization: "Bearer user-jwt",
    body: {
      action: "subscribe",
      plan: "lifetime",
      receipt: "real-lifetime-token",
      product_id: "oracle_pro_lifetime",
    },
  }), {
    getUser: async () => ({ id: "user-2" }),
    play: {
      verify: (input) => {
        assertEquals(input.productId, "oracle_pro_lifetime");
        return Promise.resolve({
          status: "entitled" as const,
          purchase: {
            productId: "oracle_pro_lifetime",
            orderId: "GPA.9999",
            expiresAt: null,
            lifetime: true,
          },
        });
      },
    },
    store,
  });
  assertEquals(life.status, 200);
  assertEquals(store.profiles.get("user-2")?.isPro, true);
  assertEquals(store.profiles.get("user-2")?.expiresAt, null);
});

Deno.test("a second user presenting the same token is rejected", async () => {
  const store = new MemoryStore();
  const play = {
    verify: () => Promise.resolve({
      status: "entitled" as const,
      purchase: {
        productId: "oracle_pro_yearly",
        orderId: "GPA.1",
        expiresAt: FUTURE,
        lifetime: false,
      },
    }),
  };
  const body = {
    action: "subscribe",
    plan: "yearly",
    receipt: "shared-purchase-token",
    product_id: "oracle_pro_yearly",
  };
  const first = await handleVerifySubscription(request({
    authorization: "Bearer user-1",
    body,
  }), {
    getUser: async () => ({ id: "user-1" }),
    play,
    store,
  });
  assertEquals(first.status, 200);

  const second = await handleVerifySubscription(request({
    authorization: "Bearer user-2",
    body,
  }), {
    getUser: async () => ({ id: "user-2" }),
    play,
    store,
  });
  assertEquals(second.status, 409);
  assertEquals(store.profiles.has("user-2"), false);
  const owners = [...store.receipts.values()].map((row) => row.userId);
  assertEquals(owners, ["user-1"]);
});

Deno.test("an expired subscription does not stay Pro", async () => {
  const store = new MemoryStore();
  const response = await handleVerifySubscription(request({
    authorization: "Bearer user-jwt",
    body: { receipt: "expired-subscription-token", product_id: "oracle_pro_monthly" },
  }), {
    getUser: async () => ({ id: "user-1" }),
    play: {
      verify: () => Promise.resolve({
        status: "inactive" as const,
        expiresAt: PAST,
      }),
    },
    store,
    now: new Date("2026-10-29T00:00:00.000Z"),
  });
  assertEquals(response.status, 400);
  assertEquals(store.profiles.get("user-1")?.isPro, false);
});

Deno.test("Play API 400 for a fake token is unverified", async () => {
  const calls: string[] = [];
  const verifier = new GooglePlayPurchaseVerifier(
    {
      client_email: "play@example.iam.gserviceaccount.com",
      private_key: "unused",
      token_uri: "https://oauth2.googleapis.com/token",
    },
    PLAY_PACKAGE_NAME,
    (url) => {
      calls.push(url);
      if (url.includes("oauth2.googleapis.com")) {
        return Promise.resolve(new Response(JSON.stringify({
          access_token: "ya29.test",
          expires_in: 3600,
        }), { status: 200 }));
      }
      return Promise.resolve(new Response(JSON.stringify({
        error: { code: 400, message: "Invalid Value" },
      }), { status: 400 }));
    },
  );
  verifier.accessToken = () => Promise.resolve("ya29.test");
  const result = await verifier.verify({
    productId: "oracle_pro_yearly",
    purchaseToken: "fake-token-not-from-play",
    plan: "yearly",
  });
  assertEquals(result.status, "unverified");
  assertEquals(calls.some((url) => url.includes("/purchases/subscriptionsv2/tokens/")), true);
  assertEquals(calls.some((url) => url.includes("key=")), false);
});

Deno.test("lifetime purchases call purchases.products", async () => {
  const calls: string[] = [];
  const verifier = new GooglePlayPurchaseVerifier(
    {
      client_email: "play@example.iam.gserviceaccount.com",
      private_key: "unused",
    },
    PLAY_PACKAGE_NAME,
    (url) => {
      calls.push(url);
      return Promise.resolve(new Response(JSON.stringify({
        purchaseState: 0,
        orderId: "GPA.life",
      }), { status: 200 }));
    },
  );
  verifier.accessToken = () => Promise.resolve("ya29.test");
  const result = await verifier.verify({
    productId: "oracle_pro_lifetime",
    purchaseToken: "lifetime-purchase-token",
    plan: "lifetime",
  });
  assertEquals(result.status, "entitled");
  if (result.status !== "entitled") return;
  assertEquals(result.purchase.lifetime, true);
  assertEquals(result.purchase.expiresAt, null);
  assertEquals(
    calls.some((url) =>
      url.includes(
        `/applications/${PLAY_PACKAGE_NAME}/purchases/products/oracle_pro_lifetime/tokens/`,
      )
    ),
    true,
  );
});

Deno.test("subscriptionsv2 parsing rejects inactive and expired purchases", () => {
  const now = new Date("2026-10-29T00:00:00.000Z");
  const active = entitlementFromSubscription({
    subscriptionState: "SUBSCRIPTION_STATE_ACTIVE",
    latestOrderId: "GPA.1",
    lineItems: [{ productId: "oracle_pro_yearly", expiryTime: FUTURE }],
  }, "oracle_pro_yearly", now);
  assertEquals(active.status, "entitled");
  if (active.status === "entitled") assertEquals(active.purchase.expiresAt, FUTURE);

  const expired = entitlementFromSubscription({
    subscriptionState: "SUBSCRIPTION_STATE_EXPIRED",
    lineItems: [{ productId: "oracle_pro_yearly", expiryTime: PAST }],
  }, "oracle_pro_yearly", now);
  assertEquals(expired.status, "inactive");

  const canceledButPaid = entitlementFromSubscription({
    subscriptionState: "SUBSCRIPTION_STATE_CANCELED",
    lineItems: [{ productId: "oracle_pro_monthly", expiryTime: FUTURE }],
  }, "oracle_pro_monthly", now);
  assertEquals(canceledButPaid.status, "entitled");

  const purchased = entitlementFromProduct({ purchaseState: 0, orderId: "GPA.life" }, "oracle_pro_lifetime");
  assertEquals(purchased.status === "entitled" && purchased.purchase.lifetime, true);
  assertEquals(entitlementFromProduct({ purchaseState: 1 }, "oracle_pro_lifetime").status, "inactive");
  assertEquals(proStillActive(true, PAST, now), false);
  assertEquals(proStillActive(true, null, now), true);
  assertEquals(proStillActive(false, FUTURE, now), false);

  const unknown = entitlementFromSubscription({
    subscriptionState: "SUBSCRIPTION_STATE_ACTIVE",
    lineItems: [{ productId: "oracle_pro_yearly", expiryTime: FUTURE }],
  }, "made_up_subscription", now);
  assertEquals(unknown.status, "unverified");

  const skipped = entitlementFromSubscription({
    subscriptionState: "SUBSCRIPTION_STATE_ACTIVE",
    lineItems: [{ productId: "oracle_pro_yearly" }],
  }, "oracle_pro_yearly", now);
  assertEquals(skipped.status, "unverified");
});

Deno.test("an unknown subscription product id is unverified", async () => {
  const calls: string[] = [];
  const verifier = new GooglePlayPurchaseVerifier(
    { client_email: "play@example.iam.gserviceaccount.com", private_key: "unused" },
    PLAY_PACKAGE_NAME,
    (url) => {
      calls.push(url);
      return Promise.resolve(new Response(JSON.stringify({
        subscriptionState: "SUBSCRIPTION_STATE_ACTIVE",
        lineItems: [{ productId: "oracle_pro_yearly", expiryTime: FUTURE }],
      }), { status: 200 }));
    },
  );
  const result = await verifier.verify({
    productId: "made_up_subscription",
    purchaseToken: "some-purchase-token",
    plan: "yearly",
  });
  assertEquals(result.status, "unverified");
  assertEquals(calls.length, 0);
});

Deno.test("plan=lifetime with a non-lifetime product is unverified", async () => {
  const calls: string[] = [];
  const verifier = new GooglePlayPurchaseVerifier(
    { client_email: "play@example.iam.gserviceaccount.com", private_key: "unused" },
    PLAY_PACKAGE_NAME,
    (url) => {
      calls.push(url);
      return Promise.resolve(new Response(JSON.stringify({
        purchaseState: 0,
        orderId: "GPA.nope",
      }), { status: 200 }));
    },
  );
  const result = await verifier.verify({
    productId: "oracle_pro_yearly",
    purchaseToken: "some-purchase-token",
    plan: "lifetime",
  });
  assertEquals(result.status, "unverified");
  assertEquals(calls.some((url) => url.includes("/purchases/products/")), false);
  assertEquals(calls.length, 0);
});

Deno.test("service account JSON without a private key is rejected", () => {
  let failed = false;
  try {
    parseServiceAccount(JSON.stringify({ client_email: "a@b.c" }));
  } catch {
    failed = true;
  }
  assertEquals(failed, true);
});

Deno.test("service account JWT is signed for the androidpublisher scope", async () => {
  const key = await crypto.subtle.generateKey(
    { name: "RSASSA-PKCS1-v1_5", modulusLength: 2048, publicExponent: new Uint8Array([1, 0, 1]), hash: "SHA-256" },
    true,
    ["sign", "verify"],
  );
  const pkcs8 = await crypto.subtle.exportKey("pkcs8", key.privateKey);
  const bytes = new Uint8Array(pkcs8);
  let binary = "";
  for (const byte of bytes) binary += String.fromCharCode(byte);
  const pem = `-----BEGIN PRIVATE KEY-----\n${btoa(binary)}\n-----END PRIVATE KEY-----\n`;
  const jwt = await signServiceAccountJwt({
    client_email: "play@example.iam.gserviceaccount.com",
    private_key: pem,
    token_uri: "https://oauth2.googleapis.com/token",
  }, 1_700_000_000);
  const [header, payload, signature] = jwt.split(".");
  assertEquals(jwt.split(".").length, 3);
  const headerJson = JSON.parse(new TextDecoder().decode(base64UrlToBytes(header)));
  const claim = JSON.parse(new TextDecoder().decode(base64UrlToBytes(payload)));
  assertEquals(headerJson.alg, "RS256");
  assertEquals(claim.scope, "https://www.googleapis.com/auth/androidpublisher");
  assertEquals(claim.iss, "play@example.iam.gserviceaccount.com");
  const valid = await crypto.subtle.verify(
    "RSASSA-PKCS1-v1_5",
    key.publicKey,
    base64UrlToBytes(signature),
    new TextEncoder().encode(`${header}.${payload}`),
  );
  assertEquals(valid, true);
});

function base64UrlToBytes(value: string): Uint8Array<ArrayBuffer> {
  const padded = value.replaceAll("-", "+").replaceAll("_", "/") +
    "=".repeat((4 - (value.length % 4)) % 4);
  const binary = atob(padded);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes;
}
