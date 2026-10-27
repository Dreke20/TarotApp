import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/ambient_soundscape_service.dart';
import '../../domain/sound_layer.dart';
import 'sound_weaver_state.dart';

part 'sound_weaver_notifier.g.dart';

@Riverpod(keepAlive: true)
class SoundWeaverNotifier extends _$SoundWeaverNotifier {
  final AudioPlayer _freqPlayer = AudioPlayer();
  final AudioPlayer _instPlayer = AudioPlayer();
  final AudioPlayer _natPlayer = AudioPlayer();

  AppLifecycleListener? _lifecycleListener;
  bool _wasPlayingBeforePause = false;
  Timer? _countdownTimer;

  @override
  SoundWeaverState build() {
    _initPlayers();

    _lifecycleListener = AppLifecycleListener(
      onPause: () {
        if (state.isPlaying) {
          _wasPlayingBeforePause = true;
          _pausePlayers();
        }
      },
      onResume: () {
        if (_wasPlayingBeforePause && state.isPlaying) {
          _wasPlayingBeforePause = false;
          _resumePlayers();
        }
      },
    );

    ref.onDispose(() {
      _countdownTimer?.cancel();
      try {
        _lifecycleListener?.dispose();
        _freqPlayer.dispose();
        _instPlayer.dispose();
        _natPlayer.dispose();
      } catch (_) {}
    });

    return const SoundWeaverState();
  }

