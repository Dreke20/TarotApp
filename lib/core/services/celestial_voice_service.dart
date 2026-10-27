import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../features/tarot/domain/oracle_persona.dart';

/// Acoustic frequency channels for dual-soul synastry and alchemical conjunction narration.
enum CelestialVoiceChannel {
  solar(
    id: 'solar',
    title: 'Solar Voice',
    subtitle: 'Conscious Will & Radiance',
    pitch: 0.82,
    speechRate: 0.44,
    glyph: '☀️',
  ),
  lunar(
    id: 'lunar',
    title: 'Lunar Voice',
    subtitle: 'Subconscious Heart & Depth',
    pitch: 1.18,
    speechRate: 0.38,
    glyph: '🌙',
  ),
  alchemical(
    id: 'alchemical',
    title: 'Alchemical Conjunction',
    subtitle: 'Sacred Synthesis & Shared Destiny',
    pitch: 0.98,
    speechRate: 0.40,
    glyph: '⚡',
  );

  final String id;
  final String title;
  final String subtitle;
  final double pitch;
  final double speechRate;
  final String glyph;

  const CelestialVoiceChannel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.pitch,
    required this.speechRate,
    required this.glyph,
  });
}

/// Service managing spoken celestial prophecies, multi-frequency synastry, and archetype auditions via text-to-speech.
class CelestialVoiceService {
  CelestialVoiceService._();
  static final CelestialVoiceService instance = CelestialVoiceService._();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool _isPlaying = false;
  String? _currentlyAuditioningId;
  CelestialVoiceChannel? _activeChannel;

  VoidCallback? onStarted;
  VoidCallback? onStopped;
  void Function(CelestialVoiceChannel? channel)? onChannelChanged;

  bool get isPlaying => _isPlaying;
  String? get currentlyAuditioningId => _currentlyAuditioningId;
  CelestialVoiceChannel? get activeChannel => _activeChannel;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      await _tts.setLanguage("en-US");
      // Default meditative pitch and rate for an oracle voice
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(0.92);
      await _tts.setVolume(1.0);

      _tts.setStartHandler(() {
        _isPlaying = true;
        onStarted?.call();
      });

      _tts.setCompletionHandler(() {
        _isPlaying = false;
        _currentlyAuditioningId = null;
        onStopped?.call();
      });

      _tts.setErrorHandler((dynamic msg) {
        _isPlaying = false;
        _currentlyAuditioningId = null;
        onStopped?.call();
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint("CelestialVoiceService init warning: $e");
    }
  }

  /// Speaks the prophecy text calibrated to the acoustic tuning of the [persona].
  Future<void> speak(String text, {OraclePersona? persona}) async {
    if (!_isInitialized) {
      await init();
    }
    if (_isPlaying) {
      await stop();
    }
    try {
      if (persona != null) {
        await _tts.setPitch(persona.pitch);
        await _tts.setSpeechRate(persona.speechRate);
      } else {
        await _tts.setPitch(0.92);
        await _tts.setSpeechRate(0.42);
      }

      _isPlaying = true;
      _currentlyAuditioningId = null;
      onStarted?.call();
      await _tts.speak(text);
    } catch (e) {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      onStopped?.call();
      debugPrint("CelestialVoiceService speak error: $e");
    }
  }

  /// Speaks [text] and completes only once the utterance has fully finished.
  ///
  /// Used by the Conversational Oracle's hands-free loop so the microphone is
  /// never re-opened while the Oracle is still speaking.
  Future<void> speakAndAwait(String text, {OraclePersona? persona}) async {
    if (!_isInitialized) {
      await init();
    }
    try {
      await _tts.awaitSpeakCompletion(true);
      await speak(text, persona: persona);
    } catch (e) {
      debugPrint("CelestialVoiceService speakAndAwait error: $e");
    } finally {
      try {
        await _tts.awaitSpeakCompletion(false);
      } catch (_) {}
      _isPlaying = false;
    }
  }

  /// Auditions the archetypal acoustic profile and sample quote for the specified [persona].
  Future<void> auditionPersona(OraclePersona persona) async {
    if (!_isInitialized) {
      await init();
    }
    if (_isPlaying) {
      await stop();
    }
    try {
      await _tts.setPitch(persona.pitch);
      await _tts.setSpeechRate(persona.speechRate);

      // Clean quotation symbols for natural oral delivery
      final cleanQuote = persona.sampleQuote.replaceAll('“', '').replaceAll('”', '').replaceAll('"', '');
      final auditionScript = "I am ${persona.title}. $cleanQuote";

      _isPlaying = true;
      _currentlyAuditioningId = persona.id;
      onStarted?.call();
      await _tts.speak(auditionScript);
    } catch (e) {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      onStopped?.call();
      debugPrint("CelestialVoiceService audition error: $e");
    }
  }

