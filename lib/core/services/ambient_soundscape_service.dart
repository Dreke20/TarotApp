import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ambient_soundscape_service.g.dart';

enum SoundscapeTrack {
  celestialDrone('Celestial Drone', 'https://actions.google.com/sounds/v1/science_fiction/space_ambience_hum.ogg'),
  tibetanBowls('Sacred Chime', 'https://actions.google.com/sounds/v1/ambiences/wind_chimes_breeze.ogg'),
  sacredWind('Astral Breeze', 'https://actions.google.com/sounds/v1/weather/wind_howl.ogg');

  final String title;
  final String url;
  const SoundscapeTrack(this.title, this.url);
}

class AmbientAudioState {
  final bool isPlaying;
  final double volume;
  final SoundscapeTrack track;

  const AmbientAudioState({
    this.isPlaying = false,
    this.volume = 0.5,
    this.track = SoundscapeTrack.celestialDrone,
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

  @override
  AmbientAudioState build() {
    _player.setReleaseMode(ReleaseMode.loop);
    ref.onDispose(() {
      _player.dispose();
    });
    return const AmbientAudioState();
  }

  Future<void> togglePlay() async {
    if (state.isPlaying) {
      await _player.pause();
      state = state.copyWith(isPlaying: false);
    } else {
      try {
        await _player.setVolume(state.volume);
        await _player.play(UrlSource(state.track.url));
        state = state.copyWith(isPlaying: true);
      } catch (e) {
        debugPrint("Ambient audio playback warning: $e");
      }
    }
  }

  Future<void> selectTrack(SoundscapeTrack newTrack) async {
    state = state.copyWith(track: newTrack);
    if (state.isPlaying) {
      try {
        await _player.stop();
        await _player.play(UrlSource(newTrack.url));
      } catch (e) {
        debugPrint("Select track error: $e");
      }
    }
  }

  Future<void> setVolume(double volume) async {
    state = state.copyWith(volume: volume);
    await _player.setVolume(volume);
  }
}

