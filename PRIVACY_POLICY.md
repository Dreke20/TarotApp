# Privacy Policy for Oraculum: Sacred AI Tarot

**Effective Date:** October 16, 2026  
**Last Updated:** October 27, 2026

Welcome to **Oraculum: Sacred AI Tarot** ("Oraculum", "we", "our", or "us"). We honor your sacred spiritual privacy. This Privacy Policy details how data is collected, processed, and safeguarded when you use our mobile application and associated services across Android devices.

---

### 1. Information We Collect

#### A. Information You Provide Directly
- **Account Credentials:** When you choose to sign in via Supabase Authentication (Email or OAuth), we store your email address and unique account identifier (`auth.uid()`).
- **Seeker Moniker & Natal Astrology:** You may optionally supply a seeker moniker, birth date, birth time, and birth location for calculating your sacred astronomical ephemeris (Sun, Moon, and Rising sign).
- **Tarot Invocations & Intentions:** Questions, journal reflections, custom spread arrangements, and dream narratives entered during your divination journeys.
- **Physical Card Scans (Tarot Lens):** When using Tarot Lens, camera capture or photo gallery selection is used to identify physical tarot cards. See Section 3 for our ephemeral processing commitment.
- **Spoken Dialogue & Voice Inquiries:** When engaging in two-way spoken conversation with the Oracle, your speech input is converted to text. See Section 3.

#### B. On-Device Guest Sanctum (Zero-Cloud Mode)
If you explore Oraculum as an anonymous guest without signing in, all card draws, readings, grimoire reflections, and dream entries are saved **strictly on your physical device** using local encrypted preferences. Guest data is never transmitted to our cloud databases.

#### C. Ephemeral Sensor & Hardware Processing
- **Haptic & Accelerometer Sensors:** Gyroscope and accelerometer tilt data are processed ephemerally on-device to produce real-time 3D holographic card foil tilt and tactile card-shuffle feedback. This sensor data is never saved, logged, or transmitted.
- **Biometric Security:** If you enable the App Sanctum Lock, fingerprint or facial biometric authentication is handled exclusively by the Android OS Keystore / StrongBox (`local_auth`). Oraculum never accesses, receives, or stores your raw biometric markers.
- **Hardware-Backed Cryptographic Vault:** High-security tokens, Starlight Passes, and offline Pro entitlements are sealed using dynamic 256-bit keys inside the hardware Android Keystore (`flutter_secure_storage`).

---

### 2. How We Use Your Information
- To generate personalized AI tarot interpretations, optical gaze hermeneutics, and celestial transit scrying.
- To synchronize your reading history, consecrated altars, and bookmarked grimoires across devices (for registered seekers).
- To verify and restore Google Play In-App Purchases, Oracle Pro subscriptions, and Celestial Bazaar acquisitions.
- To display non-intrusive rewarded video offerings via Google AdMob (strictly for free-tier seekers seeking Starlight Passes).
- To calculate live moon phases, lunar illumination, and astrological alignments.

---

### 3. Artificial Intelligence & Third-Party Processing

#### A. Generative AI Synthesis (Google Gemini via Supabase Edge Functions)
- All channeled readings, follow-up inquiries, and spoken dialogue are synthesized through secure **Supabase Edge Functions** that route requests to Google Gemini.
- Only the specific cards drawn, sanitized inquiry text, and celestial placements are transmitted.
- Prompts are segregated using Gemini's first-class `systemInstruction` architecture, preventing prompt injection or data leakage.
- **No Training on Personal Data:** Your personal inquiries, birth details, and readings are not used to train public machine learning foundation models.
- **Safety Guardrails:** Automated safety filters strictly enforce ethical divination, prohibiting hate speech, harassment, sexually explicit output, or medical/legal/financial directives.
- **In-App Reporting:** Seekers may report or flag any generated reading immediately via the in-app **"Report"** button on the reading result sheet.

