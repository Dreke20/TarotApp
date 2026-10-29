import 'package:flutter/material.dart';

import '../../../voice_oracle/presentation/widgets/hands_free_communion_modal.dart';

/// Opens the Voice Oracle sheet.
///
/// Spoken questions are transcribed by the platform recognizer and committed
/// through the same altar question path as typed text.
class VoiceInvocationModal extends StatelessWidget {
  final Function(String query) onQuestionSpoken;

  const VoiceInvocationModal({
    super.key,
    required this.onQuestionSpoken,
  });

  static void show(BuildContext context, {required Function(String) onQuestionSpoken}) {
    HandsFreeCommunionModal.show(
      context,
      onQuestionCommitted: onQuestionSpoken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HandsFreeCommunionModal(
      onQuestionCommitted: (question) => onQuestionSpoken(question),
    );
  }
}
