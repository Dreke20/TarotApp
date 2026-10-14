import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../auth/presentation/profile_dialog.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../domain/altar_theme.dart';
import '../../domain/spread_type.dart';
import '../../domain/tarot_card.dart';
import '../../domain/tarot_deck_theme.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../../data/tarot_deck_service.dart';
import '../widgets/ambient_audio_button.dart';
import '../widgets/deck_pile_widget.dart';
import '../widgets/glass_container.dart';
import '../widgets/lunar_transit_banner.dart';
import '../widgets/manual_card_picker_dialog.dart';
import '../widgets/mystic_background.dart';
import '../widgets/reading_result_sheet.dart';
import '../widgets/spread_selector.dart';
import '../widgets/streak_badge.dart';
import '../widgets/tarot_card_widget.dart';
import 'readings_history_screen.dart';
import 'tarot_codex_screen.dart';

/// The central Tarot Altar Table where cards are shuffled, drawn, flipped in 3D,
/// and synthesized by the AI Oracle with multi-deck themes, Celtic Cross, and astrological alignment.
class TarotTableScreen extends ConsumerStatefulWidget {
  const TarotTableScreen({super.key});

  @override
  ConsumerState<TarotTableScreen> createState() => _TarotTableScreenState();
}

class _TarotTableScreenState extends ConsumerState<TarotTableScreen> {
  final TextEditingController _questionController = TextEditingController();

