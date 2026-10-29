# Play Data safety draft

Draft answers for the Play Console Data safety form, taken from the code on this branch. This is not the privacy policy. `PRIVACY_POLICY.md` and `website/privacy.html` are unchanged and still need a separate pass before production.

Package: `com.tarotapp.tarot_app`.

Answer **yes** to: data is encrypted in transit (HTTPS to Supabase and Gemini). Answer **yes** to: users can request deletion (in-app Delete account, plus the existing web page). Some data is optional (account, card photo, voice). Crash logs and ads are collected whether or not the seeker creates an account.

## Data types

| Play type | Collected | Shared | Why | Where in the code |
| --- | --- | --- | --- | --- |
| Email address | Yes, if the seeker creates an account | No, except the auth provider (Supabase) | Account management | `profiles.email`, Supabase Auth |
| User IDs | Yes | With Supabase, and a non-reversible purchase hash | Account management, fraud prevention | `auth.users` id, `purchase_receipt_audit.receipt_hash` (SHA-256, not the Play token) |
| Name | Optional display name | No | Account management | `profiles.display_name` |
| Other info (astrology) | Optional sun, moon, and rising signs | Sent to Gemini only as part of a reading request | App functionality | profile columns and the tarot-reader prompt |
| User-generated content: readings and questions | Yes | Sent to Google Gemini to produce the reading | App functionality | `readings` table; `tarot-reader` Edge Function |
| Photos | Yes, only when the seeker uses card scan | Sent to Gemini for that request. Not stored by Oraculum | App functionality | `lens_image_base64`. The function comment says the photo is not stored. Client refuses photos over about 1.5 MB after compression |
| Audio | Not stored by the app | See voice below | App functionality | `speech_to_text` / platform recognizer |
| Purchase history | Yes | Google Play processes the payment. Oraculum stores product id, expiry, and a hash of the token | App functionality | `verify-subscription`, `profiles.is_pro`, `profiles.pro_expires_at` |
| App interactions / crash logs | Yes | Firebase Crashlytics | Analytics (stability) | `lib/core/services/crash_reporting.dart`. Release builds only. No user id, no reading text |
| Device or other IDs (advertising ID) | Yes, if ads are shown | AdMob | Advertising | Rewarded ads in `AdMobService` |

## Voice

Question capture asks for **on-device** recognition first (`onDevice: true` in `hands_free_voice_service.dart` and `oracle_speech_service.dart`). If the platform cannot do on-device recognition, the voice oracle **falls back to the platform recognizer** (`onDevice: false`), which may send audio to Google or Apple for that session. The app does not record audio, does not upload an audio file, and does not write audio to Supabase or storage. The resulting **text** is the question and can be sent to Gemini with the reading. Declare audio as processed ephemerally by the platform speech service when the fallback runs, and declare the transcript as user content sent to Gemini.

## Readings and questions sent to Gemini

`tarot-reader` sends the question, card names and meanings, optional astrology, chat, and an optional card photo to the Gemini API. The API key stays in the Edge Function (`x-goog-api-key`). Free accounts get 3 readings a day and Pro accounts get 50, counted in `ai_daily_usage`. Declare this as user content processed for app functionality. If the Gemini project stays on the free tier, say so in the privacy policy later: Google may use that content to improve its products. This draft does not change the policy.

## Reports

Report AI output writes `reason`, an optional reading id, and up to 500 characters of the reading into `ai_reports`. The signed-in user can insert a row. Clients have no SELECT policy. Use these rows to review flagged output. Declare the report text as user content, not shared with third parties other than storage on Supabase.

## Crashlytics

Fatal crashes from release builds go to Firebase Crashlytics (Spark project `oraculum-5d56e`). Analytics is off. The app does not set a user identifier or custom keys. Crash text could theoretically contain an exception message, so keep questions and emails out of thrown errors. Account deletion does **not** delete Crashlytics data, because it is not tied to the Supabase user. Say that in the form: crash logs are retained by Firebase under its own schedule and are not part of the account-deletion request.

## Deletion

Delete account calls the `delete-account` Edge Function, which uses the service role to:

1. Delete the user's objects in every storage bucket (prefix is the user id).
2. Delete rows in `readings`, `ai_reports`, `ai_daily_usage`, `promo_redemptions`, `purchase_receipt_audit`, and `profiles`.
3. Revoke the user's sessions and delete the auth user.

The app then signs out and clears local preferences. Guest data never leaves the device except what a signed-in session uploaded. Crashlytics and Google Play's own purchase records are outside this delete.

## Suggested form toggles

- Data is encrypted in transit: **Yes**
- Users can request that data be deleted: **Yes**
- Data sold: **No**
- Account data (email, user id, name): collected, not shared for advertising
- User content (readings, questions, report text, card photos): collected and processed by Gemini for the feature
- Audio: not stored; platform speech recognizer only, on-device first
- Financial info: card numbers are not collected; Play Billing handles payment
- Crash logs: collected, shared with Firebase
- Advertising ID: collected, shared with AdMob
