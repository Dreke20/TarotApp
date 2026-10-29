import { assertEquals } from "jsr:@std/assert@1";
import { prepareAiRequest } from "./ai_guard.ts";
import {
  capGenerationConfig,
  FREE_DAILY_READINGS,
  MAX_DRAWN_CARDS,
  MAX_IMAGE_BYTES,
  MAX_OUTPUT_TOKENS,
  PRO_DAILY_READINGS,
} from "./ai_limits.ts";
import { callGemini } from "./gemini.ts";

class MemoryQuota {
  counts = new Map<string, number>();
  consume(userId: string, limit: number): Promise<number | null> {
    const next = (this.counts.get(userId) ?? 0) + 1;
    if (next > limit) return Promise.resolve(null);
    this.counts.set(userId, next);
    return Promise.resolve(next);
  }
}

function request(input: { authorization?: string; body?: unknown }): Request {
  return new Request("https://example.test/tarot-reader", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...(input.authorization ? { Authorization: input.authorization } : {}),
    },
    body: JSON.stringify(input.body ?? { drawn_cards: ["The Star"] }),
  });
}

function deps(input: {
  user?: { id: string } | null;
  pro?: boolean;
  quota?: MemoryQuota;
}) {
  const quota = input.quota ?? new MemoryQuota();
  return {
    quota,
    ai: {
      getUser: () => Promise.resolve(input.user === undefined ? { id: "user-1" } : input.user),
      proActive: () => Promise.resolve(input.pro ?? false),
      consume: (userId: string, limit: number) => quota.consume(userId, limit),
    },
  };
}

Deno.test("a missing or invalid user JWT is 401", async () => {
  const missing = await prepareAiRequest(request({}), deps({ user: { id: "nope" } }).ai);
  assertEquals(missing.ok, false);
  if (!missing.ok) assertEquals(missing.response.status, 401);

  const invalid = await prepareAiRequest(
    request({ authorization: "Bearer anon-key" }),
    deps({ user: null }).ai,
  );
  assertEquals(invalid.ok, false);
  if (!invalid.ok) assertEquals(invalid.response.status, 401);
});

Deno.test("free users stop at FREE_DAILY_READINGS and pro users at PRO_DAILY_READINGS", async () => {
  assertEquals(FREE_DAILY_READINGS, 3);
  assertEquals(PRO_DAILY_READINGS, 50);

  const freeQuota = new MemoryQuota();
  const free = deps({ pro: false, quota: freeQuota });
  for (let i = 0; i < FREE_DAILY_READINGS; i++) {
    const allowed = await prepareAiRequest(request({ authorization: "Bearer user" }), free.ai);
    assertEquals(allowed.ok, true);
  }
  const blocked = await prepareAiRequest(request({ authorization: "Bearer user" }), free.ai);
  assertEquals(blocked.ok, false);
  if (!blocked.ok) assertEquals(blocked.response.status, 429);

  const proQuota = new MemoryQuota();
  const pro = deps({ pro: true, quota: proQuota });
  for (let i = 0; i < PRO_DAILY_READINGS; i++) {
    const allowed = await prepareAiRequest(request({ authorization: "Bearer pro" }), pro.ai);
    assertEquals(allowed.ok, true);
  }
  const proBlocked = await prepareAiRequest(request({ authorization: "Bearer pro" }), pro.ai);
  assertEquals(proBlocked.ok, false);
  if (!proBlocked.ok) assertEquals(proBlocked.response.status, 429);
});

Deno.test("oversized card arrays and images are rejected before quota", async () => {
  const quota = new MemoryQuota();
  const cards = await prepareAiRequest(
    request({
      authorization: "Bearer user",
      body: { drawn_cards: Array.from({ length: MAX_DRAWN_CARDS + 1 }, () => "The Star") },
    }),
    deps({ quota }).ai,
  );
  assertEquals(cards.ok, false);
  if (!cards.ok) assertEquals(cards.response.status, 413);
  assertEquals(quota.counts.size, 0);

  const image = "A".repeat(Math.ceil((MAX_IMAGE_BYTES + 10) * 4 / 3));
  const photo = await prepareAiRequest(
    request({
      authorization: "Bearer user",
      body: { lens_image_base64: image, card_catalog: [{ id: "star", name: "The Star" }] },
    }),
    deps({ quota }).ai,
  );
  assertEquals(photo.ok, false);
  if (!photo.ok) assertEquals(photo.response.status, 413);
});

Deno.test("every Gemini call sends the key as a header and caps maxOutputTokens", async () => {
  const calls: Array<{ url: string; key: string | null; tokens: number }> = [];
  const text = await callGemini("gemini-secret", {
    generationConfig: { temperature: 0.75 },
  }, (url, init) => {
    const headers = new Headers(init.headers);
    const payload = JSON.parse(String(init.body));
    calls.push({
      url,
      key: headers.get("x-goog-api-key"),
      tokens: payload.generationConfig.maxOutputTokens,
    });
    return Promise.resolve(new Response(JSON.stringify({
      candidates: [{ content: { parts: [{ text: "a reading" }] } }],
    })));
  });
  assertEquals(text, "a reading");
  assertEquals(calls.length, 1);
  assertEquals(calls[0].url.includes("key="), false);
  assertEquals(calls[0].key, "gemini-secret");
  assertEquals(calls[0].tokens <= MAX_OUTPUT_TOKENS, true);

  const capped = capGenerationConfig({
    generationConfig: { maxOutputTokens: 999_999 },
  });
  const config = capped.generationConfig as { maxOutputTokens: number };
  assertEquals(config.maxOutputTokens, MAX_OUTPUT_TOKENS);
});
