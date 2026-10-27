import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/domain/oracle_persona.dart';
import '../../../tarot/presentation/widgets/mystic_background.dart';
import '../../domain/oracle_dialogue_message.dart';
import '../notifiers/oracle_dialogue_notifier.dart';
import '../notifiers/oracle_dialogue_state.dart';
import '../widgets/dialogue_input_dock.dart';
import '../widgets/dialogue_transcript_list.dart';
import '../widgets/oracle_voice_orb.dart';

/// Tier 2 • Two-Way Conversational Voice Oracle.
///
/// A hands-free spoken dialogue sanctuary: the seeker speaks, the Oracle
/// draws cards when relevant and answers aloud in the chosen persona's voice.
class ConversationalOracleScreen extends ConsumerStatefulWidget {
  const ConversationalOracleScreen({super.key, this.openingPrompt});

  /// Optional first message sent automatically (e.g. from the AR Altar).
  final String? openingPrompt;

  @override
  ConsumerState<ConversationalOracleScreen> createState() =>
      _ConversationalOracleScreenState();
}

class _ConversationalOracleScreenState
    extends ConsumerState<ConversationalOracleScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final OracleDialogueNotifier notifier =
          ref.read(oracleDialogueProvider.notifier);
      await notifier.initSpeech();
      final String? opening = widget.openingPrompt;
      if (opening != null && opening.trim().isNotEmpty && mounted) {
        await notifier.sendText(opening);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOut,
      );
    });
  }

  String _statusLabel(OracleDialogueViewState s) => switch (s.phase) {
        DialogueState.listening => 'LISTENING…',
        DialogueState.synthesizing => 'THE ORACLE CONTEMPLATES…',
        DialogueState.speaking => 'THE ORACLE SPEAKS',
        DialogueState.idle || DialogueState.complete =>
          s.isSpeechAvailable ? 'TAP THE ORB TO SPEAK' : 'TYPE YOUR QUESTION BELOW',
      };

  Future<void> _openPersonaPicker(OraclePersona current) async {
    final OraclePersona? chosen = await showModalBottomSheet<OraclePersona>(
      context: context,
      backgroundColor: AppColors.backgroundMidnight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: OraclePersona.values
              .map((OraclePersona p) => ListTile(
                    key: Key('persona_option_${p.id}'),
                    leading: Icon(p.icon, color: p.accentColor),
                    title: Text(p.title,
                        style: GoogleFonts.cinzel(
                            color: AppColors.goldBright, fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text(p.subtitle,
                        style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 12)),
                    trailing: p == current
                        ? const Icon(Icons.check_circle, color: AppColors.goldBright)
                        : null,
                    onTap: () => Navigator.of(ctx).pop(p),
                  ))
              .toList(),
        ),
      ),
    );
    if (chosen != null && chosen != current) {
      await ref.read(oracleDialogueProvider.notifier).selectPersona(chosen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OracleDialogueViewState s = ref.watch(oracleDialogueProvider);
    final OracleDialogueNotifier notifier = ref.read(oracleDialogueProvider.notifier);

    ref.listen<OracleDialogueViewState>(oracleDialogueProvider,
        (OracleDialogueViewState? prev, OracleDialogueViewState next) {
      if (prev?.messages.length != next.messages.length ||
          prev?.liveTranscript != next.liveTranscript) {
        _scrollToEnd();
      }
      final String? err = next.errorMessage;
      if (err != null && err != prev?.errorMessage) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(err),
            backgroundColor: AppColors.cosmicSurface,
            behavior: SnackBarBehavior.floating,
          ));
      }
    });

    final Color accent = s.persona.accentColor;
    final double orbSize = MediaQuery.sizeOf(context).height < 700 ? 150 : 190;

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      body: MysticBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              _DialogueHeader(
                persona: s.persona,
                onBack: () => Navigator.of(context).maybePop(),
                onPersona: () => _openPersonaPicker(s.persona),
                onShare: () => SharePlus.instance.share(
                  ShareParams(text: notifier.transcriptAsText()),
                ),
                onReset: notifier.resetConversation,
              ),
              const SizedBox(height: 4),
              OracleVoiceOrb(
                phase: s.phase,
                soundLevel: s.soundLevel,
                accent: accent,
                size: orbSize,
                onTap: notifier.onOrbTapped,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  _statusLabel(s),
                  key: ValueKey<String>(_statusLabel(s)),
                  style: GoogleFonts.cinzel(
                    fontSize: 11.5,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: DialogueTranscriptList(
                  messages: s.messages,
                  controller: _scroll,
                  accent: accent,
                  liveTranscript: s.phase == DialogueState.listening ? s.liveTranscript : '',
                ),
              ),
              DialogueInputDock(
                onSend: notifier.sendText,
                isHandsFree: s.isHandsFree,
                isVoiceMuted: s.isVoiceMuted,
                onToggleHandsFree: notifier.toggleHandsFree,
                onToggleVoice: notifier.toggleVoiceMuted,
                isBusy: s.phase == DialogueState.synthesizing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogueHeader extends StatelessWidget {
  const _DialogueHeader({
    required this.persona,
    required this.onBack,
    required this.onPersona,
    required this.onShare,
    required this.onReset,
  });

  final OraclePersona persona;
  final VoidCallback onBack;
  final VoidCallback onPersona;
  final VoidCallback onShare;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        children: <Widget>[
          IconButton(
            key: const Key('dialogue_back_button'),
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.goldBright, size: 20),
            tooltip: 'Back',
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  'VOICE ORACLE',
                  style: GoogleFonts.cinzel(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: AppColors.goldBright,
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  key: const Key('dialogue_persona_chip'),
                  borderRadius: BorderRadius.circular(14),
                  onTap: onPersona,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: persona.accentColor.withValues(alpha: 0.7)),
                      color: persona.accentColor.withValues(alpha: 0.12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(persona.icon, size: 13, color: persona.accentColor),
                        const SizedBox(width: 6),
                        Text(
                          persona.title,
                          style: GoogleFonts.cinzel(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Icon(Icons.expand_more, size: 14, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            key: const Key('dialogue_share_button'),
            onPressed: onShare,
            icon: const Icon(Icons.ios_share, color: AppColors.goldBright, size: 20),
            tooltip: 'Share transcript',
          ),
          IconButton(
            key: const Key('dialogue_reset_button'),
            onPressed: onReset,
            icon: const Icon(Icons.refresh, color: AppColors.goldBright, size: 20),
            tooltip: 'New conversation',
          ),
        ],
      ),
    );
  }
}
