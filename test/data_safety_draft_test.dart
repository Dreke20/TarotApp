import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the Play Data safety draft covers account, Gemini, voice, crashes, reports, and deletion', () {
    final text = File('docs/DATA_SAFETY_DRAFT.md').readAsStringSync();
    expect(text, contains('email'));
    expect(text, contains('Gemini'));
    expect(text, contains('on-device'));
    expect(text, contains('Crashlytics'));
    expect(text, contains('ai_reports'));
    expect(text, contains('delete-account'));
    expect(text, contains('1.5 MB'));
    expect(text, isNot(contains('PRIVACY_POLICY.md was updated')));
  });
}
