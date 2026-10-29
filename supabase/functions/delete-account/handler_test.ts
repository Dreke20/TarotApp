import { assertEquals } from "jsr:@std/assert@1";
import { handleDeleteAccount, USER_OWNED_ROWS } from "./handler.ts";

Deno.test("delete account requires a user JWT and then removes rows, storage, and the auth user", async () => {
  const missing = await handleDeleteAccount(
    new Request("https://example.test/delete-account", { method: "POST" }),
    {
      getUser: async () => ({ id: "should-not-run" }),
      deleteRows: () => Promise.reject(new Error("rows")),
      deleteStorage: () => Promise.reject(new Error("storage")),
      revokeSessions: () => Promise.reject(new Error("sessions")),
      deleteAuthUser: () => Promise.reject(new Error("auth")),
    },
  );
  assertEquals(missing.status, 401);

  const invalid = await handleDeleteAccount(
    new Request("https://example.test/delete-account", {
      method: "POST",
      headers: { Authorization: "Bearer not-a-user" },
    }),
    {
      getUser: async () => null,
      deleteRows: () => Promise.reject(new Error("rows")),
      deleteStorage: () => Promise.reject(new Error("storage")),
      revokeSessions: () => Promise.reject(new Error("sessions")),
      deleteAuthUser: () => Promise.reject(new Error("auth")),
    },
  );
  assertEquals(invalid.status, 401);

  const order: string[] = [];
  const deleted = await handleDeleteAccount(
    new Request("https://example.test/delete-account", {
      method: "POST",
      headers: { Authorization: "Bearer user-jwt" },
    }),
    {
      getUser: async () => ({ id: "user-1" }),
      deleteRows: (table, column, userId) => {
        order.push(`row:${table}:${column}:${userId}`);
        return Promise.resolve();
      },
      deleteStorage: (userId) => {
        order.push(`storage:${userId}`);
        return Promise.resolve();
      },
      revokeSessions: (jwt) => {
        order.push(`sessions:${jwt}`);
        return Promise.resolve();
      },
      deleteAuthUser: (userId) => {
        order.push(`auth:${userId}`);
        return Promise.resolve();
      },
    },
  );
  assertEquals(deleted.status, 200);
  assertEquals(order[0], "storage:user-1");
  assertEquals(order.at(-2), "sessions:user-jwt");
  assertEquals(order.at(-1), "auth:user-1");
  for (const row of USER_OWNED_ROWS) {
    assertEquals(order.includes(`row:${row.table}:${row.column}:user-1`), true);
  }
  const tables = USER_OWNED_ROWS.map((row) => row.table);
  assertEquals(tables.includes("readings"), true);
  assertEquals(tables.includes("profiles"), true);
  assertEquals(tables.includes("ai_reports"), true);
});
