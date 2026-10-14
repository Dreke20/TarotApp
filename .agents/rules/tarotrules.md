---
trigger: always_on
---

# AI Tarot App Development Rules

## 1. Stack Constraints & Strict Preferences
- **Frontend:** Flutter & Dart 3.x. Use strict static typing (never use `dynamic` unless processing raw json serialization).
- **Backend Architecture:** Always route AI generation or third-party logic through **Supabase Edge Functions**. Never allow the Flutter mobile client to make direct raw API calls to external services.
- **State Management:** Flutter Riverpod using code generation annotations (`@riverpod`). Never write manual old-syntax change notifiers.
- **Data Entities:** Models must be immutable. Use `@freezed` and `@JsonSerializable`.

## 2. Coding Standards & Code Splitting
- **Feature-First Organization:** Keep code structured under explicit features: `features/auth/`, `features/tarot/`, `features/history/`.
- **Atomic Components:** Keep layout widgets small. Split huge screens into smaller modular layout sub-widgets.
- **Error Handling:** Every Supabase or edge invocation must be wrapped in a robust Dart `try-catch` block returning clean Union states (`AsyncValue`).

## 3. Security Rules
- **No API Keys in Dart:** Never hardcode Google AI Studio or Supabase secrets inside Dart code.
- **Row Level Security (RLS):** When generating database migration SQL, ensure all tables have RLS enabled and use `auth.uid()` checks.
