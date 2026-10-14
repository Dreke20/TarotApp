import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client.g.dart';

/// Provides access to the initialized Supabase client instance.
/// Returns `null` when Supabase has not been initialized (offline/demo mode).
@Riverpod(keepAlive: true)
SupabaseClient? supabaseClient(Ref ref) {
  try {
    return Supabase.instance.client;
  } catch (_) {
    return null;
  }
}
