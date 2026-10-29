import {
  FREE_DAILY_READINGS,
  PRO_DAILY_READINGS,
  validateAiInput,
} from "./ai_limits.ts";
import { proStillActive } from "./play_billing.ts";

export const aiCorsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

export interface AiDeps {
  getUser(authHeader: string): Promise<{ id: string } | null>;
  /** True only when is_pro is set and pro_expires_at is null or still in the future. */
  proActive(userId: string, now: Date): Promise<boolean>;
  /** Returns the new count, or null when the daily limit is already used. */
  consume(userId: string, limit: number, now: Date): Promise<number | null>;
  now?: () => Date;
}

export type PreparedAiRequest =
  | { ok: true; userId: string; isPro: boolean; body: Record<string, unknown> }
  | { ok: false; response: Response };

function json(status: number, body: Record<string, unknown>): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...aiCorsHeaders, "Content-Type": "application/json" },
  });
}

export function dailyLimit(isPro: boolean): number {
  return isPro ? PRO_DAILY_READINGS : FREE_DAILY_READINGS;
}

export { proStillActive };

/**
 * Requires a user JWT from auth.getUser, rejects oversized input, and
 * consumes one daily reading. The anon API key is not a user.
 */
export async function prepareAiRequest(req: Request, deps: AiDeps): Promise<PreparedAiRequest> {
  if (req.method === "OPTIONS") {
    return { ok: false, response: new Response("ok", { headers: aiCorsHeaders }) };
  }

  const authHeader = req.headers.get("Authorization") ?? req.headers.get("authorization");
  if (!authHeader || !authHeader.toLowerCase().startsWith("bearer ")) {
    return {
      ok: false,
      response: json(401, { error: "A signed-in user session is required." }),
    };
  }

  const user = await deps.getUser(authHeader);
  if (!user?.id) {
    return {
      ok: false,
      response: json(401, { error: "Invalid or expired session." }),
    };
  }

  const parsed = await req.json().catch(() => null);
  if (!parsed || typeof parsed !== "object" || Array.isArray(parsed)) {
    return { ok: false, response: json(400, { error: "A JSON object body is required." }) };
  }
  const body = parsed as Record<string, unknown>;
  const rejection = validateAiInput(body);
  if (rejection) {
    return { ok: false, response: json(rejection.status, { error: rejection.error }) };
  }

  const now = deps.now?.() ?? new Date();
  let isPro = false;
  try {
    isPro = await deps.proActive(user.id, now);
  } catch (err) {
    console.error("Pro lookup failed closed:", err instanceof Error ? err.message : "error");
    return { ok: false, response: json(503, { error: "Could not check Oracle Pro status." }) };
  }

  const limit = dailyLimit(isPro);
  let used: number | null;
  try {
    used = await deps.consume(user.id, limit, now);
  } catch (err) {
    console.error("Quota check failed closed:", err instanceof Error ? err.message : "error");
    return { ok: false, response: json(503, { error: "Could not check the daily reading limit." }) };
  }
  if (used == null) {
    return {
      ok: false,
      response: json(429, {
        error: isPro
          ? "Daily Oracle Pro reading limit reached."
          : "Daily free reading limit reached. Oracle Pro raises the limit.",
        limit,
      }),
    };
  }

  return { ok: true, userId: user.id, isPro, body };
}
