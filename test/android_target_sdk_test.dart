import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('targetSdk is set to 36 explicitly', () {
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();
    expect(gradle, contains('targetSdk = 36'));
    expect(gradle.contains('targetSdk = flutter.targetSdkVersion'), isFalse);
  });
}
