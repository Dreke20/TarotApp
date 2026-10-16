/// High-security input sanitizer and AI prompt injection guardrail.
/// Protects the Supabase Edge Functions and Gemini inference pipes
/// against prompt leakage, delimiter injection, and malicious payloads.
class PromptSanitizerService {
  PromptSanitizerService._();

  static const int maxQuestionLength = 280;
  static const int maxFollowUpLength = 400;

  // Patterns attempting to hijack LLM behavior or extract system instructions
  static final List<RegExp> _injectionPatterns = [
    RegExp(r'ignore\s+(all\s+)?previous\s+instructions', caseSensitive: false),
    RegExp(r'system\s+prompt', caseSensitive: false),
    RegExp(r'disregard\s+(all\s+)?prior', caseSensitive: false),
    RegExp(r'you\s+are\s+now\s+(an?\s+)?unrestricted', caseSensitive: false),
    RegExp(r'jailbreak', caseSensitive: false),
    RegExp(r'repeat\s+(everything\s+)?above', caseSensitive: false),
    RegExp(r'reveal\s+(your\s+)?instructions', caseSensitive: false),
    RegExp(r'output\s+initialization', caseSensitive: false),
    RegExp(r'dan\s+mode', caseSensitive: false),
  ];

  // Dangerous script, html, or delimiter tags
  static final RegExp _tagRegex = RegExp(r'<[^>]*>', multiLine: true);
  static final RegExp _controlCharRegex = RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\u200E\u200F\u202A-\u202E]');
  static final RegExp _delimiterRegex = RegExp(r'(`{3,}|-{3,}|={3,})');

  /// Sanitizes a seeker question before passing to the Oracle.
  /// Returns a clean, injection-safe string truncated to safe bounds.
  static String sanitizeQuestion(String input) {
    return _sanitize(input, maxQuestionLength);
  }

  /// Sanitizes multi-turn follow-up queries.
  static String sanitizeFollowUp(String input) {
    return _sanitize(input, maxFollowUpLength);
  }

  /// Evaluates whether the input contains hostile adversarial injection attempts
  static bool containsInjectionAttempt(String input) {
    for (final pattern in _injectionPatterns) {
      if (pattern.hasMatch(input)) return true;
    }
    return false;
  }

  static String _sanitize(String raw, int maxLength) {
    if (raw.isEmpty) return '';

    // 1. Strip null bytes and bidirectional override characters
    var clean = raw.replaceAll(_controlCharRegex, '');

    // 2. Strip raw HTML/script tags
    clean = clean.replaceAll(_tagRegex, '');

    // 3. Defang markdown delimiters that could alter prompt framing
    clean = clean.replaceAll(_delimiterRegex, ' ');

    // 4. Neutralize known jailbreak vectors by replacing with neutral esoteric phrasing
    for (final pattern in _injectionPatterns) {
      clean = clean.replaceAll(pattern, '[neutralized inquiry]');
    }

    // 5. Normalize whitespace
    clean = clean.replaceAll(RegExp(r'\s+'), ' ').trim();

    // 6. Enforce hard boundary cap with clean truncation within maxLength
    if (clean.length > maxLength) {
      final cutOff = maxLength > 3 ? maxLength - 3 : maxLength;
      clean = '${clean.substring(0, cutOff).trim()}...';
    }

    return clean;
  }
}
