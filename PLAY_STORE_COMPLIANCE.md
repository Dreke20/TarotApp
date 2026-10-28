# 🛡️ Google Play Store Compliance & Policy Declarations Playbook
## Oraculum: Sacred AI Tarot (`oraculum.dirtysouth`)

This document serves as the authoritative, comprehensive guide for completing all mandatory **App Content**, **Policy Declarations**, **Play App Signing**, and **US Export Laws** requirements in the **Google Play Console**.

---

## 📋 Section 1: Developer Program Policies Confirmation

### 1. The Declaration Statement
In Google Play Console under **Policy > App Content > Declarations**:
> *"Confirm app meets the Developer Program Policies: The application meets Developer Program Policies."*

Select: **"Confirm" / "I confirm that my app complies with Developer Program Policies"**

---

### 2. Comprehensive Policy Audit & Justification Matrix

| Policy Area | Play Store Requirement | Oraculum Implementation & Safeguard | Status |
| :--- | :--- | :--- | :--- |
| **Generative AI Content** | • Must prevent prohibited/harmful outputs<br>• Must provide in-app user reporting<br>• Must be transparent about AI generation | • [`PromptSanitizerService`](lib/core/services/prompt_sanitizer_service.dart) sanitizes injection attacks, hate speech, and delimiter tampering.<br>• [`ReadingResultSheet`](lib/features/tarot/presentation/widgets/reading_result_sheet.dart) includes an in-app **"Report"** modal allowing seekers to flag inappropriate responses.<br>• Edge Function enforces Gemini `systemInstruction` isolation and server-side defanging.<br>• Explicit AI disclosure badge and spiritual contemplation disclaimer displayed on all AI outputs. | **Compliant ✅** |
| **Account & Data Deletion** | • In-app deletion path<br>• Public web deletion URL | • In-app deletion: **Profile > DELETE ACCOUNT & DATA** with permanent local cache & Supabase purge.<br>• Web deletion link: `https://oracalum.netlify.app/delete-account` (listed in [`PRIVACY_POLICY.md`](PRIVACY_POLICY.md) and [`STORE_LISTING.md`](STORE_LISTING.md)). | **Compliant ✅** |
| **Exact Alarm Policy** | • Restricted permission; only allowed for alarm clocks or calendar event apps | • `android.permission.SCHEDULE_EXACT_ALARM` has been **completely removed** from [`AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml).<br>• [`SanctuaryNotificationService`](lib/features/notifications/data/sanctuary_notification_service.dart) uses `AndroidScheduleMode.inexactAllowWhileIdle`, eliminating restricted alarm review rejections. | **Compliant ✅** |
| **Camera & Microphone Permissions** | • Must declare `android.hardware.camera` and `android.hardware.microphone` as optional (`required="false"`)<br>• Ephemeral data processing | • In `AndroidManifest.xml`, both camera and microphone hardware are set to `required="false"` so devices without them can still install.<br>• Card photos and speech audio are processed ephemerally in RAM and never written to persistent server storage. | **Compliant ✅** |
| **Hardware Keystore & Anti-Tamper** | • Data safety and secure storage on-device | • Uses `flutter_secure_storage: ^11.2.0` with dynamic 256-bit Keystore master keys and HMAC-SHA256 signatures to protect pass tokens and offline entitlements from local XML manipulation. | **Compliant ✅** |
| **Misleading Claims & Health/Finance** | • Cannot make medical, health, or guaranteed financial predictions | • Strict disclaimer in store listing and reading sheets: *"For spiritual reflection, creative inspiration, and personal insight. Oraculum does not offer licensed medical, psychological, legal, or financial advice."* | **Compliant ✅** |
| **Google Play Billing** | • Digital goods and subscriptions must use Google Play In-App Billing | • [`InAppPurchaseService`](lib/features/subscription/data/in_app_purchase_service.dart) uses `in_app_purchase: ^3.3.1` (Google Play Billing Library). No external payment gateways. | **Compliant ✅** |
| **Advertising & AdMob** | • Ads must not interfere with normal app usage<br>• Target audience compliance | • [`AdMobService`](lib/core/services/admob_service.dart) enforces strict 4-minute cooldowns, never shows ads during active divination rituals, and suppresses 100% of ads for Oracle Pro subscribers. | **Compliant ✅** |
| **Target Audience & Children** | • Apps not for children must declare target age | • Target audience declared as **13 and older** (Teen / Everyone 10+). Oraculum does not participate in the Families program. | **Compliant ✅** |

---

## 🔑 Section 2: Play App Signing

### 1. The Terms of Service Acceptance
In Google Play Console under **Release > Setup > App integrity**:
> *"To publish Android App Bundles on Google Play you need to accept the Play App Signing Terms of Service."*

Select: **"Accept the Play App Signing Terms of Service"** and **"Use Google-generated key"** (Recommended by Google).

### 2. How Play App Signing Works for Oraculum
1. **Google Manages the App Signing Key:** Google safely stores the master key used to sign APKs delivered to users' devices.
2. **Developer Signs with Upload Key:** You sign your Android App Bundle (`.aab`) with your keystore and upload it to Google Play.
3. **Google Verifies & Re-Signs:** Google verifies your upload key, strips the upload certificate, and signs the distributed APKs with the master Play App Signing Key.

### 3. Production App Bundle
- **Location:** `build/app/outputs/bundle/release/app-release.aab` (95.7 MB).
- **Format:** Android App Bundle (AAB), optimized with R8 shrinking and tree-shaken resources.

---

## 🌐 Section 3: US Export Laws & Encryption Compliance

### 1. The Declaration Statement
In Google Play Console under **Policy > App Content > US export laws**:
> *"I acknowledge that my software application may be subject to United States export laws, regardless of my location or nationality. I agree that I have complied with all such laws, including any requirements for software with encryption functions. I hereby certify that my application is authorized for export from the United States under these laws."*

Check the checkbox: **"I accept and certify compliance with US export laws."**

### 2. Encryption Questionnaire Step-by-Step Answers

When Google Play or the US Export Administration Regulations (EAR) questionnaire asks:

#### Question 1: *"Does your app use, contain, or incorporate encryption functions?"*
👉 Answer: **Yes**

#### Question 2: *"Is your app exempt from the requirements of the Export Administration Regulations (EAR) or does it qualify for an exception?"*
👉 Answer: **Yes**

#### Question 3: *"Select the qualification or exemption under EAR:"*
👉 Answer: **Note 4 to Category 5, Part 2 (Mass Market / Consumer Software) or Section 740.17(b)(1)**

### 3. Legal & Technical Justification for Export Exemption
Oraculum qualifies for the **Mass Market / Public Exemption** under EAR Title 15 CFR § 740.17:
1. **Standard Transport Cryptography:** The application solely utilizes standard, publicly available cryptographic protocols (HTTPS / TLS 1.3 via `dart:io` and Google/BoringSSL) to transmit encrypted requests to Supabase and Google Gemini AI.
2. **Standard Local Cryptographic Primitives:** The application uses standard HMAC-SHA256 message digests for local storage tamper prevention ([`EncryptedVaultStorage`](lib/core/services/encrypted_vault_storage.dart)) and standard platform Biometric Keystore APIs (`local_auth`).
3. **No Proprietary Cryptography:** The app contains no proprietary, non-standard, or military-grade encryption algorithms.
4. **General Public Availability:** The software is available to the general public free of restriction under consumer app store channels.
- **Export Control Classification Number (ECCN):** `5D992.c` (Mass market software) or `EAR99`.
- **CCATS:** *Not required* (NLR - No License Required).

---

## 🛡️ Section 4: Google Play App Review Credentials

When Google Play App Review requests test credentials or app access instructions:

> **App Access Declaration:**  
> *"All functionality is available without special access or login credentials."*

### Reviewer Instructions to Include in the Review Notes:
```text
Oraculum is an esoteric divination app designed for open, anonymous spiritual exploration.

1. GUEST ACCESS:
Seekers can immediately access all core features (Daily Guidance, Three Fates spread, Tarot Codex, Runes, I Ching, Moon Phase, Altar Cloths, and Card Back Geometries) directly upon opening the app without registering an account.

2. PRO REVIEW ACCESS:
Premium features (Celtic Cross 10-card spread, multi-turn AI conversation, and premium soundscapes) require an Oracle Pro entitlement from Google Play. There is no promo or reviewer unlock code.
- Add the review Google account as a license tester in Play Console.
- Complete a license-test purchase for oracle_pro_yearly, oracle_pro_monthly, or oracle_pro_lifetime.
- Restore purchases on another device with that same account if the entitlement needs to be redelivered.
```

---

## 📊 Section 5: Google Play Data Safety Form Answers

| Data Category | Collected? | Shared? | Purpose | Encrypted in Transit? | Ephemeral / Deletable? |
| :--- | :---: | :---: | :--- | :---: | :---: |
| **Personal Info (Email)** | Optional | No | Account sign-in & sync (Supabase Auth) | Yes (TLS 1.3) | User can delete via Profile |
| **Personal Info (Name/Moniker)** | Optional | No | App personalization & natal chart | Yes (TLS 1.3) | User can delete via Profile |
| **Financial Info** | No | No | Managed 100% by Google Play Billing | Yes (Google) | N/A (Handled by Google) |
| **Health & Fitness** | No | No | N/A | N/A | N/A |
| **Messages / Audio** | No | No | Voice recognition is on-device TTS/STT | Ephemeral | Not stored |
| **Photos / Videos** (Photos) | Yes | No | App functionality: Tarot Lens sends the card photo to Google Gemini (service provider) to identify the card. Optional; users can pick a card by hand. | Yes (TLS 1.3) | Processed ephemerally, not stored |
| **Location Data** | No | No | Birth place lookup is client-side text | No | Not tracked |
| **App Activity** | Yes | No | Spread usage & local reading history | Yes (TLS 1.3) | User can purge anytime |
| **App Info / Diagnostics** | Yes | No | Crash reports & error monitoring | Yes (TLS 1.3) | Diagnostic only |
| **Device / Other IDs** | Yes | Yes (AdMob) | Advertising & fraud prevention (Free tier) | Yes (TLS 1.3) | Reset via Android Settings |

---

## 🎯 Section 6: Official URLs for Play Console

- **Privacy Policy URL:** `https://github.com/Dreke20/TarotApp/blob/main/PRIVACY_POLICY.md`  
  *(Raw alternative: `https://raw.githubusercontent.com/Dreke20/TarotApp/main/PRIVACY_POLICY.md`)*
- **Account & Data Deletion URL:** `https://github.com/Dreke20/TarotApp/blob/main/ACCOUNT_DELETION.md`  
  *(Raw alternative: `https://raw.githubusercontent.com/Dreke20/TarotApp/main/ACCOUNT_DELETION.md`)*
- **Support / Privacy Email:** `privacy@oraculumtarot.com` / `dreke.dev@gmail.com`
- **Developer Website / Repository:** `https://github.com/Dreke20/TarotApp`
