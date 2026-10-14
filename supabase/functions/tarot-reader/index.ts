import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

interface DrawnCard {
  id: string;
  name: string;
  arcana?: string;
  is_reversed?: boolean;
  position_name?: string;
  meaning_upright?: string;
  meaning_reversed?: string;
}

interface TarotRequest {
  user_question: string;
  spread_type: string;
  drawn_cards: (string | DrawnCard)[];
  seeker_astrology?: {
    sun?: string;
    moon?: string;
    rising?: string;
  };
  follow_up_prompt?: string;
  chat_history?: { role: string; content: string }[];
}

const CANDIDATE_MODELS = [
  "gemini-3.1-flash-lite",
  "gemini-3.8-flash",
  "gemini-3.5-flash",
  "gemini-flash-latest",
];

async function callGemini(
  apiKey: string,
  payload: Record<string, unknown>
): Promise<string | null> {
  for (const model of CANDIDATE_MODELS) {
    try {
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`;
      const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
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

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body: TarotRequest = await req.json();
    const {
      user_question,
      spread_type,
      drawn_cards,
      seeker_astrology,
      follow_up_prompt,
      chat_history,
    } = body;

    const geminiApiKey =
      Deno.env.get("GEMINI_API_KEY") || Deno.env.get("VERTEX_AI_API_KEY");

    // 1. Follow-up conversational question mode
    if (follow_up_prompt) {
      const systemPrompt =
        "You are a mystical, empathetic tarot reader holding space for a seeker. Answer their follow-up inquiry specifically in context of the cards previously revealed. Offer poetic yet grounded wisdom.";

      let followUpAnswer = "";
      if (geminiApiKey) {
        const historyParts = (chat_history || []).map((msg) => ({
          role: msg.role === "model" ? "model" : "user",
          parts: [{ text: msg.content }],
        }));

        historyParts.push({
          role: "user",
          parts: [
            {
              text: `${systemPrompt}\n\nSeeker Inquiry: "${follow_up_prompt}"`,
            },
          ],
        });

        const text = await callGemini(geminiApiKey, {
          contents: historyParts,
          generationConfig: { temperature: 0.75 },
        });

        if (text) {
          followUpAnswer = text.trim();
        }
      }

      if (!followUpAnswer) {
        followUpAnswer = `In response to your inquiry—"${follow_up_prompt}"—the cards remind you that your inner discernment is your true anchor. Look deeper into where you feel tension, for therein lies the hidden doorway to breakthrough.`;
      }

      return new Response(JSON.stringify({ answer: followUpAnswer }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 2. Initial Tarot Reading mode
    if (!drawn_cards || drawn_cards.length === 0) {
      return new Response(
        JSON.stringify({ error: "drawn_cards is required and cannot be empty" }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // Format cards description for prompt
    const cardsDescription = drawn_cards
      .map((c, index) => {
        if (typeof c === "string") {
          return `Card ${index + 1}: ${c}`;
        }
        const orientation = c.is_reversed ? "Reversed" : "Upright";
        const position = c.position_name ? `(${c.position_name})` : "";
        return `Card ${index + 1} ${position}: ${c.name} [${orientation}] - Keywords: ${
          c.is_reversed ? c.meaning_reversed : c.meaning_upright
        }`;
      })
      .join("\n");

    const astroDetails = seeker_astrology
      ? `\nSeeker Astrological Placements: Sun in ${
          seeker_astrology.sun || "Unknown"
        }, Moon in ${seeker_astrology.moon || "Unknown"}, Rising in ${
          seeker_astrology.rising || "Unknown"
        }. Weave these elements into your synthesis.`
      : "";

    const systemPrompt =
      "You are a mystical, empathetic tarot reader. Interpret these cards specifically for the seeker's inquiry. Focus on the relationship between the card positions, elemental alchemy, and cosmic resonance.";

    const userPrompt = `
Seeker Inquiry: "${user_question || "What guidance does the cosmos have for me at this juncture?"}"
Spread Selected: "${spread_type || "Custom Spread"}"${astroDetails}
Drawn Cards:
${cardsDescription}

Provide your reading in strictly valid JSON format matching this schema:
{
  "summary": "A poetic 1-2 sentence distillation of the reading's core energy",
  "interpretation": "A deep, cohesive narrative linking all drawn cards together in response to the seeker's question, highlighting the transition between positions",
  "card_insights": [
    {
      "card_name": "Card name",
      "position": "Position name",
      "insight": "Specific message for this placement and orientation"
    }
  ],
  "advice": "Empathetic, actionable guidance for the seeker moving forward",
  "astrological_note": "A celestial/elemental resonance note aligning with the seeker's energies"
}
`;

    let aiResponseText = "";
    if (geminiApiKey) {
      const text = await callGemini(geminiApiKey, {
        contents: [
          {
            role: "user",
            parts: [{ text: `${systemPrompt}\n\n${userPrompt}` }],
          },
        ],
        generationConfig: {
          temperature: 0.75,
          responseMimeType: "application/json",
        },
      });

      if (text) {
        let cleaned = text.trim();
        if (cleaned.startsWith("```json")) {
          cleaned = cleaned.replace(/^```json\s*/, "").replace(/```$/, "").trim();
        } else if (cleaned.startsWith("```")) {
          cleaned = cleaned.replace(/^```\s*/, "").replace(/```$/, "").trim();
        }
        try {
          // Verify valid JSON
          JSON.parse(cleaned);
          aiResponseText = cleaned;
        } catch (e) {
          console.warn("Failed to parse Gemini response as JSON:", e);
        }
      }
    }

    // Fallback if API key is not yet set or model fails
    if (!aiResponseText) {
      const firstCardName =
        typeof drawn_cards[0] === "string"
          ? drawn_cards[0]
          : drawn_cards[0].name;

      aiResponseText = JSON.stringify({
        summary: `The cosmos reflects your search through ${firstCardName}, urging conscious alignment with inner truth.`,
        interpretation: `As the veil parts, your question—"${
          user_question || "Daily Guidance"
        }"—reveals a significant spiritual pivot. The cards highlight a current transition where old cycles yield to heightened clarity. By honoring both the shadow and the light of these archetypes, the current tensions dissolve into grounded wisdom.`,
        card_insights: drawn_cards.map((c, idx) => ({
          card_name: typeof c === "string" ? c : c.name,
          position:
            typeof c === "string"
              ? `Position ${idx + 1}`
              : c.position_name || `Position ${idx + 1}`,
          insight:
            "Speaks to deep subconscious currents awaiting conscious integration. Trust the divine timing.",
        })),
        advice:
          "Ground your energies in stillness before taking decisive action. Allow intuition to be your compass over fear.",
        astrological_note:
          seeker_astrology?.sun
            ? `Harmonized with your ${seeker_astrology.sun} essence and cosmic vitality.`
            : "The elemental dance between fire and water is highlighted in your celestial sky.",
      });
    }

    return new Response(aiResponseText, {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("Tarot Reader Error:", error);
    return new Response(
      JSON.stringify({
        error: error instanceof Error ? error.message : "Unknown oracle error",
      }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  }
});
