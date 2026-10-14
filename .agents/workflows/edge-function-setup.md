---
description: Use this when you need to deploy the free Gemini 1.5 Flash backend pipe.
---

@workspace Write the structural configuration code for a Supabase Edge Function under `supabase/functions/tarot-reader/index.ts`. 
The function must integrate with the `@google/generative-ai` ESM module to hit the Gemini 1.5 Flash API endpoint. 
Configure the server logic to read the incoming JSON payload (`cards`, `question`) securely, feed it to a highly structural mystical system prompt, and return the payload. 
Include an example terminal command to push the local environment secret keys.