  void _initPlayers() {
    try {
      _freqPlayer.setReleaseMode(ReleaseMode.loop);
      _instPlayer.setReleaseMode(ReleaseMode.loop);
      _natPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (_) {}
  }

  Future<void> togglePlay() async {
    if (state.isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> play() async {
    _wasPlayingBeforePause = false;

    // Pause single-track ambient soundscape if it is running to prevent cacophony
    try {
      final AmbientAudioState singleAmbient = ref.read(ambientAudioProvider);
      if (singleAmbient.isPlaying) {
        await ref.read(ambientAudioProvider.notifier).togglePlay();
      }
    } catch (_) {}

    state = state.copyWith(isPlaying: true);

    await Future.wait([
      _startLayer(_freqPlayer, state.frequencyTrack, state.effectiveVolume(SoundLayerCategory.frequency)),
      _startLayer(_instPlayer, state.instrumentTrack, state.effectiveVolume(SoundLayerCategory.instrument)),
      _startLayer(_natPlayer, state.natureTrack, state.effectiveVolume(SoundLayerCategory.nature)),
    ]);
  }

  Future<void> pause() async {
    _wasPlayingBeforePause = false;
    _pausePlayers();
    state = state.copyWith(isPlaying: false);
  }

  void _pausePlayers() {
    try {
      _freqPlayer.pause();
      _instPlayer.pause();
      _natPlayer.pause();
    } catch (_) {}
  }

  void _resumePlayers() {
    try {
      _freqPlayer.resume();
      _instPlayer.resume();
      _natPlayer.resume();
    } catch (_) {}
  }

  Future<void> setMasterVolume(double volume) async {
    final double clamped = volume.clamp(0.0, 1.0);
    state = state.copyWith(masterVolume: clamped);
    await _syncVolumes();
  }

  Future<void> setLayerVolume(SoundLayerCategory category, double volume) async {
    final double clamped = volume.clamp(0.0, 1.0);
    switch (category) {
      case SoundLayerCategory.frequency:
        state = state.copyWith(frequencyVolume: clamped, clearPreset: true);
        await _freqPlayer.setVolume(state.effectiveVolume(category));
        break;
      case SoundLayerCategory.instrument:
        state = state.copyWith(instrumentVolume: clamped, clearPreset: true);
        await _instPlayer.setVolume(state.effectiveVolume(category));
        break;
      case SoundLayerCategory.nature:
        state = state.copyWith(natureVolume: clamped, clearPreset: true);
        await _natPlayer.setVolume(state.effectiveVolume(category));
        break;
    }
  }

  Future<void> toggleLayerMute(SoundLayerCategory category) async {
    switch (category) {
      case SoundLayerCategory.frequency:
        final bool newMuted = !state.isFrequencyMuted;
        state = state.copyWith(isFrequencyMuted: newMuted);
        await _freqPlayer.setVolume(state.effectiveVolume(category));
        break;
      case SoundLayerCategory.instrument:
        final bool newMuted = !state.isInstrumentMuted;
        state = state.copyWith(isInstrumentMuted: newMuted);
        await _instPlayer.setVolume(state.effectiveVolume(category));
        break;
      case SoundLayerCategory.nature:
        final bool newMuted = !state.isNatureMuted;
        state = state.copyWith(isNatureMuted: newMuted);
        await _natPlayer.setVolume(state.effectiveVolume(category));
        break;
    }
  }

  Future<void> setLayerTrack(SoundLayerCategory category, SoundLayerTrack track) async {
    switch (category) {
      case SoundLayerCategory.frequency:
        state = state.copyWith(frequencyTrack: track, clearPreset: true);
        if (state.isPlaying) {
          await _startLayer(_freqPlayer, track, state.effectiveVolume(category));
        }
        break;
      case SoundLayerCategory.instrument:
        state = state.copyWith(instrumentTrack: track, clearPreset: true);
        if (state.isPlaying) {
          await _startLayer(_instPlayer, track, state.effectiveVolume(category));
        }
        break;
      case SoundLayerCategory.nature:
        state = state.copyWith(natureTrack: track, clearPreset: true);
        if (state.isPlaying) {
          await _startLayer(_natPlayer, track, state.effectiveVolume(category));
        }
        break;
    }
  }

  Future<void> applyPreset(SoundPreset preset) async {
    state = state.copyWith(
      activePreset: preset,
      frequencyTrack: preset.frequencyTrack,
      frequencyVolume: preset.frequencyVolume,
      isFrequencyMuted: false,
      instrumentTrack: preset.instrumentTrack,
      instrumentVolume: preset.instrumentVolume,
      isInstrumentMuted: false,
      natureTrack: preset.natureTrack,
      natureVolume: preset.natureVolume,
      isNatureMuted: false,
    );

    if (state.isPlaying) {
      await Future.wait([
        _startLayer(_freqPlayer, preset.frequencyTrack, state.effectiveVolume(SoundLayerCategory.frequency)),
        _startLayer(_instPlayer, preset.instrumentTrack, state.effectiveVolume(SoundLayerCategory.instrument)),
        _startLayer(_natPlayer, preset.natureTrack, state.effectiveVolume(SoundLayerCategory.nature)),
      ]);
    }
  }

  void setTimerMinutes(int? minutes) {
    _countdownTimer?.cancel();
    if (minutes == null || minutes <= 0) {
      state = state.copyWith(clearTimer: true);
      return;
    }

    final int totalSeconds = minutes * 60;
    state = state.copyWith(
      timerDurationSeconds: totalSeconds,
      remainingTimerSeconds: totalSeconds,
    );

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final int? remaining = state.remainingTimerSeconds;
      if (remaining == null || remaining <= 1) {
        timer.cancel();
        _onTimerExpired();
      } else {
        state = state.copyWith(remainingTimerSeconds: remaining - 1);
      }
    });
  }

  void clearTimer() {
    _countdownTimer?.cancel();
    state = state.copyWith(clearTimer: true);
  }

  Future<void> _onTimerExpired() async {
    // Fade out smoothly over 3 seconds
    try {
      final double initialMaster = state.masterVolume;
      for (int i = 1; i <= 6; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        final double stepVol = initialMaster * (1.0 - (i / 6));
        await setMasterVolume(stepVol);
      }
      await pause();
      // Restore initial master volume for next session
      state = state.copyWith(masterVolume: initialMaster, clearTimer: true);
    } catch (_) {
      await pause();
      state = state.copyWith(clearTimer: true);
    }
  }

  Future<void> _syncVolumes() async {
    await Future.wait([
      _freqPlayer.setVolume(state.effectiveVolume(SoundLayerCategory.frequency)),
      _instPlayer.setVolume(state.effectiveVolume(SoundLayerCategory.instrument)),
      _natPlayer.setVolume(state.effectiveVolume(SoundLayerCategory.nature)),
    ]);
  }

  Future<void> _startLayer(AudioPlayer player, SoundLayerTrack track, double volume) async {
    try {
      await player.setVolume(volume);
      try {
        await player.play(AssetSource(track.assetPath));
        return;
      } catch (assetErr) {
        debugPrint('[SoundWeaver] Asset play failed, falling back to remote URL: $assetErr');
      }
      await player.play(UrlSource(track.fallbackUrl));
    } catch (e) {
      debugPrint('[SoundWeaver] Layer play error: $e');
    }
  }
}
