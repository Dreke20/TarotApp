import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the Android release build does not fall back to the debug keystore', () {
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();
    expect(gradle.contains('signingConfigs.getByName("debug")'), isFalse);
    expect(gradle, contains('Refusing to sign with the debug key'));
    expect(gradle, contains('keystorePropertiesFile.exists()'));
    expect(gradle, contains('resolvedStore.exists()'));
    expect(
      gradle,
      contains('upload keystore named in android/key.properties'),
    );
  });
}
