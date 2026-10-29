import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.42.0";
import { prepareAiRequest, type AiDeps } from "../_shared/ai_guard.ts";
import { decodedBase64Bytes, MAX_IMAGE_BYTES } from "../_shared/ai_limits.ts";
import { callGemini } from "../_shared/gemini.ts";
import { proStillActive } from "../_shared/play_billing.ts";

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
  dialogue_prompt?: string;
  dialogue_history?: { role: string; content: string }[];
  // Tarot Lens: photo of a physical card to identify
  lens_image_base64?: string;
  lens_mime_type?: string;
  card_catalog?: { id: string; name: string }[];
}

function sanitizeInput(text: unknown, maxLength = 600): string {
  if (typeof text !== "string") return "";
  let sanitized = text
    // Strip control characters (except standard whitespace)
    .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/g, "")
    // Strip HTML/script tags
    .replace(/<[^>]*>?/gm, "")
    // Defang markdown delimiters used for prompt injection
    .replace(/```/g, "'''")
    // Defang system override tokens
    .replace(/\[\/?(?:system|instruction|admin|override|developer)\]/gi, "")
    .trim();

  if (sanitized.length > maxLength) {
    sanitized = sanitized.slice(0, maxLength);
  }
  return sanitized;
}

function aiDeps(): AiDeps {
  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !anonKey || !serviceKey) {
    throw new Error("missing_supabase_keys");
  }
  const admin = createClient(supabaseUrl, serviceKey);
  return {
    getUser: async (authHeader) => {
      const client = createClient(supabaseUrl, anonKey, {
        global: { headers: { Authorization: authHeader } },
      });
      const token = authHeader.replace(/^Bearer\s+/i, "");
      const { data, error } = await client.auth.getUser(token);
      if (error || !data.user) return null;
      return { id: data.user.id };
    },
    proActive: async (userId, now) => {
      const { data, error } = await admin
        .from("profiles")
        .select("is_pro, pro_expires_at")
        .eq("id", userId)
        .maybeSingle();
      if (error) throw new Error("profile_read_failed");
      const active = proStillActive(
        Boolean(data?.is_pro),
        data?.pro_expires_at ?? null,
        now,
      );
      if (data?.is_pro && !active) {
        await admin.from("profiles").update({
          is_pro: false,
          updated_at: now.toISOString(),
        }).eq("id", userId);
      }
      return active;
    },
    consume: async (userId, limit) => {
      const { data, error } = await admin.rpc("consume_ai_reading", {
        p_user_id: userId,
        p_limit: limit,
      });
      if (error) throw new Error("quota_failed");
      if (data == null) return null;
      const used = Number(data);
      return Number.isFinite(used) ? used : null;
    },
  };
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  let prepared;
  try {
    prepared = await prepareAiRequest(req, aiDeps());
  } catch (err) {
    const missing = err instanceof Error && err.message === "missing_supabase_keys";
    return new Response(
      JSON.stringify({
        error: missing
          ? "Server configuration error (missing keys)."
          : "Could not authorize this reading.",
      }),
      { status: missing ? 500 : 401, headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  }
  if (!prepared.ok) return prepared.response;

  try {
    const body = prepared.body as TarotRequest;
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
      dialogue_prompt,
      dialogue_history,
    } = body;

    const geminiApiKey =
      Deno.env.get("GEMINI_API_KEY") || Deno.env.get("VERTEX_AI_API_KEY");

    // L. Tarot Lens: identify a physical card from a photo with Gemini vision.
    // The photo is only forwarded to Gemini for this request; nothing is stored.
    if (body.lens_image_base64) {
      const jsonHeaders = { ...corsHeaders, "Content-Type": "application/json" };
      const catalog = Array.isArray(body.card_catalog)
        ? body.card_catalog.filter((c) => c && typeof c.id === "string").slice(0, 100)
        : [];
      const validIds = new Set(catalog.map((c) => c.id));
      const imageData = String(body.lens_image_base64);
      const mimeType = ["image/jpeg", "image/png", "image/webp", "image/heic"].includes(
        String(body.lens_mime_type),
      )
        ? String(body.lens_mime_type)
        : "image/jpeg";

      if (decodedBase64Bytes(imageData) > MAX_IMAGE_BYTES) {
        return new Response(JSON.stringify({ error: "image_too_large" }), {
          status: 413,
          headers: jsonHeaders,
        });
      }
      if (!geminiApiKey || validIds.size === 0) {
        return new Response(
          JSON.stringify({ card_id: null, reason: "recognition_unavailable" }),
          { headers: jsonHeaders },
        );
      }

      const catalogText = catalog.map((c) => `${c.id}: ${String(c.name).slice(0, 60)}`).join("\n");
      const lensPrompt = `You identify physical tarot cards from photos.
Look at the photo and decide which single tarot card is the main card shown. Use the printed title, numeral, suit symbols, pip count and artwork. Decks vary in art style, so rely on the title and numbering when the art differs from Rider-Waite-Smith.
The card is reversed when its artwork and title are upside down from the viewer's perspective.
If no tarot card is clearly visible, or you cannot tell which card it is, return null for card_id.
Respond with strictly valid JSON matching exactly:
{"card_id": "<one id from the list below, or null>", "is_reversed": <true|false>, "confidence": <integer 0-100, how sure you are of the card_id>, "visible_symbols": ["up to 6 short phrases naming symbols actually visible in the photo"]}
Card list (id: name):
${catalogText}`;

      const text = await callGemini(geminiApiKey, {
        systemInstruction: {
          parts: [{ text: "You are an expert Tarot Vision identifier. Output strictly valid JSON." }],
        },
        contents: [
          {
            role: "user",
            parts: [
              { inline_data: { mime_type: mimeType, data: imageData } },
              { text: lensPrompt },
            ],
          },
        ],
        generationConfig: {
          temperature: 0,
          // 2.5 models spend part of this budget thinking; 300 truncated the JSON.
          maxOutputTokens: 2048,
          responseMimeType: "application/json",
        },
      });

      let result: Record<string, unknown> = { card_id: null, reason: "not_recognized" };
      if (text) {
        try {
          const cleaned = text.trim().replace(/^```(?:json)?\s*/, "").replace(/```$/, "").trim();
          const parsed = JSON.parse(cleaned);
          const id = typeof parsed.card_id === "string" ? parsed.card_id : null;
          if (id && validIds.has(id)) {
            const conf = Math.round(Number(parsed.confidence));
            result = {
              card_id: id,
              is_reversed: parsed.is_reversed === true,
              confidence: Number.isFinite(conf) ? Math.min(99, Math.max(1, conf)) : 50,
              visible_symbols: Array.isArray(parsed.visible_symbols)
                ? parsed.visible_symbols
                    .filter((s: unknown) => typeof s === "string")
                    .slice(0, 6)
                    .map((s: string) => s.slice(0, 60))
                : [],
            };
          }
        } catch (e) {
          console.warn("Tarot Lens: could not parse Gemini response", e);
        }
      }
      return new Response(JSON.stringify(result), { headers: jsonHeaders });
    }

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

    // 0. Two-way spoken dialogue mode (Conversational Voice Oracle)
    if (dialogue_prompt) {
      const sanitizedDialogue = sanitizeInput(dialogue_prompt, 400);
      const drawn = (drawn_cards || [])
        .map((c) => {
          if (typeof c === "string") return c;
          const orient = c.is_reversed ? "Reversed" : "Upright";
          const meaning = c.is_reversed ? c.meaning_reversed : c.meaning_upright;
          return `${c.name} (${orient}) - ${meaning ?? ""}`;
        })
        .join("; ");

      const dialogueSystem = `You are a legendary spiritual Oracle holding a live, spoken conversation. ${personaPrompt}
Rules:
- Your words will be read aloud by a voice engine: reply in at most 90 words, plain sentences, no markdown, no lists, no emojis.
- Speak directly to the seeker in second person with mystical warmth and practical clarity.
- ${drawn ? `A card was just drawn for this turn: ${drawn}. Weave it naturally into your answer.` : "No new card was drawn this turn; draw on earlier cards in the conversation if relevant."}
- End with one short, open question that invites the seeker to continue.
- Strict Safety Rule: Never give medical, legal, or financial directives; gently suggest a qualified professional when such topics arise.`;

      let dialogueAnswer = "";
      if (geminiApiKey) {
        const history = (dialogue_history || []).slice(-12).map((msg) => ({
          role: msg.role === "model" ? "model" : "user",
          parts: [{ text: sanitizeInput(msg.content, 500) }],
        }));
        history.push({
          role: "user",
          parts: [{ text: `Seeker says: "${sanitizedDialogue}"` }],
        });
        const text = await callGemini(geminiApiKey, {
          systemInstruction: {
            parts: [{ text: dialogueSystem }],
          },
          contents: history,
          generationConfig: { temperature: 0.8, maxOutputTokens: 1024 },
        });
        if (text) dialogueAnswer = text.trim();
      }

      if (!dialogueAnswer) {
        dialogueAnswer = drawn
          ? `I hear you. ${drawn.split(" - ")[0]} rises to meet your words, asking you to trust what you already sense. Where in your life does this feel most alive right now?`
          : "I hear you, seeker. Sit with that feeling a moment longer. What part of it asks for your attention first?";
      }

      return new Response(JSON.stringify({ answer: dialogueAnswer }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 1. Follow-up conversational inquiry mode with full contextual memory
    if (follow_up_prompt) {
      const sanitizedFollowUp = sanitizeInput(follow_up_prompt, 400);
      const sanitizedQuestion = sanitizeInput(user_question, 300) || "Daily Guidance";
      const sanitizedSpread = sanitizeInput(spread_type, 60) || "Tarot Spread";

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
- Seeker Question: "${sanitizedQuestion}"
- Spread Layout: "${sanitizedSpread}"
- Drawn Cards & Placements:
${cardsContext || "Sacred Tarot Spread"}
${reading_summary ? `- Prophecy Summary: "${sanitizeInput(reading_summary, 200)}"` : ""}
${reading_advice ? `- Spiritual Guidance: "${sanitizeInput(reading_advice, 200)}"` : ""}
${reading_interpretation ? `- Prophecy Excerpt: "${sanitizeInput(reading_interpretation.slice(0, 400), 400)}..."` : ""}

Address the seeker directly with profound mystical gravitas, archetypal continuity, and actionable psychological/spiritual clarity. Directly reference the specific cards, their positions, or their reversals when relevant to the seeker's inquiry.
Strict Safety Rule: Never give medical, legal, or financial directives; advise consulting licensed professionals.`;

      let followUpAnswer = "";
      if (geminiApiKey) {
        const historyParts = (chat_history || []).map((msg) => ({
          role: msg.role === "model" ? "model" : "user",
          parts: [{ text: sanitizeInput(msg.content, 500) }],
        }));

        historyParts.push({
          role: "user",
          parts: [
            {
              text: `Seeker Inquiry: "${sanitizedFollowUp}"`,
            },
          ],
        });

        const text = await callGemini(geminiApiKey, {
          systemInstruction: {
            parts: [{ text: systemPrompt }],
          },
          contents: historyParts,
          generationConfig: { temperature: 0.75, maxOutputTokens: 1024 },
        });

        if (text) {
          followUpAnswer = text.trim();
        }
      }

      if (!followUpAnswer) {
        const firstCardName = drawn_cards && drawn_cards.length > 0
          ? (typeof drawn_cards[0] === "string" ? drawn_cards[0] : drawn_cards[0].name)
          : "The Oracle";
        followUpAnswer = `In response to your inquiry—"${sanitizedFollowUp}"—the energy of ${firstCardName} reminds you that your inner discernment is your true anchor. Look deeper into where you feel tension, for therein lies the hidden doorway to breakthrough.`;
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

    const sanitizedQuestion = sanitizeInput(user_question, 300) || "What guidance does the cosmos have for me at this juncture?";
    const sanitizedSpread = sanitizeInput(spread_type, 60) || "Custom Spread";
    const sanitizedDream = sanitizeInput(dream_narrative, 500);
    const sanitizedAltar = sanitizeInput(altar_consecration, 200);

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
        ? `\nRecent Seeker Inquiries & History: ${recent_journey_context.map((c) => sanitizeInput(c, 150)).join(" | ")}`
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

    const dreamContext = sanitizedDream
      ? `\nJungian Dream Narrative: "${sanitizedDream}". Synthesize the dream's subconscious archetypes into this reading.`
      : "";

    const altarContext = sanitizedAltar
      ? `\nAltar Consecration Anchor: "${sanitizedAltar}". Weave this sacred intention through the reading.`
      : "";

    const systemPrompt = `You are a legendary spiritual Oracle. ${personaPrompt}
Analyze the cards through the lens of master tarot hermeneutics:
1. OPTICAL GAZE & SPATIAL TENSION: Examine the visual dialogue between adjacent cards. Notice whether figures gaze towards each other (dialogue, confrontation, synthesis) or turn away (avoidance, departure, unresolved past). Highlight this directional tension in the narrative.
2. KARMIC WEIGHTING: Calculate Major Arcana presence. If 2 or more Major Arcana cards are present, declare that the seeker is navigating an initiatory, fated Soul Crossroads rather than mundane day-to-day circumstance.
3. ELEMENTAL DIGNITIES: Synthesize the elemental chemistry (Fire/Water/Air/Earth) and how they harmonize or clash.
4. TANGIBLE 60-SECOND MICRO-RITUAL: Provide an actionable, somatic 60-second integration ritual (breathwork cadence, grounding touch, or focus prompt) tailored to the elemental alchemy that grounds this prophecy into the physical body.
5. STRICT SAFETY GUARDRAIL: Never give medical, legal, or financial directives; gently suggest qualified professionals when such themes emerge.
6. OUTPUT FORMAT: Respond strictly in valid JSON matching the requested schema.`;

    const userPrompt = `Seeker Question: "${sanitizedQuestion}"
Spread Type: "${sanitizedSpread}"${astroDetails}${weatherDetails}${synergyDetails}${journeyDetails}${recurringDetails}${dreamContext}${altarContext}

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
        systemInstruction: {
          parts: [{ text: systemPrompt }],
        },
        contents: [
          {
            role: "user",
            parts: [{ text: userPrompt }],
          },
        ],
        generationConfig: {
          temperature: 0.75,
          maxOutputTokens: 4096,
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
          sanitizedQuestion
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

