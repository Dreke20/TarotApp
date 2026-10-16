import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../domain/spread_type.dart';
import '../../domain/synastry_partner.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../../data/tarot_deck_service.dart';
import '../widgets/cosmic_synastry_modal.dart';
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
import '../../../monetization/presentation/monetization_notifier.dart';
import '../../../monetization/presentation/widgets/starlight_offering_modal.dart';
import '../../../altar/presentation/widgets/crystal_grid_overlay.dart';
import '../../../altar/presentation/widgets/smoke_purification_modal.dart';

/// The central Tarot Altar Table where cards are shuffled, drawn, flipped in 3D,
/// and synthesized by the AI Oracle with multi-deck themes, Celtic Cross, and astrological alignment.
class TarotTableScreen extends ConsumerStatefulWidget {
  final String? initialQuestion;
  final SpreadType? initialSpread;

  const TarotTableScreen({
    super.key,
    this.initialQuestion,
    this.initialSpread,
  });

  @override
  ConsumerState<TarotTableScreen> createState() => _TarotTableScreenState();
}

class _TarotTableScreenState extends ConsumerState<TarotTableScreen> {
  late final TextEditingController _questionController;

  final List<String> _quickPrompts = const [
    'What energy surrounds my path today?',
    'How do I overcome my current challenge?',
    'What blessings are unfolding in love?',
    'Where should I focus my creative willpower?',
    'What does the Celtic Cross reveal for my year ahead?',
  ];

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.initialQuestion ?? '');
    if (widget.initialSpread != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(readingNotifierProvider.notifier).setSpread(widget.initialSpread!);
      });
    }
  }

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
          onNewReading: () {
            ref.read(monetizationProvider.notifier).showPostReadingAdIfEligible(isPro: isPro);
            notifier.resetTable();
          },
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
                              final isProSpread = type != SpreadType.dailyGuidance &&
                                  type != SpreadType.threeFates;
                              if (!isPro && isProSpread) {
                                final monetization = ref.read(monetizationProvider);
                                if (monetization.hasStarlightPass) {
                                  ref.read(monetizationProvider.notifier).consumeStarlightPass();
                                  notifier.setSpreadType(type);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('✦ Starlight Pass consumed. Enjoy ${type.title}! ✦'),
                                      backgroundColor: AppColors.backgroundMidnight,
                                    ),
                                  );
                                } else {
                                  StarlightOfferingModal.show(
                                    context,
                                    requestedSpread: type,
                                    onUnlocked: () => notifier.setSpreadType(type),
                                  );
                                }
                              } else {
                                notifier.setSpreadType(type);
                              }
                            },
                          ),

                          // Cosmic Synastry & Relationship Mirror Configuration
                          if (state.spreadType == SpreadType.heartOfTwo) ...[
                            const SizedBox(height: 12),
                            _buildSynastryConfigCard(context, state, notifier),
                          ],

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
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 460),
      child: GlassContainer(
        width: double.infinity,
        borderRadius: 26,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.90),
        borderColor: AppColors.goldBright.withValues(alpha: 0.35),
        borderWidth: 1.2,
        shadows: [
          BoxShadow(
            color: AppColors.goldBright.withValues(alpha: 0.12),
            blurRadius: 28,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
        ],
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
        children: [
          // Consecration Status & Cardinal Guardian Crystal Grid
          const CrystalGridOverlay(),
          const SizedBox(height: 8),

          // If no cards are dealt yet: show Deck Pile on Altar
          if (!state.hasDrawnCards) ...[
            Text(
              '✦ THE SACRED DECK (${state.deckTheme.title.toUpperCase()}) ✦',
              style: GoogleFonts.cinzel(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Focus your intent, breathe deeply, and invite the sacred alignment',
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
                Container(
                  decoration: BoxDecoration(
                    gradient: state.isShuffling ? null : AppColors.goldButtonGradient,
                    color: state.isShuffling ? AppColors.goldMuted : null,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldMetallic.withValues(alpha: 0.35),
                        blurRadius: 18,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: const Color(0xFF09080C),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed:
                        state.isShuffling ? null : () => notifier.startReading(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('✦', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF09080C))),
                        const SizedBox(width: 8),
                        Text(
                          state.isShuffling ? 'SHUFFLING...' : 'CONSULT ORACLE',
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: const Color(0xFF09080C),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('✦', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF09080C))),
                      ],
                    ),
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
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.goldBright,
                    side: const BorderSide(color: AppColors.goldMuted, width: 1.2),
                    backgroundColor: AppColors.glassFill,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => SmokePurificationModal.show(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🪵', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        'PURIFY ALTAR',
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
                  onPressed: () {
                    final isPro = ref.read(isProUserProvider);
                    ref.read(monetizationProvider.notifier).showPostReadingAdIfEligible(isPro: isPro);
                    notifier.resetTable();
                  },
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
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.goldButtonGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldMetallic.withValues(alpha: 0.35),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color(0xFF09080C),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.auto_stories, size: 18, color: Color(0xFF09080C)),
                  label: Text(
                    '✦ VIEW ORACLE\'S PROPHECY ✦',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      color: const Color(0xFF09080C),
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
              ),
            ],
          ],
        ],
      ),
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

  Widget _buildSynastryConfigCard(
    BuildContext context,
    ReadingState state,
    ReadingNotifier notifier,
  ) {
    final partner = state.synastryPartner ?? const SynastryPartner();
    final profile = ref.watch(authNotifierProvider).profile;
    final seekerSun = profile?.zodiacSign ?? 'Scorpio';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1430).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldBright.withValues(alpha: 0.15),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('⚭', style: TextStyle(fontSize: 24, color: AppColors.goldBright)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COSMIC SYNASTRY MIRROR',
                  style: GoogleFonts.cinzel(
                    color: AppColors.goldBright,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You ($seekerSun) ⚭ ${partner.name} (${partner.sunSign}) • ${partner.connectionType}',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              CosmicSynastryModal.show(
                context,
                currentPartner: partner,
                seekerSunSign: seekerSun,
                onPartnerSaved: (updated) => notifier.setSynastryPartner(updated),
              );
            },
            child: Text(
              'CALIBRATE',
              style: GoogleFonts.cinzel(
                color: AppColors.goldBright,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
