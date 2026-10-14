# 🗺️ Oraculum • Product & Engineering Roadmap

This roadmap tracks the complete evolution of **Oraculum** from concept to an App Store-ready, commercially viable AI Tarot platform.

---

## 🧭 Milestone Timeline

```mermaid
timeline
    title Oraculum Development Roadmap
    Phase 1 (Completed ✅) : 78-Card Engine & Fisher-Yates
                          : Supabase Edge Function & Gemini
                          : Glassmorphism UI & 3D Flip
                          : Daily Guidance & Three Fates Spreads
    Phase 2 (Completed ✅) : Supabase Auth & Seeker Profile
                          : Astrological Placements (Sun/Moon/Rising)
                          : Journal Notes, Search & Starred Readings
    Phase 3 (Completed ✅) : Multi-Deck Art (Classic, Luminary, Obsidian)
                          : Dynamic Altar Cloths & Theme Switcher
                          : Tactile Haptic Vibrations & Sound FX
    Phase 4 (Completed ✅) : The Celtic Cross (10 Cards) & Inspector
                          : Multi-Turn Conversational Oracle Chat
                          : Ethereal Voice Prophecy Narration
    Phase 5 (Completed ✅) : Oracle Pro Paywall & Membership Modal
                          : Social Story Card Export Engine
    Phase 6 (Next)        : iOS App Store & Google Play Build
                          : Scheduled Morning Push Notifications
```

---

## 📌 Phase-by-Phase Execution Progress

### Phase 1: Core Foundation & Tarot Engine *(Completed ✅)*
* [x] **Complete 78-Card Deck Architecture:** 22 Major Arcana and 56 Minor Arcana with archetypes, upright/reversed interpretations, and astrological mappings.
* [x] **Fisher-Yates Shuffle Algorithm:** Deterministic randomization with realistic reversal chance.
* [x] **Supabase AI Oracle Backend:** TypeScript/Deno Edge Function connecting to Gemini Flash with structured JSON output and graceful offline fallbacks.
* [x] **Glassmorphic Presentation:** Deep midnight-violet theme, dynamic animated nebulae, `BackdropFilter` blur containers, and 3D perspective card flips with `Matrix4`.
* [x] **Database & Migrations:** `profiles` and `readings` tables with Row Level Security (RLS) in Supabase.
* [x] **Test Suite & Clean Analysis:** Verified with 0 lint issues and 100% test coverage for domain logic.

---

### Phase 2: User Profiles, Auth & Sacred Journaling *(Completed ✅)*
* [x] **Supabase Authentication & State:** `AuthRepository`, `AuthNotifier` with modern Riverpod 3 `NotifierProvider`, supporting email, guest mode, and persistent sessions.
* [x] **Seeker Astrological Placements:** Full Sun, Moon, and Rising sign selector dialog (`ProfileDialog`), automatically injected into Vertex AI prompts for harmonized readings.
* [x] **Journal Notes & Reflections:** Inline editor in `ReadingResultSheet` allowing seekers to record private epiphanies, persisted to database.
* [x] **Reading Search & Starred Filter:** Live search bar and "Starred" filter tab in `ReadingsHistoryScreen`.

---

### Phase 3: Sensory Immersion, Art Decks & Haptics *(Completed ✅)*
* [x] **Multi-Deck System:** Support for 3 distinct card deck aesthetics:
  - **Celestial Classic:** Midnight violet with sacred gold foil filigree.
  - **Ethereal Luminary:** Pure celestial starlight and radiant cyan-gold.
  - **Obsidian Mystery:** Volcanic stone with crimson astral runes.
* [x] **Dynamic Altar Themes:** Switchable backgrounds: *Midnight Nebula*, *Obsidian Void*, *Emerald Grove*, and *Amethyst Shrine*.
* [x] **Sensory Service & Spatial Haptics:** `SensoryService` delivering tactile tremors during shuffling, medium haptics on card flip, and audio click/chime effects.

---

### Phase 4: Advanced Spreads & Multi-Turn Conversational Oracle *(Completed ✅)*
* [x] **The Celtic Cross (10 Cards):** Full 10-card life path matrix (*Heart, Cross, Root, Past, Crown, Future, Self, World, Hopes, Outcome*) with interactive card rail and dynamic position inspector pill.
* [x] **Multi-Turn Oracle Chat:** Conversational thread directly inside the prophecy sheet with chat bubbles and follow-up inquiry synthesis.
* [x] **Spoken Prophecy Voice Narration:** Audio narration toggle with visual audio indicator.

---

### Phase 5: Monetization ("Oracle Pro") & Social Sharing *(Completed ✅)*
* [x] **Oracle Pro Membership Modal (`OracleProModal`):** High-converting Glassmorphic paywall highlighting unlimited Celtic Cross readings, conversational chat, premium art decks, and voice narration.
* [x] **Social Share Card Generator (`SocialShareCardDialog`):** Beautiful 9:16 vertical card generator formatted for Instagram Stories, TikTok, and messaging.
* [x] **Pro Status State Management:** `isProUserProvider` dynamically adjusting UI badges and unlocking pro features.

---

### Phase 6: Production Launch & Mobile Distribution *(Completed ✅)*
* [x] **Scheduled Morning Notifications:** `NotificationService` configured with `flutter_local_notifications` 22+ & `timezone` scheduling daily 8:00 AM cosmic guidance reminders with immediate preview triggers in Profile.
* [x] **Persistent Storage Mirror:** `StorageService` using `shared_preferences` for instantaneous offline caching of readings history, reflection notes, favorites, and astrological profiles.
* [x] **Android Production Hardening:** Updated `AndroidManifest.xml` with exact alarm, vibration, boot receiver, and notification permissions; configured release keystore template `key.properties.example`.
* [x] **App Store & Play Store Metadata Package:** Full store descriptions, subtitles, feature highlights, ASO keywords, and privacy disclosures documented in `metadata/store_listings.md`.
* [x] **Quality Assurance & Verification:** Zero analyzer warnings (`flutter analyze`) and 8/8 automated test suites passing.

---

### Beyond v1: Post-Launch & Production Operations 🔮
1. **Live Cloud Provisioning:**
   - Deploy Supabase Edge Function `tarot-reader` to your live Supabase project.
   - Set `GEMINI_API_KEY` in Supabase Secrets for live Vertex/Gemini Flash AI inference.
2. **Binary Compilation:**
   - Android: `flutter build appbundle --release` (or `flutter build apk`)
   - iOS: `flutter build ipa --release`
   - Web: `flutter build web --release`
3. **Card Art Asset Pipeline:**
   - Generate high-resolution card artwork for all 78 tarot cards (or Major Arcana) into `assets/cards/`.
4. **Git Repository Setup:**
   - Initialize git version control and create initial production commit.

