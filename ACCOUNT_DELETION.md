# Account & Data Deletion Policy for Oraculum: Sacred AI Tarot

**Application Name:** Oraculum: Sacred AI Tarot  
**Application ID:** `com.tarotapp.tarot_app`  
**Developer:** Rodriguez Edwards (Dreke20)  
**Effective Date:** October 16, 2026  
**Last Updated:** October 16, 2026  

---

## 🛡️ Commitment to Seeker Privacy
At **Oraculum**, we respect your spiritual autonomy and privacy rights. In full compliance with **Google Play Store Data Safety & Account Deletion Policies**, you have complete control over your personal account, birth charts, tarot reading history, and stored preferences.

You can delete your account and all associated data at any time either:
1. **Directly within the Oraculum mobile application** (Instant & Automatic).
2. **Via this web request page / email** (Without needing to install or open the app).

---

## 📱 Method 1: In-App Account & Data Deletion (Instant)
You can permanently erase your account and all stored records directly on your device:

1. Open the **Oraculum** app on your Android device.
2. Tap the **Seeker Profile Icon** (Zodiac circle avatar) in the upper-left corner of the main altar screen.
3. Scroll to the bottom of the profile dialog and tap the crimson **`DELETE ACCOUNT & DATA`** button.
4. An alert titled **"PURGE ACCOUNT & DATA"** will appear detailing the irreversible nature of this action.
5. Tap **`DELETE EVERYTHING`**.

### What happens immediately:
- Your user session is terminated and deleted from our authentication servers.
- All remote profile records in Supabase (including email, display name, and natal ephemeris) are permanently removed.
- All personal tarot spreads, journal entries, and query logs are deleted.
- Local secure vault keys and cached app preferences are cleared from your device storage.

---

## 🌐 Method 2: Web & Email Deletion Request (Without the App)
If you have uninstalled the application or cannot access your device, you can submit a deletion request online:

### How to Request Deletion:
Send an email to our dedicated data privacy desk:
- **Email:** `privacy@oraculumtarot.com` or `dreke.dev@gmail.com`
- **Subject:** `Data & Account Deletion Request - Oraculum`
- **Required Information:**
  - The email address associated with your Oraculum account.
  - (Optional) Your registered seeker display name.

### Request Timeline & SLA:
- Requests are acknowledged within **48 business hours**.
- Permanent deletion across all production servers, database records, and automated backups is completed within **30 calendar days**.
- You will receive a final confirmation email once all records have been expunged.

---

## 📋 Data Retention and Deletion Matrix

| Data Category | What Is Collected | What Happens Upon Deletion | Retention Period |
| :--- | :--- | :--- | :--- |
| **Account Credentials** | Email address, password hash, user ID | **Permanently Erased** from Supabase Auth | 0 days (Immediate) |
| **Seeker Identity** | Display name, avatar initials | **Permanently Erased** | 0 days (Immediate) |
| **Astrological Placements** | Sun, Moon, and Rising sign selections | **Permanently Erased** | 0 days (Immediate) |
| **Tarot Invocations & Readings** | Questions asked, cards drawn, AI interpretations, personal reflections | **Permanently Erased** from database | 0 days (Immediate) |
| **Guest Sessions (Anonymous)** | Stored locally in device private SQLite/Prefs | **Erased on App Uninstall / Clear Data** | None stored on remote servers |
| **Financial / Billing Data** | Google Play subscription tokens | Handled directly by Google Play Billing; Oraculum does not store credit card or banking numbers | Governed by Google Play |
| **Diagnostic & Crash Logs** | Anonymized device logs | Anonymized crash logs without user identifiers are rotated automatically | Up to 90 days |

---

## ⚖️ Legal & Regulatory Compliance
This deletion policy adheres to:
- **Google Play User Data & Account Deletion Policy (2024–2026 Standards)**
- **General Data Protection Regulation (GDPR Article 17 - Right to Erasure)**
- **California Consumer Privacy Act (CCPA - Right to Delete Personal Information)**

---

## 📬 Contact the Data Protection Officer
For any questions regarding your data privacy, account deletion, or personal information:
- **Developer / Publisher:** Rodriguez Edwards
- **GitHub Repository:** [https://github.com/Dreke20/TarotApp](https://github.com/Dreke20/TarotApp)
- **Data Protection Email:** `privacy@oraculumtarot.com` / `dreke.dev@gmail.com`