  final List<String> _quickPrompts = [
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
        child: Column(
          children: [
            // Header Bar
            _buildHeader(context, state, isPro),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Real-Time Lunar Transit & Cosmic Timing
                    const LunarTransitBanner(),

                    // Spread Selector (Daily, Three Fates, Celtic Cross, Love, Career, Shadow)
                    SpreadSelector(
                      selectedSpread: state.spreadType,
                      onSpreadChanged: (type) {
                        if (!isPro && type != SpreadType.dailyGuidance && type != SpreadType.threeFates) {
                          OracleProModal.show(context);
                        } else {
                          notifier.setSpreadType(type);
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    // Question Input with Glassmorphic styling
                    _buildQuestionInput(notifier, state),

                    const SizedBox(height: 18),

                    // Altar Table
                    _buildAltarTable(context, state, notifier),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ReadingState state, bool isPro) {
    final authProfile = ref.watch(authNotifierProvider).profile;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => ProfileDialog.show(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [AppColors.goldBright, AppColors.cosmicSurface],
                    ),
                    border: Border.all(color: AppColors.goldBright, width: 1.2),
                  ),
                  child: Center(
                    child: Text(
                      authProfile?.zodiacSign?.substring(0, 2).toUpperCase() ?? '★',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundDeep,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ORACULUM',
                        style: GoogleFonts.cinzel(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 2.2,
                        ),
                      ),
                      if (isPro) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.goldBright,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PRO',
                            style: GoogleFonts.cinzel(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: AppColors.backgroundDeep,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    authProfile?.zodiacSign != null
                        ? 'ALIGNED WITH ${authProfile!.zodiacSign!.toUpperCase()}'
                        : 'AI TAROT SANCTUARY',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.etherealLavender,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Action Toolbar: Themes, Pro, Journal
          Row(
            children: [
              // Theme Switcher Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.palette_outlined, color: AppColors.goldBright, size: 20),
                color: AppColors.backgroundMidnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                onSelected: (value) {
                  final notifier = ref.read(readingNotifierProvider.notifier);
                  if (value.startsWith('deck:')) {
                    final themeId = value.replaceFirst('deck:', '');
                    final theme = TarotDeckTheme.values.firstWhere((t) => t.id == themeId);
                    notifier.setDeckTheme(theme);
                  } else if (value.startsWith('altar:')) {
                    final themeId = value.replaceFirst('altar:', '');
                    final theme = AltarTheme.values.firstWhere((t) => t.id == themeId);
                    notifier.setAltarTheme(theme);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'CARD DECKS',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                  ...TarotDeckTheme.values.map((t) => PopupMenuItem(
                        value: 'deck:${t.id}',
                        child: Text(
                          t.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: state.deckTheme == t
                                ? AppColors.goldBright
                                : AppColors.textPrimary,
                          ),
                        ),
                      )),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'ALTAR THEMES',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                  ...AltarTheme.values.map((a) => PopupMenuItem(
                        value: 'altar:${a.id}',
                        child: Text(
                          a.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: state.altarTheme == a
                                ? AppColors.goldBright
                                : AppColors.textPrimary,
                          ),
                        ),
                      )),
                ],
              ),

              // Daily Habit Streak Badge
              const StreakBadge(),
              const SizedBox(width: 6),

              // Ambient Meditative Soundscape Button
              const AmbientAudioButton(),
              const SizedBox(width: 6),

              // Sacred Tarot Codex Action Button
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                borderRadius: 14,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TarotCodexScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.style_outlined,
                      size: 15,
                      color: AppColors.goldBright,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'CODEX',
                      style: GoogleFonts.cinzel(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Sacred Journal Action Button
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                borderRadius: 14,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ReadingsHistoryScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_stories,
                      size: 15,
                      color: AppColors.goldBright,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'JOURNAL',
                      style: GoogleFonts.cinzel(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(ReadingNotifier notifier, ReadingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          borderRadius: 18,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              const Icon(
                Icons.psychology,
                color: AppColors.etherealLavender,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _questionController,
                  onChanged: (val) => notifier.setQuestion(val),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What guidance do you seek from the cosmos?',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (_questionController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, size: 16, color: AppColors.textMuted),
                  onPressed: () {
                    _questionController.clear();
                    notifier.setQuestion('');
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Quick prompt suggestions
        SizedBox(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _quickPrompts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final prompt = _quickPrompts[index];
              return GestureDetector(
                onTap: () {
                  _questionController.text = prompt;
                  notifier.setQuestion(prompt);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.glassBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    prompt,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: AppColors.goldBright.withValues(alpha: 0.4),
                  ),
                  onPressed: state.isShuffling ? null : () => notifier.startReading(),
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
                    side: const BorderSide(color: AppColors.goldMuted, width: 1.2),
                    backgroundColor: AppColors.glassFill,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
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
                  icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
                  onPressed: () => notifier.resetTable(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Cards Spread Display (Daily, Three Fates, or Celtic Cross)
            _buildSpreadLayout(state, notifier),

            const SizedBox(height: 18),

            // Oracle Consulting Loading Indicator or Action Row
            if (state.isConsultingOracle) ...[
              _buildOracleChannelingView(),
            ] else if (!state.allCardsRevealed) ...[
              TextButton.icon(
                icon: const Icon(Icons.visibility, size: 16, color: AppColors.goldBright),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  Widget _buildSpreadLayout(ReadingState state, ReadingNotifier notifier) {
    final List<TarotCard> drawnCards = state.drawnCards;
    final Set<int> revealed = state.revealedIndices;

    if (state.spreadType == SpreadType.dailyGuidance) {
      final card = drawnCards.first;
      final isFlipped = revealed.contains(0);

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.glassFillStrong,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              'TODAY\'S GUIDANCE',
              style: GoogleFonts.cinzel(
                fontSize: 10,
                color: AppColors.goldBright,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TarotCardWidget(
            card: card,
            isFaceUp: isFlipped,
            width: 140,
            height: 230,
            index: 0,
            deckTheme: state.deckTheme,
            onTap: () => notifier.flipCard(0),
          ),
        ],
      );
    } else if (state.spreadType == SpreadType.threeFates) {
      // The Three Fates Spread
      return SizedBox(
        height: 250,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: drawnCards.length,
          separatorBuilder: (_, _) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final card = drawnCards[index];
            final isFlipped = revealed.contains(index);

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.glassFillStrong,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Text(
                    index == 0
                        ? 'I. PAST'
                        : index == 1
                            ? 'II. PRESENT'
                            : 'III. FUTURE',
                    style: GoogleFonts.cinzel(
                      fontSize: 9,
                      color: AppColors.goldBright,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TarotCardWidget(
                  card: card,
                  isFaceUp: isFlipped,
                  width: 95,
                  height: 165,
                  index: index,
                  deckTheme: state.deckTheme,
                  onTap: () => notifier.flipCard(index),
                ),
              ],
            );
          },
        ),
      );
    } else {
      // --- THE CELTIC CROSS SPREAD (10 Cards) ---
      return Column(
        children: [
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: drawnCards.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final card = drawnCards[index];
                final isFlipped = revealed.contains(index);
                final isInspected = state.selectedInspectIndex == index;

                return GestureDetector(
                  onTap: () {
                    notifier.selectInspectIndex(index);
                    notifier.flipCard(index);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: isInspected
                              ? AppColors.goldBright
                              : AppColors.glassFillStrong,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isInspected
                                ? AppColors.goldBright
                                : AppColors.glassBorder,
                          ),
                        ),
                        child: Text(
                          '${index + 1}. ${_shortPositionName(state.spreadType, index)}',
                          style: GoogleFonts.cinzel(
                            fontSize: 8.5,
                            color: isInspected
                                ? AppColors.backgroundDeep
                                : AppColors.goldBright,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TarotCardWidget(
                        card: card,
                        isFaceUp: isFlipped,
                        width: 90,
                        height: 155,
                        index: index,
                        isSelected: isInspected,
                        deckTheme: state.deckTheme,
                        onTap: () => notifier.flipCard(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Active Card Inspector Pill
          if (state.selectedInspectIndex != null &&
              state.selectedInspectIndex! < drawnCards.length) ...[
            const SizedBox(height: 12),
            _buildInspectorPill(drawnCards[state.selectedInspectIndex!], state),
          ],
        ],
      );
    }
  }

  String _shortPositionName(SpreadType spread, int index) {
    if (spread == SpreadType.celticCross) {
      const names = [
        'Present', 'Cross', 'Root', 'Past', 'Crown',
        'Future', 'Self', 'World', 'Hopes', 'Outcome'
      ];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.heartOfTwo) {
      const names = ['You', 'Them', 'Nexus', 'Lesson', 'Horizon'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.careerCrossroads) {
      const names = ['Station', 'Leverage', 'Obstacle', 'Action', 'Peak'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    } else if (spread == SpreadType.shadowMirror) {
      const names = ['Persona', 'Shadow', 'Wound', 'Gateway'];
      return index < names.length ? names[index] : 'Card ${index + 1}';
    }
    return 'Card ${index + 1}';
  }

  Widget _buildInspectorPill(TarotCard card, ReadingState state) {
    final isFlipped = state.revealedIndices.contains(state.selectedInspectIndex);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cosmicSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            isFlipped ? Icons.auto_awesome : Icons.lock_outline,
            color: AppColors.goldBright,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.positionName ?? 'Card Position',
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
                Text(
                  isFlipped
                      ? '${card.name} (${card.isReversed ? "Reversed" : "Upright"}) — ${card.keywords.take(2).join(", ")}'
                      : 'Tap to unveil this position\'s message',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOracleChannelingView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cosmicSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.etherealLavender.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldBright),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'CHANNELING THE STARS...',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'The Oracle is connecting with Vertex AI to weave your reading',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).shimmer(duration: 1500.ms);
  }
}
