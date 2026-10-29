export interface ReceiptInsert {
  userId: string;
  productId: string;
  receiptHash: string;
  source: string;
  expiresAt: string | null;
}

export interface ReceiptAudit {
  /** Insert the row. An existing receipt_hash must be left unchanged. */
  insertIfAbsent(row: ReceiptInsert): Promise<void>;
  ownerOf(receiptHash: string): Promise<string | null>;
}

/**
 * Records a verified purchase without letting a later caller replace user_id.
 * Pro is granted only when the stored owner is the caller.
 */
export async function claimReceipt(audit: ReceiptAudit, row: ReceiptInsert): Promise<boolean> {
  await audit.insertIfAbsent(row);
  const owner = await audit.ownerOf(row.receiptHash);
  return owner === row.userId;
}
