import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/presentation/widgets/tarot_card_widget.dart';
import '../../domain/oracle_dialogue_message.dart';

/// Scrolling transcript of the spoken conversation.
class DialogueTranscriptList extends StatelessWidget {
  const DialogueTranscriptList({
    super.key,
    required this.messages,
    required this.controller,
    required this.accent,
    this.liveTranscript = '',
  });

  final List<OracleDialogueMessage> messages;
  final ScrollController controller;
  final Color accent;
  final String liveTranscript;

  @override
  Widget build(BuildContext context) {
    final bool showLive = liveTranscript.trim().isNotEmpty;
    return ListView.builder(
      key: const Key('dialogue_transcript_list'),
      controller: controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: messages.length + (showLive ? 1 : 0),
      itemBuilder: (BuildContext context, int i) {
        if (i == messages.length) {
          return _LiveBubble(text: liveTranscript);
        }
        return _DialogueBubble(message: messages[i], accent: accent);
      },
    );
  }
}

class _DialogueBubble extends StatelessWidget {
  const _DialogueBubble({required this.message, required this.accent});

  final OracleDialogueMessage message;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final bool isOracle = message.sender == DialogueSender.oracle;
    final Widget bubble = Container(
      constraints: const BoxConstraints(maxWidth: 520),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: isOracle
            ? LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.16),
                  AppColors.cosmicSurface.withValues(alpha: 0.92),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isOracle ? null : AppColors.goldBright.withValues(alpha: 0.12),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isOracle ? 4 : 18),
          bottomRight: Radius.circular(isOracle ? 18 : 4),
        ),
        border: Border.all(
          color: isOracle
              ? accent.withValues(alpha: 0.45)
              : AppColors.goldBright.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (message.referencedCard != null) ...<Widget>[
            _DrawnCardStrip(message: message),
            const SizedBox(height: 10),
          ],
          Text(
            message.text,
            style: isOracle
                ? GoogleFonts.cormorantGaramond(
                    fontSize: 17,
                    height: 1.35,
                    color: AppColors.textPrimary,
                  )
                : GoogleFonts.inter(fontSize: 14, height: 1.4, color: AppColors.textPrimary),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: isOracle ? Alignment.centerLeft : Alignment.centerRight,
        child: bubble,
      ),
    ).animate().fadeIn(duration: 380.ms).slideY(begin: 0.12, end: 0, curve: Curves.easeOut);
  }
}

class _DrawnCardStrip extends StatelessWidget {
  const _DrawnCardStrip({required this.message});

  final OracleDialogueMessage message;

  @override
  Widget build(BuildContext context) {
    final card = message.referencedCard!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TarotCardWidget(card: card, isFaceUp: true, width: 54, height: 88),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'CARD DRAWN',
                style: GoogleFonts.cinzel(
                  fontSize: 9.5,
                  letterSpacing: 1.6,
                  color: AppColors.goldMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                card.name.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                ),
              ),
              Text(
                card.isReversed ? 'Reversed' : 'Upright',
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LiveBubble extends StatelessWidget {
  const _LiveBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.25)),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
