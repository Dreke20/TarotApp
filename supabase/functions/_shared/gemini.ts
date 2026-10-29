import { capGenerationConfig, GEMINI_MODELS } from "./ai_limits.ts";

export type GeminiFetch = (url: string, init: RequestInit) => Promise<Response>;

/** Calls Gemini with the API key in a header and a hard output-token cap. */
export async function callGemini(
  apiKey: string,
  payload: Record<string, unknown>,
  fetchImpl: GeminiFetch = (url, init) => fetch(url, init),
): Promise<string | null> {
  const body = JSON.stringify(capGenerationConfig(payload));
  for (const model of GEMINI_MODELS) {
    try {
      const url =
        `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`;
      const res = await fetchImpl(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-goog-api-key": apiKey,
        },
        body,
      });
      if (res.ok) {
        const data = await res.json();
        const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
        if (text) return text;
      } else {
        const errText = await res.text();
        console.warn(`Model ${model} returned ${res.status}: ${errText.slice(0, 120)}`);
      }
    } catch (err) {
      console.warn(`Error invoking ${model}:`, err);
    }
  }
  return null;
}
