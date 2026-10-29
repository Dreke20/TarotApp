/// Row written to public.ai_reports. Clients insert only; they cannot read.
class AiReportDraft {
  static const int maxReasonLength = 200;
  static const int maxExcerptLength = 500;

  static Map<String, dynamic> row({
    required String userId,
    required String reason,
    String? readingId,
    String? excerpt,
  }) {
    final cleanUser = userId.trim();
    final cleanReason = reason.trim();
    if (cleanUser.isEmpty) {
      throw ArgumentError('A signed-in user is required to report AI output.');
    }
    if (cleanReason.isEmpty || cleanReason.length > maxReasonLength) {
      throw ArgumentError('Report reason must be 1–$maxReasonLength characters.');
    }
    final cleanExcerpt = excerpt?.trim();
    return {
      'user_id': cleanUser,
      'reason': cleanReason,
      'reading_id': (readingId == null || readingId.trim().isEmpty) ? null : readingId.trim(),
      'excerpt': (cleanExcerpt == null || cleanExcerpt.isEmpty)
          ? null
          : cleanExcerpt.length <= maxExcerptLength
              ? cleanExcerpt
              : cleanExcerpt.substring(0, maxExcerptLength),
    };
  }
}
