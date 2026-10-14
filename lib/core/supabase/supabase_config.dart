/// Supabase configuration constants.
/// In production, these should be supplied via compile-time variables:
/// --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://placeholder-project.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.placeholder-key',
  );

  /// Helper to check if credentials have been replaced with real ones
  static bool get isConfigured =>
      !url.contains('placeholder') && !anonKey.contains('placeholder');
}
