import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../../../core/supabase/supabase_client.dart';
import '../../../tarot/domain/oracle_persona.dart';
import '../../../tarot/presentation/notifiers/oracle_persona_notifier.dart';
import '../../data/oracle_dialogue_service.dart';
import '../../data/oracle_speech_service.dart';
import '../../domain/oracle_dialogue_message.dart';
import '../../domain/oracle_dialogue_reply.dart';
import 'oracle_dialogue_state.dart';

part 'oracle_dialogue_notifier.g.dart';

@riverpod
OracleDialogueService oracleDialogueService(Ref ref) {
  return OracleDialogueService(supabase: ref.watch(supabaseClientProvider));
}

@riverpod
OracleSpeechService oracleSpeechService(Ref ref) {
  final OracleSpeechService service = OracleSpeechService();
  ref.onDispose(service.cancel);
  return service;
}

/// Drives the two-way Conversational Voice Oracle:
/// idle → listening → synthesizing → speaking → (hands-free) listening …
@riverpod
class OracleDialogueNotifier extends _$OracleDialogueNotifier {
  static const Uuid _uuid = Uuid();
  bool _submittedThisListen = false;

  @override
  OracleDialogueViewState build() {
    final OraclePersona persona = ref.read(oraclePersonaProvider);
    ref.onDispose(() {
      CelestialVoiceService.instance.stop();
    });
    return OracleDialogueViewState(
      persona: persona,
      messages: <OracleDialogueMessage>[_greeting(persona)],
    );
  }

  OracleDialogueMessage _greeting(OraclePersona persona) {
    final String text = switch (persona) {
      OraclePersona.highPriestess =>
        'The veil is thin tonight. Speak, seeker, and I will listen to what lies beneath your words.',
      OraclePersona.hermit =>
        'Sit with me by the lantern. Ask what you came to ask, and we will walk through it slowly.',
      OraclePersona.empress =>
        'Welcome, dear one. Tell me what your heart is carrying, and we will tend to it together.',
      OraclePersona.magician =>
        'Everything you need is already on the table. Tell me what you wish to create.',
      OraclePersona.shadowMirror =>
        'I will not flatter you. Tell me the question you have been avoiding.',
    };
    return OracleDialogueMessage(
      id: _uuid.v4(),
      sender: DialogueSender.oracle,
      text: text,
      timestamp: DateTime.now(),
      personaId: persona.id,
    );
  }

  /// Prepares speech recognition (requests microphone permission).
  Future<void> initSpeech() async {
    final OracleSpeechService speech = ref.read(oracleSpeechServiceProvider);
    try {
      final bool ok = await speech.initialize(
        onStatus: _onSpeechStatus,
        onError: (String error) {
          if (!ref.mounted) return;
          state = state.copyWith(
            phase: DialogueState.idle,
            soundLevel: 0,
            errorMessage: _friendlySpeechError(error),
          );
        },
      );
      if (!ref.mounted) return;
      state = state.copyWith(
        isSpeechAvailable: ok,
        errorMessage: ok ? null : 'Voice input is unavailable. You can still type to the Oracle.',
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isSpeechAvailable: false,
        errorMessage: 'Voice input is unavailable. You can still type to the Oracle.',
      );
    }
  }

  String _friendlySpeechError(String raw) {
    if (raw.contains('no_match') || raw.contains('speech_timeout')) {
      return 'The Oracle did not catch that. Tap the orb and speak again.';
    }
    if (raw.contains('permission')) {
      return 'Microphone permission is needed for voice. You can still type.';
    }
    return 'Voice was interrupted. Tap the orb to try again.';
  }

  void _onSpeechStatus(String status) {
    if (!ref.mounted) return;
    // Recognizer ended on its own (silence timeout): submit what we heard.
    if ((status == 'done' || status == 'notListening') &&
        state.phase == DialogueState.listening) {
      _submitLiveTranscript();
    }
  }

  Future<void> startListening() async {
    if (state.phase == DialogueState.synthesizing) return;
    if (state.phase == DialogueState.speaking) {
      await stopSpeaking();
    }
    if (!state.isSpeechAvailable) {
      await initSpeech();
      if (!state.isSpeechAvailable) return;
    }
    _submittedThisListen = false;
    state = state.copyWith(
      phase: DialogueState.listening,
      liveTranscript: '',
      soundLevel: 0,
      errorMessage: null,
    );
    final OracleSpeechService speech = ref.read(oracleSpeechServiceProvider);
    await speech.listen(
      onResult: (String words, bool isFinal) {
        if (!ref.mounted) return;
        state = state.copyWith(liveTranscript: words);
        if (isFinal) _submitLiveTranscript();
      },
      onSoundLevel: (double level) {
        if (!ref.mounted) return;
        // Normalise the platform dB range (~-2..10) into 0..1 for the orb.
        state = state.copyWith(soundLevel: ((level + 2) / 12).clamp(0.0, 1.0));
      },
    );
  }

