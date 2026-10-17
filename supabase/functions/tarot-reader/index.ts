import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

interface DrawnCard {
  id?: string;
  name: string;
  arcana?: string;
  element?: string;
  is_reversed?: boolean;
  position_name?: string;
  meaning_upright?: string;
  meaning_reversed?: string;
}

interface TarotRequest {
  user_question?: string;
  spread_type?: string;
  drawn_cards?: (string | DrawnCard)[];
  seeker_astrology?: {
    sun?: string;
    moon?: string;
    rising?: string;
  };
  follow_up_prompt?: string;
  reading_summary?: string;
  reading_advice?: string;
  reading_interpretation?: string;
  chat_history?: { role: string; content: string }[];
  oracle_persona?: string;
  recent_journey_context?: string[];
  recurring_cards?: string[];
  cosmic_weather?: {
    moon_phase?: string;
    moon_illumination?: string;
    moon_zodiac?: string;
    planetary_transits?: string;
  };
  elemental_chemistry?: string;
  dream_narrative?: string;
  altar_consecration?: string;
}

const CANDIDATE_MODELS = [
  "gemini-2.0-flash",
  "gemini-1.5-flash",
  "gemini-1.5-pro",
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
      reading_summary,
      reading_advice,
      reading_interpretation,
      chat_history,
      oracle_persona,
      recent_journey_context,
      recurring_cards,
      cosmic_weather,
      elemental_chemistry,
      dream_narrative,
      altar_consecration,
    } = body;

    const geminiApiKey =
      Deno.env.get("GEMINI_API_KEY") || Deno.env.get("VERTEX_AI_API_KEY");

    // Dynamic Oracle Persona Voice
    let personaPrompt =
      "You speak as The High Priestess: ethereal, poetic, deeply intuitive, revealing subtle subconscious currents beneath the veil.";
    if (oracle_persona === "hermit") {
      personaPrompt =
        "You speak as The Hermit: quiet gravitas, patient introspection, timeless stoic philosophical wisdom, solitary contemplation.";
    } else if (oracle_persona === "empress") {
      personaPrompt =
        "You speak as The Empress: warm maternal compassion, unconditional self-worth, blooming abundance, gentle emotional healing.";
    } else if (oracle_persona === "magician") {
      personaPrompt =
        "You speak as The Magician: sharp incisive focus, empowering alchemical action, commanding clarity, and tactical manifestation steps.";
    } else if (oracle_persona === "shadow_mirror") {
      personaPrompt =
        "You speak as The Shadow Mirror: raw, psychologically rigorous truth, confronting ego traps, unintegrated shadows, and uncomfortable honesty.";
    }

    // 1. Follow-up conversational inquiry mode with full contextual memory
    if (follow_up_prompt) {
      let cardsContext = "";
      if (drawn_cards && drawn_cards.length > 0) {
        cardsContext = drawn_cards
          .map((c, i) => {
            if (typeof c === "string") return `• Card ${i + 1}: ${c}`;
            const orient = c.is_reversed ? "Reversed" : "Upright";
            const pos = c.position_name ? `(${c.position_name})` : "";
            const arcana = c.arcana ? `[${c.arcana.toUpperCase()}]` : "";
            return `• Card ${i + 1} ${pos}: ${c.name} [${orient}] ${arcana}`;
          })
          .join("\n");
      }

      const systemPrompt = `You are a legendary spiritual Oracle. ${personaPrompt}
Answer this seeker inquiry in the exact context of the sacred reading already unveiled:
- Seeker Question: "${user_question || "Daily Guidance"}"
- Spread Layout: "${spread_type || "Tarot Spread"}"
- Drawn Cards & Placements:
${cardsContext || "Sacred Tarot Spread"}
${reading_summary ? `- Prophecy Summary: "${reading_summary}"` : ""}
${reading_advice ? `- Spiritual Guidance: "${reading_advice}"` : ""}
${reading_interpretation ? `- Prophecy Excerpt: "${reading_interpretation.slice(0, 400)}..."` : ""}

Address the seeker directly with profound mystical gravitas, archetypal continuity, and actionable psychological/spiritual clarity. Directly reference the specific cards, their positions, or their reversals when relevant to the seeker's inquiry.`;

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
        const firstCardName = drawn_cards && drawn_cards.length > 0
          ? (typeof drawn_cards[0] === "string" ? drawn_cards[0] : drawn_cards[0].name)
          : "The Oracle";
        followUpAnswer = `In response to your inquiry—"${follow_up_prompt}"—the energy of ${firstCardName} reminds you that your inner discernment is your true anchor. Look deeper into where you feel tension, for therein lies the hidden doorway to breakthrough.`;
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
        const arcana = c.arcana ? `[${c.arcana.toUpperCase()}]` : "";
        return `Card ${index + 1} ${position}: ${c.name} [${orientation}] ${arcana} - Keywords: ${
          c.is_reversed ? c.meaning_reversed : c.meaning_upright
        }`;
      })
      .join("\n");

    const astroDetails = seeker_astrology
      ? `\nSeeker Natal Astrology: Sun in ${
          seeker_astrology.sun || "Unknown"
        }, Moon in ${seeker_astrology.moon || "Unknown"}, Rising in ${
          seeker_astrology.rising || "Unknown"
        }.`
      : "";

    const journeyDetails =
      recent_journey_context && recent_journey_context.length > 0
        ? `\nRecent Seeker Inquiries & History: ${recent_journey_context.join(" | ")}`
        : "";

    const recurringDetails =
      recurring_cards && recurring_cards.length > 0
        ? `\nRecurring 'Stalker' Cards Drawn Recently: ${recurring_cards.join(", ")}. Acknowledge why these patterns repeat.`
        : "";

    const weatherDetails = cosmic_weather
      ? `\nLive Cosmic Weather: Moon in ${cosmic_weather.moon_zodiac || "current sky"} (${
          cosmic_weather.moon_phase || "Moon"
        }, ${cosmic_weather.moon_illumination || "illumination"}). Transits: ${
          cosmic_weather.planetary_transits || "cosmic alignment"
        }.`
      : "";

    const synergyDetails = elemental_chemistry
      ? `\nElemental Composition & Alchemy: ${elemental_chemistry}. Analyze the chemical reaction between the dominant elements.`
      : "";

    const dreamContext = dream_narrative
      ? `\nJungian Dream Narrative: "${dream_narrative}". Synthesize the dream's subconscious archetypes into this reading.`
      : "";

    const altarContext = altar_consecration
      ? `\nAltar Consecration Anchor: "${altar_consecration}". Weave this sacred intention through the reading.`
      : "";

    const systemPrompt = `You are a legendary spiritual Oracle. ${personaPrompt}
Analyze the cards through the lens of master tarot hermeneutics:
1. OPTICAL GAZE & SPATIAL TENSION: Examine the visual dialogue between adjacent cards. Notice whether figures gaze towards each other (dialogue, confrontation, synthesis) or turn away (avoidance, departure, unresolved past). Highlight this directional tension in the narrative.
2. KARMIC WEIGHTING: Calculate Major Arcana presence. If 2 or more Major Arcana cards are present, declare that the seeker is navigating an initiatory, fated Soul Crossroads rather than mundane day-to-day circumstance.
3. ELEMENTAL DIGNITIES: Synthesize the elemental chemistry (Fire/Water/Air/Earth) and how they harmonize or clash.
4. TANGIBLE 60-SECOND MICRO-RITUAL: Provide an actionable, somatic 60-second integration ritual (breathwork cadence, grounding touch, or focus prompt) tailored to the elemental alchemy that grounds this prophecy into the physical body.`;

    const userPrompt = `
Seeker Question: "${user_question || "What guidance does the cosmos have for me at this juncture?"}"
Spread Type: "${spread_type || "Custom Spread"}"${astroDetails}${weatherDetails}${synergyDetails}${journeyDetails}${recurringDetails}${dreamContext}${altarContext}

Drawn Cards:
${cardsDescription}

Provide your reading in strictly valid JSON format matching this schema:
{
  "summary": "A poetic 1-2 sentence distillation of the reading's core energy matching your persona voice",
  "interpretation": "A deep narrative linking all drawn cards together in response to the seeker's question, highlighting optical gaze tension, card-to-card transitions, and karmic crossroads",
  "card_insights": [
    {
      "card_name": "Card name",
      "position": "Position name",
      "insight": "Specific message for this placement and orientation"
    }
  ],
  "advice": "Empathetic, actionable guidance for the seeker moving forward",
  "micro_ritual": "A tangible, 60-second somatic action, breathwork cadence, physical anchor, or journaling prompt tailored to this reading that the seeker can do right now to integrate this prophecy.",
  "astrological_note": "A celestial/elemental resonance note aligning with the seeker's energies",
  "journey_recall": "1-2 sentences weaving past readings or recurring cards into this moment, explaining why the cycle has returned or evolved",
  "elemental_chemistry": "Specific synthesis of how the elements (Fire, Water, Air, Earth) interact in this spread (e.g. steam, conflagration, or grounded oasis)",
  "cosmic_weather": "How the current live Moon phase and cosmic transits transmute or amplify the message of these cards",
  "scrying_prompts": [
    "Specific follow-up question 1",
    "Specific follow-up question 2",
    "Specific follow-up question 3"
  ]
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
        }"—reveals a significant spiritual pivot. The optical dialogue between your cards reflects a profound threshold: tensions dissolve when conscious presence meets shadow truth. By honoring the directional gaze of these archetypes, old loops yield to grounded wisdom.`,
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
        micro_ritual: `Close your eyes for 60 seconds. Inhale for 4 counts, anchor the archetype of ${firstCardName} at your heart for 4 counts, and exhale for 6 counts releasing lingering tension. Rest your right palm over your heart to seal this alignment.`,
        astrological_note:
          seeker_astrology?.sun
            ? `Harmonized with your ${seeker_astrology.sun} essence and cosmic vitality.`
            : "The elemental dance between fire and water is highlighted in your celestial sky.",
        journey_recall: recurring_cards && recurring_cards.length > 0
          ? `The reappearance of ${recurring_cards.join(", ")} indicates an unintegrated threshold seeking your full surrender.`
          : "Your path deepens with each reading; the cards acknowledge the steady awakening of your inner sight.",
        elemental_chemistry: elemental_chemistry || "Fire meeting Water: volatile creative passion calling for grounded stillness.",
        cosmic_weather: cosmic_weather
          ? `Under the ${cosmic_weather.moon_phase} in ${cosmic_weather.moon_zodiac}, the veil between intuition and manifestation thins.`
          : "The celestial heavens align to support clear reflection and spiritual clarity.",
        scrying_prompts: [
          `How can I best embody the counsel of ${firstCardName}?`,
          "What hidden obstacle or fear must I surrender this week?",
          "What sacred ritual will harmonize my path before the next moon phase?",
        ],
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

