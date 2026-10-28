import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/ambient_soundscape_service.dart';
import '../../../../core/services/speech_capture.dart';
import '../../../tarot/presentation/notifiers/reading_notifier.dart';
import '../../data/hands_free_voice_service.dart';
import '../../domain/hands_free_voice_state.dart';

part 'hands_free_voice_notifier.g.dart';

@riverpod
HandsFreeVoiceService handsFreeVoiceService(Ref ref) {
  final service = HandsFreeVoiceService();
  ref.onDispose(() => service.dispose());
  return service;
}

@riverpod
class HandsFreeVoiceNotifier extends _$HandsFreeVoiceNotifier {
  @override
  HandsFreeVoiceState build() {
    return const HandsFreeVoiceState();
  }

  /// Toggles continuous hands-free voice mode on or off.
  void toggleHandsFreeMode() {
    state = state.copyWith(handsFreeEnabled: !state.handsFreeEnabled);
  }

  /// Begins listening with dynamic background ambient ducking.
  ///
  /// A pause ends the microphone session and leaves the transcript editable.
  /// The question is stored on the reading only when the seeker anchors it,
  /// the same `setQuestion` path a typed question uses.
  Future<void> startListening() async {
    final service = ref.read(handsFreeVoiceServiceProvider);
    ref.read(voiceInputNoticeProvider.notifier).clear();

    await ref.read(ambientAudioProvider.notifier).duckVolume(0.15);

    state = state.copyWith(
      isListening: true,
      currentTranscript: '',
      duckingLevel: 0.15,
    );

    final result = await service.startListening(
      onResult: (transcript, confidence) {
        state = state.copyWith(
          currentTranscript: transcript,
          speechConfidence: confidence,
        );
      },
      onSoundLevel: (level) {
        state = state.copyWith(soundLevel: level);
      },
      onSilenceCommit: (finalizedText) async {
        await stopListening();
        if (finalizedText.trim().isNotEmpty) {
          state = state.copyWith(currentTranscript: finalizedText.trim());
        }
      },
      onFailure: (failure) async {
        await stopListening();
        final notice = VoiceInputNotice.forFailure(failure);
        if (notice != null) {
          ref.read(voiceInputNoticeProvider.notifier).show(notice);
        }
      },
    );

    final notice = VoiceInputNotice.forResult(result);
    if (notice != null) {
      await stopListening();
      ref.read(voiceInputNoticeProvider.notifier).show(notice);
    }
  }

  /// Lets the seeker correct a partial or final transcript before anchoring it.
  void editTranscript(String value) {
    state = state.copyWith(currentTranscript: value);
  }

  Future<bool> openSettings() {
    return ref.read(handsFreeVoiceServiceProvider).openSettings();
  }

  /// Commits the spoken inquiry to the sacred altar and restores ambient volume.
  Future<void> commitInquiry(String inquiry) async {
    final service = ref.read(handsFreeVoiceServiceProvider);
    await service.stopListening();

    // Restore background ambient soundscape
    await ref.read(ambientAudioProvider.notifier).restoreVolume();

    state = state.copyWith(
      isListening: false,
      lastFinalizedInquiry: inquiry,
      duckingLevel: 1.0,
      soundLevel: 0.0,
    );

    // Anchor inquiry directly into altar reading intention
    ref.read(readingNotifierProvider.notifier).setQuestion(inquiry);
  }

  /// Stops voice listening manually.
  Future<void> stopListening() async {
    final service = ref.read(handsFreeVoiceServiceProvider);
    await service.stopListening();
    await ref.read(ambientAudioProvider.notifier).restoreVolume();

    state = state.copyWith(
      isListening: false,
      duckingLevel: 1.0,
      soundLevel: 0.0,
    );
  }

  /// Clears the current transcript buffer.
  void clearTranscript() {
    state = state.copyWith(currentTranscript: '');
  }
}

/// Backward/convenience alias for handsFreeVoiceProvider
final handsFreeVoiceNotifierProvider = handsFreeVoiceProvider;

/// Permission, timeout, and recognizer messages for the Voice Oracle sheet.
class VoiceInputNoticeController extends Notifier<VoiceInputNotice?> {
  @override
  VoiceInputNotice? build() => null;

  void show(VoiceInputNotice notice) => state = notice;

  void clear() => state = null;
}

final voiceInputNoticeProvider =
    NotifierProvider<VoiceInputNoticeController, VoiceInputNotice?>(
  VoiceInputNoticeController.new,
);
