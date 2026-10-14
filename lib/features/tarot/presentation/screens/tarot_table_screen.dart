import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../domain/spread_type.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../../data/tarot_deck_service.dart';
import '../widgets/deck_pile_widget.dart';
import '../widgets/glass_container.dart';
import '../widgets/lunar_transit_banner.dart';
import '../widgets/manual_card_picker_dialog.dart';
import '../widgets/mystic_background.dart';
import '../widgets/oracle_channeling_view.dart';
import '../widgets/oracle_question_bar.dart';
import '../widgets/reading_result_sheet.dart';
import '../widgets/spread_board_view.dart';
import '../widgets/spread_selector.dart';
import '../widgets/tarot_header_bar.dart';
import '../widgets/sacred_mystic_dock.dart';
import '../../../astrology/presentation/screens/natal_chart_screen.dart';
import '../../../collective/presentation/screens/collective_sanctuary_screen.dart';
import '../../../divination/presentation/screens/iching_screen.dart';
import '../../../divination/presentation/screens/rune_casting_screen.dart';
import '../../../dream/presentation/screens/dream_journal_screen.dart';
import '../../../lens/presentation/screens/tarot_lens_screen.dart';

/// The central Tarot Altar Table where cards are shuffled, drawn, flipped in 3D,
/// and synthesized by the AI Oracle with multi-deck themes, Celtic Cross, and astrological alignment.
class TarotTableScreen extends ConsumerStatefulWidget {
  const TarotTableScreen({super.key});

  @override
  ConsumerState<TarotTableScreen> createState() => _TarotTableScreenState();
}

class _TarotTableScreenState extends ConsumerState<TarotTableScreen> {
  final TextEditingController _questionController = TextEditingController();

