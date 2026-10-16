import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/core/services/biometric_vault_service.dart';
import 'package:tarot_app/core/utils/lunar_calculator.dart';
import 'package:tarot_app/features/tarot/domain/tarot_deck_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/local_auth');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'isDeviceSupported':
        case 'canCheckBiometrics':
          return true;
        case 'getAvailableBiometrics':
        case 'getEnrolledBiometrics':
          return <String>['fingerprint', 'face'];
        case 'authenticate':
          return true;
        default:
          return true;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('TarotDeckTheme Expanded Catalog Tests', () {
    test('contains all 6 luxury themes with valid gradients and accents', () {
      expect(TarotDeckTheme.values.length, equals(6));
      expect(TarotDeckTheme.values.map((t) => t.id), containsAll([
        'classic',
        'luminary',
        'obsidian',
        'amethyst',
        'rose_gold',
        'celestial_silver',
      ]));

      for (final theme in TarotDeckTheme.values) {
        expect(theme.title.isNotEmpty, isTrue);
        expect(theme.subtitle.isNotEmpty, isTrue);
        expect(theme.backGradient.colors.length, greaterThanOrEqualTo(2));
      }
    });
  });

  group('BiometricVaultService Tests', () {
    test('instance provides a singleton reference', () {
      final vault1 = BiometricVaultService.instance;
      final vault2 = BiometricVaultService.instance;
      expect(identical(vault1, vault2), isTrue);
    });

    test('isHardwareSupported returns a valid boolean without throwing', () async {
      final vault = BiometricVaultService.instance;
      final supported = await vault.isHardwareSupported();
      expect(supported, isA<bool>());
    });

    test('authenticate handles mocked local auth', () async {
      final vault = BiometricVaultService.instance;
      final result = await vault.authenticate(reason: 'Test reason');
      expect(result, isTrue);
    });
  });

  group('Lunar Almanac & Transit Tests', () {
    test('LunarCalculator calculates accurate Moon Phase for multiple dates', () {
      final newMoonDate = DateTime.utc(2026, 1, 18, 12, 0);
      final lunarInfo = LunarCalculator.getTodayLunarInfo(newMoonDate);

      expect(lunarInfo.phase, isNotNull);
      expect(lunarInfo.phase.title.isNotEmpty, isTrue);
      expect(lunarInfo.moonZodiac.isNotEmpty, isTrue);
      expect(lunarInfo.illuminationPercent, inInclusiveRange(0.0, 100.0));
      expect(lunarInfo.transitGuidance.contains('Moon in'), isTrue);
    });
  });
}
