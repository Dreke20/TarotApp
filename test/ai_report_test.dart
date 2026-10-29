import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/tarot/data/ai_report.dart';

void main() {
  test('a report row is an insert of the caller’s own reason and a short excerpt', () {
    final row = AiReportDraft.row(
      userId: 'user-1',
      reason: '  Offensive or discriminatory phrasing  ',
      readingId: 'reading-9',
      excerpt: 'x' * 800,
    );
    expect(row['user_id'], 'user-1');
    expect(row['reason'], 'Offensive or discriminatory phrasing');
    expect(row['reading_id'], 'reading-9');
    expect((row['excerpt'] as String).length, AiReportDraft.maxExcerptLength);
    expect(row.containsKey('id'), isFalse);
  });

  test('ai_reports lets the owner insert and gives clients no readable policy', () {
    final sql = File('supabase/migrations/20261029150000_ai_reports.sql').readAsStringSync();
    expect(sql, contains('ENABLE ROW LEVEL SECURITY'));
    expect(sql, contains('FOR INSERT'));
    expect(sql, contains('auth.uid()'));
    expect(sql, contains('submit_ai_report'));
    expect(sql, contains('SET search_path = \'\''));
    expect(sql.contains('FOR SELECT'), isFalse);
    expect(sql, contains('GRANT INSERT ON TABLE public.ai_reports TO authenticated'));
    expect(sql.contains('GRANT SELECT ON TABLE public.ai_reports TO authenticated'), isFalse);
  });
}
