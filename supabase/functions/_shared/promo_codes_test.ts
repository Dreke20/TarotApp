import { assertEquals } from "jsr:@std/assert@1";
import { handleVerifySubscription } from "../verify-subscription/handler.ts";

const EXPOSED_CODES = [
  "CELESTIAL_PRO",
  "ORACULUM_2026",
  "MYSTIC_SEEKER",
  "COSMIC_LIFETIME",
];

function repoRoot(): string {
  return new URL("../../../", import.meta.url).pathname;
}

async function sqlInOrder(): Promise<string> {
  const dir = `${repoRoot()}supabase/migrations`;
  const names: string[] = [];
  for await (const entry of Deno.readDir(dir)) {
    if (entry.name.endsWith(".sql")) names.push(entry.name);
  }
  names.sort();
  const parts: string[] = [];
  for (const name of names) {
    parts.push(await Deno.readTextFile(`${dir}/${name}`));
  }
  return parts.join("\n");
}

Deno.test("clients have no remaining SELECT path to promo codes", async () => {
  const sql = await sqlInOrder();
  const dropAt = sql.lastIndexOf(
    'DROP POLICY IF EXISTS "Authenticated users can query active promo codes"',
  );
  assertEquals(dropAt > 0, true);
  const after = sql.slice(dropAt);
  assertEquals(/CREATE POLICY[\s\S]{0,200}promo_codes[\s\S]{0,80}FOR SELECT/i.test(after), false);
  assertEquals(after.includes("REVOKE ALL ON TABLE public.promo_codes FROM anon"), true);
  assertEquals(after.includes("REVOKE ALL ON TABLE public.promo_codes FROM authenticated"), true);
  assertEquals(after.includes("ENABLE ROW LEVEL SECURITY"), true);
  assertEquals(/INSERT INTO public\.promo_codes/i.test(sql), false);
});

Deno.test("published promo code values are gone from the app, docs, and SQL", async () => {
  const root = repoRoot();
  const hits: string[] = [];
  const skip = (path: string) =>
    path.includes("/.git/") ||
    path.endsWith("_test.ts") ||
    path.endsWith("_test.dart") ||
    path.includes("/build/");

  async function walk(dir: string) {
    for await (const entry of Deno.readDir(dir)) {
      const path = `${dir}/${entry.name}`;
      if (skip(path)) continue;
      if (entry.isDirectory) {
        if (entry.name === ".git" || entry.name === "build") continue;
        await walk(path);
        continue;
      }
      if (!/\.(dart|sql|md|html|ts|kt|kts)$/.test(entry.name)) continue;
      const text = await Deno.readTextFile(path);
      for (const code of EXPOSED_CODES) {
        if (text.includes(code)) hits.push(`${path}:${code}`);
      }
    }
  }

  await walk(`${root}lib`);
  await walk(`${root}website`);
  await walk(`${root}supabase`);
  for await (const entry of Deno.readDir(root)) {
    if (entry.isFile && entry.name.endsWith(".md")) {
      const text = await Deno.readTextFile(`${root}${entry.name}`);
      for (const code of EXPOSED_CODES) {
        if (text.includes(code)) hits.push(`${entry.name}:${code}`);
      }
    }
  }
  assertEquals(hits, []);
});

Deno.test("redeem_promo does not grant Pro and does not read codes", async () => {
  let playCalled = false;
  const response = await handleVerifySubscription(
    new Request("https://example.test/verify-subscription", {
      method: "POST",
      headers: { Authorization: "Bearer user-jwt", "Content-Type": "application/json" },
      body: JSON.stringify({ action: "redeem_promo", promo_code: "CELESTIAL_PRO" }),
    }),
    {
      getUser: async () => ({ id: "user-1" }),
      play: {
        verify: () => {
          playCalled = true;
          return Promise.resolve({ status: "unverified" });
        },
      },
      store: {
        receiptOwner: () => Promise.resolve(null),
        saveVerifiedPurchase: () => Promise.resolve(false),
        setPro: () => Promise.reject(new Error("pro was granted")),
      },
    },
  );
  assertEquals(response.status, 400);
  assertEquals(playCalled, false);
  const body = await response.json();
  assertEquals(String(body.error).includes("Promo codes are not accepted"), true);
});
