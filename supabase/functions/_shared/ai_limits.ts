// Server-side caps for every AI Edge Function. Change the daily numbers here.

export const FREE_DAILY_READINGS = 3;
export const PRO_DAILY_READINGS = 50;

export const MAX_OUTPUT_TOKENS = 4096;
export const DEFAULT_OUTPUT_TOKENS = 2048;

/** About 1.5 MB of image bytes after the client has compressed the photo. */
export const MAX_IMAGE_BYTES = Math.floor(1.5 * 1024 * 1024);

export const MAX_DRAWN_CARDS = 22;
export const MAX_CHAT_MESSAGES = 20;
export const MAX_DIALOGUE_MESSAGES = 24;
export const MAX_JOURNEY_ITEMS = 8;
export const MAX_RECURRING_CARDS = 12;
export const MAX_CATALOG_CARDS = 90;
export const MAX_PROMPT_CHARS = 16_000;

export const GEMINI_MODELS = [
  "gemini-2.5-flash",
  "gemini-flash-latest",
  "gemini-2.5-flash-lite",
];

export function decodedBase64Bytes(value: string): number {
  const cleaned = value.replace(/\s/g, "");
  if (cleaned.length === 0) return 0;
  const padding = cleaned.endsWith("==") ? 2 : cleaned.endsWith("=") ? 1 : 0;
  return Math.floor((cleaned.length * 3) / 4) - padding;
}

export function capGenerationConfig(
  payload: Record<string, unknown>,
  fallback = DEFAULT_OUTPUT_TOKENS,
): Record<string, unknown> {
  const current = payload.generationConfig;
  const generationConfig: Record<string, unknown> = current && typeof current === "object"
    ? { ...(current as Record<string, unknown>) }
    : {};
  const requested = Number(generationConfig.maxOutputTokens ?? fallback);
  const tokens = Number.isFinite(requested) ? Math.floor(requested) : fallback;
  generationConfig.maxOutputTokens = Math.min(MAX_OUTPUT_TOKENS, Math.max(1, tokens));
  return { ...payload, generationConfig };
}

export interface InputRejection {
  status: number;
  error: string;
}

function arrayLength(value: unknown): number {
  return Array.isArray(value) ? value.length : 0;
}

export function validateAiInput(body: Record<string, unknown>): InputRejection | null {
  const checks: Array<[unknown, number, string]> = [
    [body.drawn_cards, MAX_DRAWN_CARDS, "drawn_cards"],
    [body.chat_history, MAX_CHAT_MESSAGES, "chat_history"],
    [body.dialogue_history, MAX_DIALOGUE_MESSAGES, "dialogue_history"],
    [body.recent_journey_context, MAX_JOURNEY_ITEMS, "recent_journey_context"],
    [body.recurring_cards, MAX_RECURRING_CARDS, "recurring_cards"],
    [body.card_catalog, MAX_CATALOG_CARDS, "card_catalog"],
  ];
  for (const [value, max, name] of checks) {
    if (arrayLength(value) > max) {
      return { status: 413, error: `${name} exceeds the limit of ${max}.` };
    }
  }

  const image = body.lens_image_base64;
  if (typeof image === "string" && image.length > 0) {
    if (decodedBase64Bytes(image) > MAX_IMAGE_BYTES) {
      return { status: 413, error: "image_too_large" };
    }
  }

  const withoutImage = { ...body };
  delete withoutImage.lens_image_base64;
  if (JSON.stringify(withoutImage).length > MAX_PROMPT_CHARS) {
    return { status: 413, error: "prompt_too_large" };
  }
  return null;
}
