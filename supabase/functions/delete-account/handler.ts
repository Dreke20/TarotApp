export const deleteCorsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

/** Rows removed before the auth user. profiles uses id; the rest use user_id. */
export const USER_OWNED_ROWS: ReadonlyArray<{ table: string; column: string }> = [
  { table: "readings", column: "user_id" },
  { table: "ai_reports", column: "user_id" },
  { table: "ai_daily_usage", column: "user_id" },
  { table: "promo_redemptions", column: "user_id" },
  { table: "purchase_receipt_audit", column: "user_id" },
  { table: "profiles", column: "id" },
];

export interface DeleteDeps {
  getUser(authHeader: string): Promise<{ id: string } | null>;
  deleteRows(table: string, column: string, userId: string): Promise<void>;
  deleteStorage(userId: string): Promise<void>;
  revokeSessions(jwt: string): Promise<void>;
  deleteAuthUser(userId: string): Promise<void>;
}

function json(status: number, body: Record<string, unknown>): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...deleteCorsHeaders, "Content-Type": "application/json" },
  });
}

export function bearerToken(authHeader: string): string {
  return authHeader.replace(/^Bearer\s+/i, "").trim();
}

export async function handleDeleteAccount(req: Request, deps: DeleteDeps): Promise<Response> {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: deleteCorsHeaders });
  }

  const authHeader = req.headers.get("Authorization") ?? req.headers.get("authorization");
  if (!authHeader || !authHeader.toLowerCase().startsWith("bearer ")) {
    return json(401, { error: "A signed-in user session is required." });
  }

  const user = await deps.getUser(authHeader);
  if (!user?.id) {
    return json(401, { error: "Invalid or expired session." });
  }

  try {
    await deps.deleteStorage(user.id);
    for (const row of USER_OWNED_ROWS) {
      await deps.deleteRows(row.table, row.column, user.id);
    }
    await deps.revokeSessions(bearerToken(authHeader));
    await deps.deleteAuthUser(user.id);
  } catch (err) {
    console.error("Account deletion failed:", err instanceof Error ? err.message : "error");
    return json(500, { error: "Account deletion did not finish. Nothing was signed out." });
  }

  return json(200, { success: true, deleted_user_id: user.id });
}