  /// Seeker tapped the orb while listening: finish and send.
  Future<void> stopListening() async {
    await ref.read(oracleSpeechServiceProvider).stop();
    if (!ref.mounted) return;
    _submitLiveTranscript();
  }

  void _submitLiveTranscript() {
    if (_submittedThisListen) return;
    _submittedThisListen = true;
    final String words = state.liveTranscript.trim();
    if (words.isEmpty) {
      state = state.copyWith(phase: DialogueState.idle, soundLevel: 0);
      return;
    }
    sendText(words);
  }

  /// Sends a typed or transcribed seeker message and voices the reply.
  Future<void> sendText(String text) async {
    final String trimmed = text.trim();
    if (trimmed.isEmpty || state.phase == DialogueState.synthesizing) return;

    final List<OracleDialogueMessage> history = state.messages;
    final OracleDialogueMessage seekerMsg = OracleDialogueMessage(
      id: _uuid.v4(),
      sender: DialogueSender.seeker,
      text: trimmed,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      messages: <OracleDialogueMessage>[...history, seekerMsg],
      phase: DialogueState.synthesizing,
      liveTranscript: '',
      soundLevel: 0,
      errorMessage: null,
    );

    OracleDialogueReply reply;
    try {
      reply = await ref.read(oracleDialogueServiceProvider).consult(
            prompt: trimmed,
            history: history,
            persona: state.persona,
          );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        phase: DialogueState.idle,
        errorMessage: 'The Oracle’s voice faded. Please ask again.',
      );
      return;
    }
    if (!ref.mounted) return;

    final OracleDialogueMessage oracleMsg = OracleDialogueMessage(
      id: _uuid.v4(),
      sender: DialogueSender.oracle,
      text: reply.text,
      timestamp: DateTime.now(),
      referencedCard: reply.drawnCard,
      personaId: state.persona.id,
      isSpoken: !state.isVoiceMuted,
    );
    state = state.copyWith(
      messages: <OracleDialogueMessage>[...state.messages, oracleMsg],
      phase: state.isVoiceMuted ? DialogueState.complete : DialogueState.speaking,
    );

    if (!state.isVoiceMuted) {
      await CelestialVoiceService.instance
          .speakAndAwait(reply.text, persona: state.persona);
      if (!ref.mounted) return;
      if (state.phase != DialogueState.speaking) return; // interrupted
      state = state.copyWith(phase: DialogueState.complete);
    }

    if (state.isHandsFree && state.isSpeechAvailable && !state.isVoiceMuted) {
      await startListening();
    }
  }

  Future<void> stopSpeaking() async {
    await CelestialVoiceService.instance.stop();
    if (!ref.mounted) return;
    state = state.copyWith(phase: DialogueState.idle);
  }

  /// Orb tap: context-sensitive primary action.
  Future<void> onOrbTapped() async {
    switch (state.phase) {
      case DialogueState.listening:
        await stopListening();
      case DialogueState.speaking:
        await stopSpeaking();
      case DialogueState.synthesizing:
        return;
      case DialogueState.idle:
      case DialogueState.complete:
        await startListening();
    }
  }

  void toggleHandsFree() {
    state = state.copyWith(isHandsFree: !state.isHandsFree);
  }

  Future<void> toggleVoiceMuted() async {
    final bool muted = !state.isVoiceMuted;
    if (muted && state.phase == DialogueState.speaking) {
      await stopSpeaking();
    }
    if (!ref.mounted) return;
    state = state.copyWith(isVoiceMuted: muted);
  }

  Future<void> selectPersona(OraclePersona persona) async {
    await stopSpeaking();
    await ref.read(oracleSpeechServiceProvider).cancel();
    if (!ref.mounted) return;
    await ref.read(oraclePersonaProvider.notifier).selectPersona(persona);
    if (!ref.mounted) return;
    state = state.copyWith(
      persona: persona,
      phase: DialogueState.idle,
      messages: <OracleDialogueMessage>[...state.messages, _greeting(persona)],
    );
  }

  Future<void> resetConversation() async {
    await stopSpeaking();
    await ref.read(oracleSpeechServiceProvider).cancel();
    if (!ref.mounted) return;
    state = state.copyWith(
      phase: DialogueState.idle,
      liveTranscript: '',
      errorMessage: null,
      messages: <OracleDialogueMessage>[_greeting(state.persona)],
    );
  }

  /// Plain-text transcript for sharing or journaling.
  String transcriptAsText() {
    final StringBuffer buffer = StringBuffer('Oraculum • Conversation with ${state.persona.title}\n\n');
    for (final OracleDialogueMessage m in state.messages) {
      final String who = m.sender == DialogueSender.oracle ? 'Oracle' : 'You';
      final String card = m.referencedCard == null
          ? ''
          : ' [${m.referencedCard!.name}${m.referencedCard!.isReversed ? ' ℞' : ''}]';
      buffer.writeln('$who$card: ${m.text}\n');
    }
    return buffer.toString();
  }
}