  /// Speaks an utterance tuned to a specific [CelestialVoiceChannel].
  Future<void> speakChannel(
    String text, {
    required CelestialVoiceChannel channel,
  }) async {
    if (!_isInitialized) await init();
    if (_isPlaying) await stop();
    _activeChannel = channel;
    onChannelChanged?.call(channel);

    try {
      await _tts.setPitch(channel.pitch);
      await _tts.setSpeechRate(channel.speechRate);
      _isPlaying = true;
      _currentlyAuditioningId = null;
      onStarted?.call();
      await _tts.speak(text);
    } catch (e) {
      _isPlaying = false;
      _activeChannel = null;
      onChannelChanged?.call(null);
      onStopped?.call();
      debugPrint("CelestialVoiceService speakChannel error: $e");
    }
  }

  /// Speaks a complete multi-voice Sol & Luna synastry narration sequence:
  /// 1. Solar Voice (Partner A)
  /// 2. Lunar Voice (Partner B)
  /// 3. Alchemical Voice (The Conjunction Bridge)
  Future<void> speakSynastrySequence({
    required String partnerAName,
    required String partnerAText,
    required String partnerBName,
    required String partnerBText,
    required String conjunctionText,
  }) async {
    if (!_isInitialized) await init();
    if (_isPlaying) await stop();

    try {
      await _tts.awaitSpeakCompletion(true);
      _isPlaying = true;
      onStarted?.call();

      // Part 1: Solar Voice
      _activeChannel = CelestialVoiceChannel.solar;
      onChannelChanged?.call(_activeChannel);
      await _tts.setPitch(CelestialVoiceChannel.solar.pitch);
      await _tts.setSpeechRate(CelestialVoiceChannel.solar.speechRate);
      await _tts.speak('Solar Essence of $partnerAName. $partnerAText');

      if (!_isPlaying) return;

      // Part 2: Lunar Voice
      _activeChannel = CelestialVoiceChannel.lunar;
      onChannelChanged?.call(_activeChannel);
      await _tts.setPitch(CelestialVoiceChannel.lunar.pitch);
      await _tts.setSpeechRate(CelestialVoiceChannel.lunar.speechRate);
      await _tts.speak('Lunar Reflection of $partnerBName. $partnerBText');

      if (!_isPlaying) return;

      // Part 3: Alchemical Voice
      _activeChannel = CelestialVoiceChannel.alchemical;
      onChannelChanged?.call(_activeChannel);
      await _tts.setPitch(CelestialVoiceChannel.alchemical.pitch);
      await _tts.setSpeechRate(CelestialVoiceChannel.alchemical.speechRate);
      await _tts.speak('The Conjunction Bridge and Shared Destiny. $conjunctionText');
    } catch (e) {
      debugPrint("CelestialVoiceService speakSynastrySequence error: $e");
    } finally {
      try {
        await _tts.awaitSpeakCompletion(false);
      } catch (_) {}
      _isPlaying = false;
      _activeChannel = null;
      onChannelChanged?.call(null);
      onStopped?.call();
    }
  }

  /// Speaks a dual-card alchemical synergy sequence using the alchemical channel.
  Future<void> speakDualCardSynergy({
    required String cardAName,
    required String cardBName,
    required String title,
    required String synergyNarrative,
  }) async {
    if (!_isInitialized) await init();
    if (_isPlaying) await stop();

    try {
      _activeChannel = CelestialVoiceChannel.alchemical;
      onChannelChanged?.call(_activeChannel);
      await _tts.setPitch(CelestialVoiceChannel.alchemical.pitch);
      await _tts.setSpeechRate(CelestialVoiceChannel.alchemical.speechRate);
      _isPlaying = true;
      onStarted?.call();
      await _tts.speak('Alchemical Conjunction of $cardAName and $cardBName. $title. $synergyNarrative');
    } catch (e) {
      _isPlaying = false;
      _activeChannel = null;
      onChannelChanged?.call(null);
      onStopped?.call();
      debugPrint("CelestialVoiceService speakDualCardSynergy error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint("CelestialVoiceService stop error: $e");
    } finally {
      _isPlaying = false;
      _currentlyAuditioningId = null;
      _activeChannel = null;
      onChannelChanged?.call(null);
      onStopped?.call();
    }
  }
}

