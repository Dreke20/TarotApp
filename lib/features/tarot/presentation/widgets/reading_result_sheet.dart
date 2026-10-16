import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../domain/oracle_persona.dart';
import '../../domain/reading.dart';
import '../notifiers/reading_notifier.dart';
import 'glass_container.dart';
import 'live_reader_card.dart';
import 'social_share_card.dart';
import 'social_story_export_modal.dart';
import 'tarot_card_widget.dart';

/// Immersive Glassmorphic Bottom Sheet displaying the AI Oracle's reading,
/// conversational multi-turn follow-ups, personal reflections, and audio narration.
class ReadingResultSheet extends ConsumerStatefulWidget {
  final Reading reading;
  final VoidCallback onNewReading;

  const ReadingResultSheet({
    super.key,
    required this.reading,
    required this.onNewReading,
  });

  static Future<void> show(
    BuildContext context, {
    required Reading reading,
    required VoidCallback onNewReading,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReadingResultSheet(
        reading: reading,
        onNewReading: onNewReading,
      ),
    );
  }

  @override
  ConsumerState<ReadingResultSheet> createState() => _ReadingResultSheetState();
}

class _ReadingResultSheetState extends ConsumerState<ReadingResultSheet> {
  final TextEditingController _followUpController = TextEditingController();
  late final TextEditingController _notesController;
  bool _isPlayingNarration = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.reading.notes);
    CelestialVoiceService.instance.init();
    CelestialVoiceService.instance.onStarted = () {
      if (mounted) setState(() => _isPlayingNarration = true);
    };
    CelestialVoiceService.instance.onStopped = () {
      if (mounted) setState(() => _isPlayingNarration = false);
    };
  }

  @override
  void dispose() {
    CelestialVoiceService.instance.stop();
    _followUpController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final state = ref.watch(readingNotifierProvider);
    final notifier = ref.read(readingNotifierProvider.notifier);
    final reading = state.currentReading ?? widget.reading;
    final persona = reading.personaId != null
        ? OraclePersona.all.firstWhere(
            (p) => p.id == reading.personaId,
            orElse: () => OraclePersona.highPriestess,
          )
        : null;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.92,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 24,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.94),
        borderColor: AppColors.glassBorderGlow,
        borderWidth: 1.5,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            // Drag indicator handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Sheet Title & Actions (Favorite, Share, Close)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        persona?.icon ?? Icons.auto_awesome,
                        color: persona?.accentColor ?? AppColors.goldBright,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ORACLE\'S PROPHECY',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cinzel(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.2,
                              ),
                            ),
                            if (persona != null)
                              Text(
                                persona.name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: persona.accentColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // Favorite Toggle
                    IconButton(
                      icon: Icon(
                        reading.isFavorite ? Icons.star : Icons.star_border,
                        color: reading.isFavorite ? AppColors.goldBright : AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () => notifier.toggleFavorite(reading.id, !reading.isFavorite),
                    ),
                    // 9:16 Social Story Export
                    IconButton(
                      tooltip: 'Export 9:16 Story',
                      icon: const Icon(Icons.auto_awesome_motion, color: AppColors.goldBright, size: 19),
                      onPressed: () {
                        if (reading.cards.isNotEmpty) {
                          SocialStoryExportModal.show(
                            context,
                            card: reading.cards.first,
                            isReversed: reading.cards.first.isReversed,
                            customQuote: reading.summary ?? reading.advice ?? reading.cards.first.meaningUpright,
                          );
                        } else {
                          SocialShareCardDialog.show(context, reading: reading);
                        }
                      },
                    ),
                    // Social Share
                    IconButton(
                      icon: const Icon(Icons.share, color: AppColors.textSecondary, size: 19),
                      onPressed: () => SocialShareCardDialog.show(context, reading: reading),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: AppColors.glassBorder, height: 20),

            // Scrollable Reading Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question banner
                    if (reading.question.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.glassFillStrong,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.etherealLavender.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.psychology,
                              size: 18,
                              color: AppColors.etherealLavender,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '"${reading.question}"',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Spoken Prophecy Voice Narration Bar
                    GestureDetector(
                      onTap: () async {
                        final voice = CelestialVoiceService.instance;
                        if (_isPlayingNarration) {
                          await voice.stop();
                        } else {
                          final textToSpeak = "${reading.summary} ${reading.interpretation} Guidance: ${reading.advice}";
                          await voice.speak(textToSpeak, persona: persona);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isPlayingNarration
                              ? (persona?.accentColor.withValues(alpha: 0.18) ?? AppColors.goldBright.withValues(alpha: 0.15))
                              : AppColors.glassFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isPlayingNarration
                                ? (persona?.accentColor ?? AppColors.goldBright)
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _isPlayingNarration ? Icons.volume_up : Icons.volume_mute,
                              color: _isPlayingNarration ? (persona?.accentColor ?? AppColors.goldBright) : AppColors.textSecondary,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _isPlayingNarration
                                    ? 'NARRATING PROPHECY (${persona?.name ?? "ORACLE"})...'
                                    : 'HEAR ${persona?.name ?? "ORACLE"} (${persona?.timbreTitle.toUpperCase() ?? "CELESTIAL HARMONY"})',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cinzel(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _isPlayingNarration ? (persona?.accentColor ?? AppColors.goldBright) : AppColors.textPrimary,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            if (_isPlayingNarration) ...[
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(persona?.accentColor ?? AppColors.goldBright),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Drawn Cards Thumbnail Row
                    Text(
                      'THE CARDS UNVEILED (${reading.cards.length})',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 155,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: reading.cards.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final card = reading.cards[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TarotCardWidget(
                                card: card,
                                isFaceUp: true,
                                width: 85,
                                height: 125,
                                index: index,
                                deckTheme: state.deckTheme,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  card.positionName ?? 'Card ${index + 1}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 9,
                                    color: AppColors.etherealLavender,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Cosmic Summary Callout
                    if (reading.summary != null) ...[
                      GlassContainer(
                        padding: const EdgeInsets.all(14),
                        borderRadius: 14,
                        fillColor: AppColors.cosmicSurface.withValues(alpha: 0.5),
                        borderColor: AppColors.goldBright.withValues(alpha: 0.4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.flare,
                              color: AppColors.goldBright,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                reading.summary!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.goldBright,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],

                    // Sacred Journey Recall Callout
                    if (reading.journeyRecall != null && reading.journeyRecall!.isNotEmpty) ...[
                      GlassContainer(
                        padding: const EdgeInsets.all(12),
                        borderRadius: 14,
                        fillColor: AppColors.purpleDeep.withValues(alpha: 0.35),
                        borderColor: AppColors.etherealLavender.withValues(alpha: 0.4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.history_edu,
                              color: AppColors.etherealLavender,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SACRED JOURNEY RECALL',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.etherealLavender,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    reading.journeyRecall!,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: AppColors.textPrimary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Elemental Chemistry, Cosmic Weather & Altar Consecration Matrix
                    if (reading.elementalChemistry != null || reading.cosmicWeather != null || reading.altarConsecration != null) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (reading.altarConsecration != null && reading.altarConsecration!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C152E),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.5)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('✦', style: TextStyle(fontSize: 11, color: AppColors.goldBright)),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      reading.altarConsecration!,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.goldBright,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (reading.cosmicWeather != null && reading.cosmicWeather!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.glassFillStrong,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.nightlight_round, size: 13, color: AppColors.goldBright),
                                  const SizedBox(width: 6),
                                  Text(
                                    reading.cosmicWeather!,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (reading.elementalChemistry != null && reading.elementalChemistry!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.glassFill,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.35)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.auto_awesome, size: 12, color: AppColors.goldBright),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      reading.elementalChemistry!,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.goldBright,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Full Interpretation Narrative
                    Text(
                      'CELESTIAL SYNTHESIS',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Text(
                        reading.interpretation,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          height: 1.65,
                        ),
                      ),
                    ),
                    // AI Transparency & Spiritual Reflection Disclaimer (Google Play AI Policy Compliance)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome, size: 12, color: AppColors.goldMuted),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Synthesized by AI for spiritual reflection & personal contemplation. Not medical, legal, or financial advice.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppColors.textMuted,
                                height: 1.3,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => _showReportAiDialog(context),
                            child: Text(
                              'Report',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10.5,
                                color: AppColors.goldBright,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Oracle's Advice
                    if (reading.advice != null) ...[
                      Text(
                        'SPIRITUAL COUNSEL',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.backgroundViolet.withValues(alpha: 0.6),
                              AppColors.cosmicSurface.withValues(alpha: 0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.etherealLavender.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.self_improvement,
                              color: AppColors.etherealLavender,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                reading.advice!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13.5,
                                  color: AppColors.textPrimary,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],

                    // --- CONVERSATIONAL FOLLOW-UP CHAT ---
                    Text(
                      'DIALOGUE WITH THE ORACLE',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldBright,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ask clarifying questions about these cards and your destiny.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Chat History Bubbles
                    if (state.conversationHistory.isNotEmpty) ...[
                      Column(
                        children: state.conversationHistory.map((msg) {
                          final isUser = msg.role == 'user';
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: mediaQuery.size.width * 0.78),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isUser ? AppColors.cosmicSurface : AppColors.glassFillStrong,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isUser
                                      ? AppColors.etherealLavender.withValues(alpha: 0.4)
                                      : AppColors.goldBright.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Text(
                                msg.content,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5,
                                  color: isUser ? AppColors.textPrimary : AppColors.goldBright,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Dynamic Scrying Prompts
                    if (reading.scryingPrompts.isNotEmpty) ...[
                      Text(
                        'DIVINE INQUIRIES',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: reading.scryingPrompts.map((prompt) {
                          return ActionChip(
                            avatar: const Icon(Icons.auto_awesome, size: 12, color: AppColors.goldBright),
                            label: Text(
                              prompt,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            backgroundColor: AppColors.glassFillStrong,
                            side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.3)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            onPressed: state.isAskingFollowUp
                                ? null
                                : () {
                                    _followUpController.text = prompt;
                                    notifier.askOracleFollowUp(prompt);
                                    _followUpController.clear();
                                  },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                    ],

                    // Follow-up Input Box
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: AppColors.glassFillStrong,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: TextField(
                              controller: _followUpController,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Ask the Oracle a follow-up...',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.goldBright,
                            foregroundColor: AppColors.backgroundDeep,
                          ),
                          icon: state.isAskingFollowUp
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(AppColors.backgroundDeep),
                                  ),
                                )
                              : const Icon(Icons.send, size: 18),
                          onPressed: state.isAskingFollowUp
                              ? null
                              : () {
                                  final text = _followUpController.text;
                                  if (text.isNotEmpty) {
                                    notifier.askOracleFollowUp(text);
                                    _followUpController.clear();
                                  }
                                },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- SEEKER'S SACRED REFLECTION / NOTES ---
                    Text(
                      'SEEKER\'S SACRED REFLECTIONS',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _notesController,
                            maxLines: 3,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Record your inner epiphanies, dreams, or outcomes here...',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5,
                                color: AppColors.textMuted,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                notifier.updateReadingNotes(reading.id, _notesController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Notes preserved in your sacred journal!'),
                                    backgroundColor: AppColors.cosmicSurface,
                                  ),
                                );
                              },
                              child: Text(
                                'SAVE REFLECTIONS',
                                style: GoogleFonts.cinzel(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldBright,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Connect with a real human intuitive reader
                    const LiveReaderCard(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Action Buttons
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldBright,
                      foregroundColor: AppColors.backgroundDeep,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onNewReading();
                    },
                    child: Text(
                      'DRAW AGAIN',
                      style: GoogleFonts.cinzel(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1, end: 0);
  }

  void _showReportAiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        String selectedReason = 'Inappropriate or harmful content';
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF140E26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.4)),
              ),
              title: Row(
                children: [
                  const Icon(Icons.flag, color: AppColors.goldBright, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'REPORT AI OUTPUT',
                    style: GoogleFonts.cinzel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Help maintain sacred sanctuary safety. Select why this AI-generated prophecy violates guidelines:',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...[
                    'Inappropriate or harmful content',
                    'Medical, financial, or legal claims',
                    'Offensive or discriminatory phrasing',
                    'Hallucinatory or incoherent text',
                  ].map((reason) {
                    final isSelected = selectedReason == reason;
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setDialogState(() => selectedReason = reason),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                              size: 18,
                              color: isSelected ? AppColors.goldBright : AppColors.textMuted,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                reason,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'CANCEL',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    foregroundColor: AppColors.backgroundDeep,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Thank you. This reading has been flagged for review.'),
                        backgroundColor: AppColors.cosmicSurface,
                      ),
                    );
                  },
                  child: Text(
                    'SUBMIT REPORT',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
