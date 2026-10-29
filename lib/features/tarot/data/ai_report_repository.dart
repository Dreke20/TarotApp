import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_report.dart';

/// Sends one AI-output report. The database function inserts the row; the
/// client has no way to read reports back.
class AiReportRepository {
  final SupabaseClient? client;

  const AiReportRepository(this.client);

  Future<void> submit({
    required String reason,
    String? readingId,
    String? excerpt,
  }) async {
    final supabase = client;
    final user = supabase?.auth.currentUser;
    if (supabase == null || user == null) {
      throw StateError('Sign in to report an AI reading.');
    }
    final row = AiReportDraft.row(
      userId: user.id,
      reason: reason,
      readingId: readingId,
      excerpt: excerpt,
    );
    await supabase.rpc('submit_ai_report', params: {
      'p_reason': row['reason'],
      'p_reading_id': row['reading_id'],
      'p_excerpt': row['excerpt'],
    });
  }
}
