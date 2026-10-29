import { assertEquals } from "jsr:@std/assert@1";
import { claimReceipt, type ReceiptInsert } from "./receipt_claim.ts";

Deno.test("a second user presenting the same token does not take the receipt", async () => {
  const rows = new Map<string, string>();
  const audit = {
    insertIfAbsent(row: ReceiptInsert): Promise<void> {
      if (!rows.has(row.receiptHash)) rows.set(row.receiptHash, row.userId);
      return Promise.resolve();
    },
    ownerOf(receiptHash: string): Promise<string | null> {
      return Promise.resolve(rows.get(receiptHash) ?? null);
    },
  };
  const first: ReceiptInsert = {
    userId: "user-1",
    productId: "oracle_pro_yearly",
    receiptHash: "hash-1",
    source: "google_play",
    expiresAt: "2030-01-01T00:00:00.000Z",
  };
  assertEquals(await claimReceipt(audit, first), true);
  assertEquals(await claimReceipt(audit, { ...first, userId: "user-2" }), false);
  assertEquals(rows.get("hash-1"), "user-1");
});
