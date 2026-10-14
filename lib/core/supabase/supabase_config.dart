/// Supabase configuration constants.
/// In production, these should be supplied via compile-time variables:
/// --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ryxzludoiffboqwkhqqb.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ5eHpsdWRvaWZmYm9xd2tocXFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTE5MjgyNTEsImV4cCI6MjEwNzUwNDI1MX0.A-3Tf8WBZ3S8aIe0LT7MF0VaMFbvHKbExSIJoZCrxZU',
  );

  /// Helper to check if credentials have been replaced with real ones
  static bool get isConfigured =>
      !url.contains('placeholder') && !anonKey.contains('placeholder');
}
