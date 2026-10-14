import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/reading.dart';
import '../notifiers/reading_notifier.dart';
import 'glass_container.dart';
import 'social_share_card.dart';
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
  }

  @override
  void dispose() {
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
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: AppColors.goldBright,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ORACLE\'S PROPHECY',
                      style: GoogleFonts.cinzel(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
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
                      onTap: () {
                        setState(() => _isPlayingNarration = !_isPlayingNarration);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isPlayingNarration
                              ? AppColors.goldBright.withValues(alpha: 0.15)
                              : AppColors.glassFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isPlayingNarration
                                ? AppColors.goldBright
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _isPlayingNarration ? Icons.volume_up : Icons.volume_mute,
                              color: _isPlayingNarration ? AppColors.goldBright : AppColors.textSecondary,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _isPlayingNarration ? 'NARRATING PROPHECY...' : 'LISTEN TO CELESTIAL NARRATION',
                              style: GoogleFonts.cinzel(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: _isPlayingNarration ? AppColors.goldBright : AppColors.textPrimary,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const Spacer(),
                            if (_isPlayingNarration)
                              const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(AppColors.goldBright),
                                ),
                              ),
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
                    const SizedBox(height: 24),
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
}