#### B. Tarot Lens & Camera Privacy
- When scanning physical cards, the photo is transmitted over an encrypted TLS 1.3 connection to our Edge Function for single-pass Gemini Vision identification.
- The photo is processed **ephemerally** in memory and is **never stored, cataloged, or linked** to user accounts.
- Camera permission (`android.permission.CAMERA`) is optional; seekers can always select cards manually.

#### C. Spoken Audio & Microphone Privacy
- When using live voice dialogue, microphone access (`android.permission.RECORD_AUDIO`) is used solely to capture spoken inquiries in real time.
- Audio recordings are processed ephemerally via speech recognition and are **never recorded, stored on persistent disks, or sold**.

#### D. Google Play Billing & Monetization
- All purchases (Oracle Pro Yearly, Monthly, Lifetime, and Celestial Bazaar artifacts) are processed exclusively through **Google Play In-App Billing**. We never collect, process, or store payment card numbers, banking credentials, or billing addresses.
- Celestial Shards and Starlight Tokens hold no real-world monetary cash value and cannot be redeemed outside the application.
- Free-tier seekers may view optional rewarded video ads via Google AdMob, which collects advertising identifiers (GAID) in compliance with Google Play Advertising Policies. Oracle Pro subscribers enjoy a 100% ad-free experience.

---

### 4. Data Security, Retention & Deletion

- **Encryption in Transit & at Rest:** All network communication is enforced over TLS 1.3 / HTTPS (`cleartextTrafficPermitted="false"`). Server databases enforce PostgreSQL Row Level Security (RLS) restricting all access to `auth.uid()`.
- **In-App Account & Data Deletion:** Seekers can delete their account and purge all cloud records instantly inside the application by navigating to **Profile > DELETE ACCOUNT & DATA**. This immediately purges your Supabase profile, cloud reading history, and clears local cached storage.
- **Web-Based Deletion Portal:** In compliance with Google Play policies, seekers can also request complete account and data deletion online without opening the application:  
  - **Portal URL:** `https://oracalum.netlify.app/delete-account`  
  - **Public Repository Form:** `https://github.com/Dreke20/TarotApp/blob/main/ACCOUNT_DELETION.md`  
  - **Email Request:** Email `oraculum26@gmail.com` or `dreke.dev@gmail.com` with the subject *"Data Deletion Request"*. All records will be permanently erased within 30 days.

---

### 5. Spiritual & Entertainment Disclaimer
Oraculum is an entertainment, spiritual mindfulness, and personal reflection tool. Interpretations and celestial readings are generated by artificial intelligence for personal insight and creative contemplation. Oraculum does not offer, and should never substitute for, professional medical, psychological, legal, or financial advice.

---

### 6. Children's Privacy (Under 13)
Oraculum is designed for seekers aged **13 and older** (Teen / Everyone 10+). We do not knowingly collect or solicit personal information from children under 13. If we discover that personal data from a child under 13 has been collected, it is immediately deleted.

---

### 7. Global Privacy Rights (GDPR & CCPA)
- **Right to Access & Portability:** You may export your grimoire readings as digital parchments or request a full copy of your account data.
- **Right to Rectification:** You can update your moniker, astrology birth charts, or email directly in the app.
- **Right to Erasure ("Right to Be Forgotten"):** Full account deletion is available at any time via in-app settings or our web portal.
- **No Data Resale:** We do not sell, rent, or monetize your personal or spiritual data to data brokers or third parties.

---

### 8. Contact & Sanctuary Desk
For inquiries, rights requests, or feedback regarding this Privacy Policy:
- **Privacy & Security Email:** `oraculum26@gmail.com` / `dreke.dev@gmail.com`
- **Official Website:** `https://oracalum.netlify.app`
- **Account Deletion Portal:** `https://oracalum.netlify.app/delete-account`
- **Developer GitHub:** `https://github.com/Dreke20/TarotApp`
