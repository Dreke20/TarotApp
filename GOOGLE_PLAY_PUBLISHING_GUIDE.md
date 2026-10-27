# 🚀 Complete Google Play Store Publishing Guide
## Oraculum: Sacred AI Tarot (`oraculum.dirtysouth`)

This is the definitive, step-by-step master manual for taking **Oraculum** from your local machine to live publication on the **Google Play Store**. All technical preparation, code signing, security hardening, and compliance documentation have already been completed for you.

---

## 📑 Table of Contents
1. [Pre-Flight Readiness Checklist](#-1-pre-flight-readiness-checklist)
2. [Step 1: Create the App in Google Play Console](#-step-1-create-the-app-in-google-play-console)
3. [Step 2: Set Up Main Store Listing](#-step-2-set-up-main-store-listing)
4. [Step 3: Complete Mandatory Policy & Content Declarations](#-step-3-complete-mandatory-policy--content-declarations)
5. [Step 4: Set Up In-App Products & Subscriptions](#-step-4-set-up-in-app-products--subscriptions)
6. [Step 5: Create a Release & Upload Your App Bundle](#-step-5-create-a-release--upload-your-app-bundle)
7. [Step 6: Internal Testing & Personal Account Verification](#-step-6-internal-testing--personal-account-verification)
8. [Step 7: Production Submission & Review Timeline](#-step-7-production-submission--review-timeline)

---

## 🛩️ 1. Pre-Flight Readiness Checklist

Everything you need is already generated, signed, and validated in your repository:

| Asset / Deliverable | Status | File Location |
| :--- | :---: | :--- |
| **Compiled Production AAB** | ✅ Ready | [`build/app/outputs/bundle/release/app-release.aab`](build/app/outputs/bundle/release/app-release.aab) (95.7 MB) |
| **Android Keystore & Signing** | ✅ Signed | [`android/oraculum-release-key.jks`](android/oraculum-release-key.jks) & [`android/key.properties`](android/key.properties) |
| **Code Quality & Lints** | ✅ 0 Issues | `flutter analyze` passed with 0 errors/warnings |
| **Unit & Security Tests** | ✅ 231 Passed | `flutter test` passed 231/231 tests |
| **Privacy Policy** | ✅ Live & Compliant | [`PRIVACY_POLICY.md`](PRIVACY_POLICY.md) |
| **Terms of Service** | ✅ Live & Compliant | [`TERMS_OF_SERVICE.md`](TERMS_OF_SERVICE.md) |
| **Account Deletion Portal** | ✅ Live & Compliant | [`ACCOUNT_DELETION.md`](ACCOUNT_DELETION.md) |
| **Character-Counted Store Copy** | ✅ Ready | [`STORE_LISTING.md`](STORE_LISTING.md) |

---

## 📱 Step 1: Create the App in Google Play Console

1. Open your browser and navigate to the **[Google Play Console](https://play.google.com/console)**.
2. Sign in with your registered Google Developer Account.
3. On the **All apps** dashboard, click the blue **"Create app"** button in the top-right corner.
4. Fill in the initial app parameters:
   - **App name:** `Oraculum: Sacred AI Tarot` (24 / 30 chars)
   - **Default language:** `English (United States) – en-US`
   - **App or game:** Select **App**
   - **Free or paid:** Select **Free** *(in-app purchases and subscriptions are handled inside the app)*
5. **Declarations:**
   - Check ☑️ *"I confirm that my app meets the Developer Program Policies."*
   - Check ☑️ *"I accept and certify compliance with US export laws."*
6. Click **Create app** at the bottom-right. You will be redirected to the app's Dashboard.

---

## 🎨 Step 2: Set Up Main Store Listing

In the left-hand navigation menu, scroll down to **Grow** and click **Store presence > Main store listing**.

### 1. Listing Details (Copy from [`STORE_LISTING.md`](STORE_LISTING.md))
- **App name:** `Oraculum: Sacred AI Tarot`
- **Short description (75 / 80 chars):**
  ```text
  Channeled AI Tarot readings, natal chart ephemeris & daily astral guidance.
  ```
- **Full description:**
  Copy and paste the entire text block from Section 2 of [`STORE_LISTING.md`](STORE_LISTING.md).

### 2. Graphics Assets
- **App icon:** Upload a **512 x 512 px** 32-bit PNG of the celestial all-seeing eye logo.
- **Feature graphic:** Upload a **1024 x 500 px** JPG or PNG featuring the obsidian-and-gold tarot aesthetic with the tagline *"Channeled AI Tarot & Astral Guidance"*.
- **Phone screenshots:** Upload at least 4 screenshots (aspect ratio 9:16, e.g. 1080 x 2400 px):
  1. *Altar Sanctum & 78-Card Obsidian Ribbon*
  2. *Channeled AI Prophecy with 60-Second Micro-Ritual*
  3. *Dual-Seeker Cosmic Synastry Mirror*
  4. *Complete Natal Ephemeris & Birth Chart*
  5. *Elder Futhark Runes & Solfeggio Audio Resonator*
- **Tablet screenshots (Optional):** Upload screenshots for 7-inch and 10-inch tablets if desired.

### 3. Store Categorization & Contact Details
- In the left menu, click **Store presence > Store settings**:
  - **App category:** `Lifestyle`
  - **Tags:** Click *Manage tags*, search and select: `Astrology`, `Lifestyle`, `Meditation`, `Entertainment`.
  - **Store listing contact details:**
    - **Email address:** `privacy@oraculumtarot.com` (or your personal developer email `dreke.dev@gmail.com`)
    - **Website URL:** `https://github.com/Dreke20/TarotApp`

Click **Save** at the bottom right.

---

## 🛡️ Step 3: Complete Mandatory Policy & Content Declarations

Google Play requires completion of all policy questionnaires before you can submit a release. In the left navigation, scroll to the bottom under **Policy and programs** and select **App content**.

Complete each declaration as follows:

### 1. Privacy Policy
- Click **Start / Manage**.
- Enter your Privacy Policy URL:
  - **Netlify Live Website (Recommended):** `https://<your-site-name>.netlify.app/privacy`
  - *(Alternative GitHub Fallback: `https://raw.githubusercontent.com/Dreke20/TarotApp/main/PRIVACY_POLICY.md`)*
- Click **Save**.

### 2. Ads Declaration
- Click **Start**.
- Does your app contain ads? 👉 Select **"Yes, my app contains ads"** *(Because free seekers can watch optional AdMob rewarded video passes)*.
- Click **Save**.

### 3. App Access (Reviewer Instructions)
- Click **Start**.
- Select: **"All functionality is available without special access"** *(Guest mode allows immediate access to all core divination rituals without an account)*.
- *Optional review note:* If you want to give the reviewer instant Oracle Pro testing privileges without billing:
  > *"Reviewers can test Oracle Pro features by tapping the top crown icon, selecting Enter Promo Code, and entering: CELESTIAL_PRO."*
- Click **Save**.

### 4. Content Ratings (IARC Questionnaire)
- Click **Start questionnaire**.
- Enter your email address.
- Select category: **"Consumer / Utility / Productivity / Lifestyle / Entertainment"**.
- Answer the questionnaire:
  - Violence: **No**
  - Sexual content: **No**
  - Profanity: **No**
  - Controlled substances: **No**
  - Physical interaction / location sharing: **No**
  - Users exchange text messages publicly: **No**
  - Unrestricted internet access (web browser): **No**
- Click **Save**, then click **Next**, then **Submit**.  
- *Result:* The app will receive an **Everyone (PEGI 3 / USK 0 / IARC Teen)** rating.

### 5. Target Audience and Content
- Click **Start**.
- Target age group: Select ☑️ **13–15**, ☑️ **16–17**, ☑️ **18 and over**.  
  *(⚠️ Do NOT select under 13; Oraculum is not intended for young children and avoids the complex Google Families policy restrictions).*
- Appeal to children: Select **"No"**.
- Click **Save**.

### 6. News Apps
- Click **Start**.
- Is your app a news app? 👉 Select **"No"**.
- Click **Save**.

### 7. COVID-19 Contact Tracing & Status Apps
- Click **Start**.
- Select **"My app is not a COVID-19 contact tracing or status app"**.
- Click **Save**.

### 8. Data Safety Form (Critical)
- Click **Start**.
- Complete the answers according to the table below:

| Question | Answer |
| :--- | :--- |
| Does your app collect or share any user data? | **Yes** |
| Is all user data collected encrypted in transit? | **Yes** (TLS 1.3 / HTTPS enforced) |
| Do you provide a way for users to request that their data is deleted? | **Yes** (In-app Profile deletion & web deletion URL) |
| **Data types collected:** | |
| • *Personal info > Email address* | **Collected (Optional)**, Not shared, App functionality / Account management |
| • *Personal info > Name / User Moniker* | **Collected (Optional)**, Not shared, Personalization & natal chart |
| • *Photos and videos > Photos* | **Collected (Optional)**, Not shared, App functionality (Tarot Lens card scanning processed ephemerally by Google Gemini, not stored) |
| • *Device or other IDs > Device or other IDs* | **Collected & Shared (Google AdMob)**, Advertising & Analytics |
| *Financial information* | **No** (Handled 100% by Google Play Billing) |
| *Health and fitness* | **No** |
| *Location* | **No** |
| *Audio* | **No** (Microphone transcription is processed ephemerally, not stored) |

- Enter Account Deletion URL:
  - **Netlify Live Website (Recommended):** `https://<your-site-name>.netlify.app/delete-account`
  - *(Alternative GitHub Fallback: `https://github.com/Dreke20/TarotApp/blob/main/ACCOUNT_DELETION.md`)*
- Click **Submit**.

### 9. Government Apps
- Select **"No"**.

### 10. Financial Features
- Select **"My app doesn't provide any financial features"**.

### 11. Generative AI Apps
- Is your app a Generative AI app? 👉 Select **"Yes"**.
- Confirm that the app implements prompt safeguards and user reporting:
  - Check ☑️ *"My app allows users to report or flag offensive AI-generated content"* *(Implemented via the Report button in [`reading_result_sheet.dart`](lib/features/tarot/presentation/widgets/reading_result_sheet.dart))*.
  - Check ☑️ *"My app prevents generation of prohibited content"*.
- Click **Save**.

### 12. Health Apps
- Select **"My app does not provide any health or medical features"**.

---

## 💎 Step 4: Set Up In-App Products & Subscriptions

In the left navigation menu under **Monetize with Play**, expand **Products**:

### 1. Subscriptions
Click **Subscriptions > Create subscription**:
- **Subscription 1: Annual Sanctuary (Featured Best Value)**
  - **Product ID:** `oracle_pro_yearly`
  - **Name:** `Oracle Pro Yearly`
  - **Base plan:** Set billing period to **Yearly**, price to **`$29.99/year`** (equivalent to `$2.50/mo`, Save 50%), and add a **3-day free trial**.
- **Subscription 2: Monthly Sanctuary**
  - **Product ID:** `oracle_pro_monthly`
  - **Name:** `Oracle Pro Monthly`
  - **Base plan:** Set billing period to **Monthly**, price to **`$4.99/month`**.

### 2. In-App Products (Lifetime Pass & Starlight Shards)
Click **In-app products > Create product**:

#### A. Non-Consumable Lifetime Access
- **Product ID:** `oracle_pro_lifetime`
  - **Name:** `Oracle Pro Lifetime Pass`
  - **Description:** Permanent unlimited access to all Oracle Pro divination spreads, voice narration, and sacred tools without recurring charges.
  - **Price:** **`$69.99`**
  - **Status:** Active.

#### B. Consumable Starlight Shard Bundles (A-la-carte for Non-Subscribers)
- **Product ID:** `starlight_shards_small`
  - **Name:** `10 Starlight Shards (Novice Pouch)`
  - **Price:** **`$1.99`**
- **Product ID:** `starlight_shards_medium`
  - **Name:** `30 Starlight Shards (Adept Chest)`
  - **Price:** **`$4.99`** *(+25% bonus value)*
- **Product ID:** `starlight_shards_large`
  - **Name:** `75 Starlight Shards (Hierophant Vault)`
  - **Price:** **`$9.99`** *(+60% bonus value)*
- **Product ID:** `starlight_shards_treasury`
  - **Name:** `175 Starlight Shards (Sovereign Treasury)`
  - **Price:** **`$19.99`** *(+100% mega bonus value)*

---

## 📦 Step 5: Create a Release & Upload Your App Bundle

### 1. Accept Play App Signing
1. In the left menu, navigate to **Release > Setup > App integrity**.
2. Click **"Use Google-generated key"** and accept the Play App Signing Terms of Service.

### 2. Upload the Production AAB
1. In the left menu, click **Release > Testing > Internal testing** (or **Production**).
2. Click the blue **"Create new release"** button.
3. In the **App bundles** drop zone:
   - Click **Upload** and select:
     `c:\Users\dreke\OneDrive\Desktop\TarotApp\build\app\outputs\bundle\release\app-release.aab`
   - Wait for Google Play to inspect and upload the bundle. It will verify the package name (`oraculum.dirtysouth`), version code (`1`), and target SDK (`35`+).
4. **Release name:** Set to `1.0.0 (1)`.
5. **Release notes:** Paste:
   ```text
   Initial release of Oraculum: Sacred AI Tarot.
   • Channeled divination powered by Google Gemini 2.5
   • 78 bespoke illustrated gothic tarot cards with 3D foil tilt
   • Complete natal chart ephemeris & dual-seeker synastry mirror
   • Multi-tradition Elder Futhark runes, I Ching, and sacred Solfeggio soundscapes
   ```
6. Click **Next** at the bottom right.
7. Resolve any remaining warnings (if any), then click **Save**.

---

## 👥 Step 6: Internal Testing & Personal Account Verification

### Why Start with Internal Testing?
- **Zero Review Delay:** Internal testing releases are available to you and your testers **within minutes**, without waiting for Google human review.
- **Testing In-App Purchases:** You can test purchases without real money using Google Play License Testing.

### Steps to Run Internal Testing:
1. In Google Play Console, go to **Release > Testing > Internal testing**.
2. Click the **Testers** tab.
3. Click **Create email list**, name it `Oraculum Inner Circle`, and enter your personal Google email address (`dreke.dev@gmail.com`).
4. Under **How testers join your test**, copy the **"Join on Android"** link or **"Join on the web"** link.
5. Open that link on your Android phone, tap **"Become a tester"**, and download the app directly through the Google Play Store!

---

## 🏁 Step 7: Production Submission & Review Timeline

### A. For Personal Developer Accounts Created After Nov 13, 2023:
Google mandates **20 testers opted-in for at least 14 days** before you can apply for Production access:
1. Promote your internal release to **Closed testing (Alpha/Beta)**.
2. Invite 20 friends, beta testers, or community members to your closed testing track.
3. Once 20 testers have had the app installed for 14 continuous days, a button will appear on your Dashboard: **"Apply for production"**.
4. Answer Google's simple questionnaire regarding feedback received and app stability.
5. Google will approve production access within 48–72 hours.

### B. For Established / Organization Developer Accounts:
1. Go directly to **Release > Production**.
2. Click **Create new release**, select your uploaded App Bundle, and click **Review release**.
3. Click **"Start rollout to Production"**.
4. Google will review the app (typically **24 to 72 hours**).
5. Once approved, **Oraculum: Sacred AI Tarot** will be live globally on Google Play!

---

## 🌟 Support & Developer Troubleshooting
If Google Play reviewers request any additional clarifications during the review:
- **Review Access Promo Code:** `CELESTIAL_PRO` grants instant 1-year Pro testing.
- **Support Email:** `privacy@oraculumtarot.com` / `dreke.dev@gmail.com`
- **Source Code Repository:** `https://github.com/Dreke20/TarotApp`
