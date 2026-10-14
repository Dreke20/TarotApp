# 🔮 Oraculum • AI Tarot Reader

A production-ready, mystical AI Tarot Reading mobile application built with Flutter, Riverpod, Supabase, and Vertex AI (Gemini Flash). Features a Glassmorphic aesthetic, 3D perspective card animations, and a full 78-card Tarot engine.

---

## 🌟 Key Features

1. **The Tarot Engine (Client-Side Domain)**
   - Complete standard **78-Card Deck** (22 Major Arcana + 56 Minor Arcana across Wands, Cups, Swords, and Pentacles).
   - Authentic **Fisher-Yates Shuffle Algorithm** with realistic card reversal probability.
   - Built-in Spreads:
     - **Daily Guidance** (1 Card)
     - **The Three Fates** (3 Cards: *The Past / Roots*, *The Present / Crossroads*, *The Future / Trajectory*).
   - Asset mapping strategy (`cardAssets`) linking card identifiers to local assets with fallback custom celestial painters.

2. **The AI Oracle (Supabase Edge Function)**
   - Edge Function `tarot-reader` written in TypeScript for Deno.
   - Integrates with **Vertex AI / Gemini API** (`gemini-1.5-flash`).
   - Empathetic mystical prompt synthesizing position relationships, elemental alchemy, and actionable spiritual counsel.
   - Structured JSON response parsing and offline oracle fallback.

3. **Immersive Glassmorphic UI/UX**
   - Deep midnight violet backdrop (`#070414`, `#0D0826`, `#160D3D`) with dynamic ambient nebulae.
   - Glassmorphic panels with `BackdropFilter` gaussian blur, luminous borders, and golden accents.
   - High-fidelity **3D Card Flip Animation** using Matrix4 perspective transforms and `flutter_animate`.
   - Layered 3D deck stack on the altar table with tactile shuffle vibration.

4. **Persistence & Sacred Journal**
   - Automatically records readings to Supabase PostgreSQL `public.readings` table with Row Level Security (RLS).
   - History viewer allowing seekers to review their past spreads, questions, and oracle prophecies.

---

## 🏗️ Architecture & Project Structure

```
TarotApp/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart         # Mystic Glassmorphic color palette
│   │   │   ├── app_strings.dart        # Sacred strings & prompt presets
│   │   │   └── app_theme.dart          # Typography (Cinzel & Plus Jakarta Sans)
│   │   ├── supabase/
│   │   │   ├── supabase_client.dart    # Riverpod provider for SupabaseClient
│   │   │   └── supabase_config.dart    # Env / runtime config
│   │   └── utils/
│   ├── features/
│   │   ├── auth/
│   │   │   └── domain/
│   │   │       └── user_profile.dart   # Freezed UserProfile model
│   │   └── tarot/
│   │       ├── data/
│   │       │   ├── tarot_card_data.dart   # Full 78-card Tarot dataset
│   │       │   ├── tarot_deck_service.dart# Fisher-Yates shuffle & spread logic
│   │       │   └── tarot_repository.dart  # Supabase Edge Function & DB caller
│   │       ├── domain/
│   │       │   ├── spread_type.dart       # Daily Guidance & Three Fates
│   │       │   ├── tarot_card.dart        # Freezed TarotCard model
│   │       │   └── reading.dart           # Freezed Reading model
│   │       └── presentation/
│   │           ├── notifiers/
│   │           │   ├── reading_notifier.dart # Riverpod Generator notifier
│   │           │   └── reading_state.dart    # Immutable reading state
│   │           ├── screens/
│   │           │   ├── tarot_table_screen.dart    # The Altar Table
│   │           │   └── readings_history_screen.dart # Sacred Journal history
│   │           └── widgets/
│   │               ├── deck_pile_widget.dart      # 3D interactive stacked deck
│   │               ├── glass_container.dart       # BackdropFilter glass container
│   │               ├── mystic_background.dart     # Ambient pulsing nebulae
│   │               ├── reading_result_sheet.dart  # Prophecy result modal
│   │               ├── spread_selector.dart       # Spread toggle
│   │               └── tarot_card_widget.dart     # 3D flip card widget
│   └── main.dart
│
├── supabase/
│   ├── config.toml
│   ├── migrations/
│   │   └── 20261013000000_create_tarot_tables.sql # Schema & RLS policies
│   └── functions/
│       └── tarot-reader/
│           └── index.ts                           # Vertex AI / Gemini Edge Function
└── test/
    └── widget_test.dart                           # Unit & Smoke tests
```

---

## 🚀 Getting Started

### 1. Run the Flutter App
```bash
flutter run
```

### 2. Configure Remote Supabase & Gemini (Production)
Run with `--dart-define` flags or set environment variables:
```bash
flutter run --dart-define=SUPABASE_URL=https://your-project.supabase.co --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

### 3. Deploy Supabase Database Schema
Run the SQL migration in [20261013000000_create_tarot_tables.sql](file:///c:/Users/dreke/OneDrive/Desktop/TarotApp/supabase/migrations/20261013000000_create_tarot_tables.sql) inside the Supabase SQL Editor, or use the Supabase CLI:
```bash
supabase db push
```

### 4. Deploy the Edge Function
Deploy the `tarot-reader` function to your Supabase project:
```bash
supabase functions deploy tarot-reader --no-verify-jwt
supabase secrets set GEMINI_API_KEY="your-gemini-api-key"
```
