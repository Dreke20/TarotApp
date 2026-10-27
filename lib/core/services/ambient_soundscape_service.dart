import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ambient_soundscape_service.g.dart';

enum SoundscapeTrack {
  solfeggio432(
    '432 Hz Cosmic Harmony',
    'audio/solfeggio_432.wav',
    'https://actions.google.com/sounds/v1/science_fiction/low_frequency_hum.ogg',
  ),
  solfeggio528(
    '528 Hz Miracle & Heart',
    'audio/solfeggio_528.wav',
    'https://actions.google.com/sounds/v1/science_fiction/force_field_loop.ogg',
  ),
  solfeggio741(
    '741 Hz Intuition Awakening',
    'audio/solfeggio_741.wav',
    'https://actions.google.com/sounds/v1/science_fiction/alien_beacon_loop.ogg',
  ),
  celestialDrone(
    'Celestial Drone',
    'audio/celestial_drone.wav',
    'https://actions.google.com/sounds/v1/science_fiction/space_ambience_hum.ogg',
  ),
  tibetanBowls(
    'Sacred Chime & Bowls',
    'audio/tibetan_bowls.wav',
    'https://actions.google.com/sounds/v1/ambiences/wind_chimes_breeze.ogg',
  ),
  sacredWind(
    'Astral Breeze',
    'audio/astral_breeze.wav',
    'https://actions.google.com/sounds/v1/weather/wind_howl.ogg',
  );

  final String title;
  final String assetPath;
  final String fallbackUrl;
  const SoundscapeTrack(this.title, this.assetPath, this.fallbackUrl);
}

class AmbientAudioState {
  final bool isPlaying;
  final double volume;
  final SoundscapeTrack track;

  const AmbientAudioState({
    this.isPlaying = false,
    this.volume = 0.5,
    this.track = SoundscapeTrack.solfeggio432,
  });

  AmbientAudioState copyWith({
    bool? isPlaying,
    double? volume,
    SoundscapeTrack? track,
  }) {
    return AmbientAudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
      track: track ?? this.track,
    );
  }
}

@Riverpod(keepAlive: true)
class AmbientAudioNotifier extends _$AmbientAudioNotifier {
  final AudioPlayer _player = AudioPlayer();
  AppLifecycleListener? _lifecycleListener;
  bool _wasPlayingBeforePause = false;

  @override
  AmbientAudioState build() {
    try {
      _player.setReleaseMode(ReleaseMode.loop);
    } catch (_) {}

    _lifecycleListener = AppLifecycleListener(
      onPause: () {
        if (state.isPlaying) {
          _wasPlayingBeforePause = true;
          try {
            _player.pause();
          } catch (_) {}
        }
      },
      onResume: () {
        if (_wasPlayingBeforePause && state.isPlaying) {
          _wasPlayingBeforePause = false;
          try {
            _player.resume();
          } catch (_) {}
        }
      },
    );

    ref.onDispose(() {
      try {
        _lifecycleListener?.dispose();
        _player.dispose();
      } catch (_) {}
    });
    return const AmbientAudioState();
  }

  Future<void> togglePlay() async {
    _wasPlayingBeforePause = false;
    if (state.isPlaying) {
      try {
        await _player.pause();
      } catch (_) {}
      state = state.copyWith(isPlaying: false);
    } else {
      await _playTrack(state.track);
    }
  }

  Future<void> selectTrack(SoundscapeTrack newTrack) async {
    state = state.copyWith(track: newTrack);
    if (state.isPlaying) {
      await _playTrack(newTrack);
    }
  }

  double _preDuckVolume = 0.5;

  Future<void> duckVolume([double target = 0.15]) async {
    _preDuckVolume = state.volume;
    try {
      await _player.setVolume(target);
    } catch (_) {}
  }

  Future<void> restoreVolume() async {
    try {
      await _player.setVolume(_preDuckVolume);
    } catch (_) {}
  }

  Future<void> setVolume(double volume) async {
    state = state.copyWith(volume: volume);
    try {
      await _player.setVolume(volume);
    } catch (_) {}
  }

  Future<void> _playTrack(SoundscapeTrack track) async {
    try {
      await _player.setVolume(state.volume);
      // 1. Attempt instantaneous local asset playback
      try {
        await _player.play(AssetSource(track.assetPath));
        state = state.copyWith(isPlaying: true);
        return;
      } catch (assetErr) {
        debugPrint('[AmbientAudio] AssetSource failed, attempting fallback URL: $assetErr');
      }

      // 2. Fallback to remote network stream if local asset is unresolvable
      await _player.play(UrlSource(track.fallbackUrl));
      state = state.copyWith(isPlaying: true);
    } catch (e) {
      debugPrint('[AmbientAudio] Playback error: $e');
      state = state.copyWith(isPlaying: false);
    }
  }
}