  final List<String> _quickPrompts = const [
    'What energy surrounds my path today?',
    'How do I overcome my current challenge?',
    'What blessings are unfolding in love?',
    'Where should I focus my creative willpower?',
    'What does the Celtic Cross reveal for my year ahead?',
  ];

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readingNotifierProvider);
    final notifier = ref.read(readingNotifierProvider.notifier);
    final isPro = ref.watch(isProUserProvider);

    // Listen to oracle completion to open the result sheet
    ref.listen(readingNotifierProvider, (previous, current) {
      if (previous?.isConsultingOracle == true &&
          !current.isConsultingOracle &&
          current.currentReading != null) {
        ReadingResultSheet.show(
          context,
          reading: current.currentReading!,
          onNewReading: () => notifier.resetTable(),
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MysticBackground(
        altarTheme: state.altarTheme,
        child: SafeArea(
          child: Column(
            children: [
              // Constrained Centered Header Bar
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1040),
                  child: TarotHeaderBar(state: state, isPro: isPro),
                ),
              ),

              // Main Content Area (Centered & Proportioned)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1040),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),

                          // Real-Time Lunar Transit & Cosmic Timing
                          const LunarTransitBanner(),

                          // Spread Selector
                          SpreadSelector(
                            selectedSpread: state.spreadType,
                            onSpreadChanged: (type) {
                              if (!isPro &&
                                  type != SpreadType.dailyGuidance &&
                                  type != SpreadType.threeFates) {
                                OracleProModal.show(context);
                              } else {
                                notifier.setSpreadType(type);
                              }
                            },
                          ),

                          const SizedBox(height: 14),

                          // Question Input with prompt chips & voice invocation
                          OracleQuestionBar(
                            controller: _questionController,
                            notifier: notifier,
                            quickPrompts: _quickPrompts,
                          ),

                          const SizedBox(height: 18),

                          // Altar Table
                          _buildAltarTable(context, state, notifier),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Sacred Mystic Bottom Dock
              const SacredMysticDock(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAltarTable(
    BuildContext context,
    ReadingState state,
    ReadingNotifier notifier,
  ) {
    return GlassContainer(
      width: double.infinity,
      borderRadius: 26,
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.7),
      borderColor: AppColors.glassBorder,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
          // If no cards are dealt yet: show Deck Pile on Altar
          if (!state.hasDrawnCards) ...[
            Text(
              'THE SACRED DECK (${state.deckTheme.title.toUpperCase()})',
              style: GoogleFonts.cinzel(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Focus your intent, breathe deeply, and invite cosmic guidance',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 22),

            // Deck Pile Widget
            DeckPileWidget(
              isShuffling: state.isShuffling,
              onTap: () => notifier.startReading(),
            ),

            const SizedBox(height: 26),

            // Action Buttons: Automated Shuffle vs Manual Ritual Draw
            Wrap(
              spacing: 12,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    foregroundColor: AppColors.backgroundDeep,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: AppColors.goldBright.withValues(alpha: 0.4),
                  ),
                  onPressed:
                      state.isShuffling ? null : () => notifier.startReading(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        state.isShuffling ? 'SHUFFLING...' : 'CONSULT ORACLE',
                        style: GoogleFonts.cinzel(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.goldBright,
                    side:
                        const BorderSide(color: AppColors.goldMuted, width: 1.2),
                    backgroundColor: AppColors.glassFill,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: state.isShuffling
                      ? null
                      : () {
                          ManualCardPickerDialog.show(
                            context,
                            spreadType: state.spreadType,
                            fullDeck: TarotDeckService().shuffleDeck(),
                            onCardsSelected: (chosen) {
                              notifier.setManualDrawnCards(chosen);
                            },
                          );
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.style, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'CUT THE DECK',
                        style: GoogleFonts.cinzel(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),
            const Divider(color: AppColors.glassBorder, height: 1),
            const SizedBox(height: 14),

            Text(
              'SACRED ORACLE SANCTUARIES',
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.etherealLavender,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildQuickPortalChip(
                    context,
                    glyph: 'ᚦ',
                    title: 'Elder Runes',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RuneCastingScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuickPortalChip(
                    context,
                    glyph: '☯',
                    title: 'I Ching',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const IChingScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuickPortalChip(
                    context,
                    glyph: '🌙',
                    title: 'Dream Journal',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DreamJournalScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuickPortalChip(
                    context,
                    glyph: '🪐',
                    title: 'Natal Chart',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NatalChartScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuickPortalChip(
                    context,
                    glyph: '✨',
                    title: 'Collective Pulse',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CollectiveSanctuaryScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuickPortalChip(
                    context,
                    glyph: '🔍',
                    title: 'Tarot Lens',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TarotLensScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Cards are dealt on the table
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.spreadType.title.toUpperCase(),
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      state.allCardsRevealed
                          ? 'All cards revealed'
                          : 'Tap cards to unveil destiny',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.etherealLavender,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  tooltip: 'Reset Table',
                  icon:
                      const Icon(Icons.refresh, color: AppColors.textSecondary),
                  onPressed: () => notifier.resetTable(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Spread Layout (Daily, Three Fates, Celtic Cross, etc.)
            SpreadBoardView(state: state, notifier: notifier),

            const SizedBox(height: 18),

            // Oracle Consulting Loading Indicator or Action Row
            if (state.isConsultingOracle) ...[
              const OracleChannelingView(),
            ] else if (!state.allCardsRevealed) ...[
              TextButton.icon(
                icon: const Icon(Icons.visibility,
                    size: 16, color: AppColors.goldBright),
                label: Text(
                  'REVEAL ALL CARDS',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 1.2,
                  ),
                ),
                onPressed: () => notifier.revealAllCards(),
              ),
            ] else if (state.currentReading != null) ...[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright,
                  foregroundColor: AppColors.backgroundDeep,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.auto_stories, size: 18),
                label: Text(
                  'VIEW ORACLE\'S PROPHECY',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                onPressed: () {
                  ReadingResultSheet.show(
                    context,
                    reading: state.currentReading!,
                    onNewReading: () => notifier.resetTable(),
                  );
                },
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildQuickPortalChip(
    BuildContext context, {
    required String glyph,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.glassFillStrong,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(glyph, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
