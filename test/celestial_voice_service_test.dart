import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/core/services/celestial_voice_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('flutter_tts');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'setLanguage':
        case 'setSpeechRate':
        case 'setPitch':
        case 'setVolume':
        case 'speak':
        case 'stop':
          return 1;
        default:
          return 1;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('CelestialVoiceService Tests', () {
    test('instance provides a singleton reference', () {
      final voice1 = CelestialVoiceService.instance;
      final voice2 = CelestialVoiceService.instance;
      expect(identical(voice1, voice2), isTrue);
    });

    test('initial isPlaying state is false', () {
      final voice = CelestialVoiceService.instance;
      expect(voice.isPlaying, isFalse);
    });

    test('callbacks and stop execute safely', () async {
      final voice = CelestialVoiceService.instance;
      bool started = false;
      bool stopped = false;

      voice.onStarted = () => started = true;
      voice.onStopped = () => stopped = true;

      expect(started, isFalse);
      expect(stopped, isFalse);

      await voice.stop();
      expect(voice.isPlaying, isFalse);
      expect(stopped, isTrue);

      voice.onStarted = null;
      voice.onStopped = null;
    });

    test('init sets oracle audio calibration safely', () async {
      final voice = CelestialVoiceService.instance;
      await voice.init();
      expect(voice.isPlaying, isFalse);
    });
  });
}
