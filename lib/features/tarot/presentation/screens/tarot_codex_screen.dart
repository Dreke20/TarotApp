import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/celestial_voice_service.dart';
import '../../data/tarot_card_data.dart';
import '../../domain/tarot_card.dart';
import '../notifiers/reading_notifier.dart';
import '../widgets/glass_container.dart';
import '../widgets/tarot_card_widget.dart';
import '../notifiers/oracle_persona_notifier.dart';
import '../widgets/deck_switcher_modal.dart';
import '../../../wallpaper/presentation/screens/wallpaper_studio_screen.dart';
import '../../../monetization/presentation/widgets/mystic_ad_banner.dart';

/// The Sacred Tarot Codex: Interactive Compendium & Gallery of all 78 Cards
class TarotCodexScreen extends ConsumerStatefulWidget {
  const TarotCodexScreen({super.key});

  @override
  ConsumerState<TarotCodexScreen> createState() => _TarotCodexScreenState();
}

class _TarotCodexScreenState extends ConsumerState<TarotCodexScreen> {
  String _filterArcana = 'major'; // 'major', 'minor', 'all'
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TarotCard> _getFilteredCards() {
    return TarotCardData.allCards.where((card) {
      final matchesArcana = _filterArcana == 'all' || card.arcana == _filterArcana;
      final matchesSearch = _searchQuery.isEmpty ||
          card.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (card.keywords.any((k) => k.toLowerCase().contains(_searchQuery.toLowerCase()))) ||
          (card.element?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      return matchesArcana && matchesSearch;
    }).toList();
  }

  void _showCardInspection(TarotCard card) {
    final state = ref.read(readingNotifierProvider);

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480, maxHeight: 680),
            child: GlassContainer(
              padding: const EdgeInsets.all(22),
              borderRadius: 24,
              fillColor: AppColors.cosmicSurface.withValues(alpha: 0.92),
              borderColor: AppColors.goldBright.withValues(alpha: 0.6),
              child: Column(
                children: [
                  // Header with Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'SACRED CODEX ENTRY',
                            style: GoogleFonts.cinzel(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Scrollable Body
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // Card Artwork Feature
                          Center(
                            child: Hero(
                              tag: 'codex_card_${card.id}',
                              child: TarotCardWidget(
                                card: card,
                                isFaceUp: true,
                                width: 170,
                                height: 260,
                                index: 0,
                                isSelected: true,
                                deckTheme: state.deckTheme,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Card Name & Subtitle
                          Text(
                            card.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Badges Row (Element & Astrology)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (card.element != null) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFillStrong,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.goldMuted.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.filter_vintage, size: 12, color: AppColors.goldBright),
                                      const SizedBox(width: 5),
                                      Text(
                                        card.element!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (card.astrology != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.glassFillStrong,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.etherealLavender.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.brightness_2, size: 12, color: AppColors.etherealLavender),
                                      const SizedBox(width: 5),
                                      Text(
                                        card.astrology!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.etherealLavender,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Keywords
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: card.keywords.map((kw) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                                decoration: BoxDecoration(
                                  color: AppColors.glassFill,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.glassBorder,
                                  ),
                                ),
                                child: Text(
                                  kw,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 18),

                          // Spoken Card Wisdom Bar
                          StatefulBuilder(
                            builder: (context, setModalState) {
                              final voice = CelestialVoiceService.instance;
                              final isSpeaking = voice.isPlaying;
                              final activePersona = ref.watch(oraclePersonaNotifierProvider);
                              return GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  if (voice.isPlaying) {
                                    await voice.stop();
                                    setModalState(() {});
                                  } else {
                                    voice.onStarted = () {
                                      if (context.mounted) setModalState(() {});
                                    };
                                    voice.onStopped = () {
                                      if (context.mounted) setModalState(() {});
                                    };
                                    final text =
                                        '${card.name}. Arcana: ${card.arcana}. Element: ${card.element ?? "Cosmic"}. Upright wisdom: ${card.meaningUpright}. Inverted wisdom: ${card.meaningReversed}.';
                                    await voice.speak(text, persona: activePersona);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSpeaking
                                        ? activePersona.accentColor.withValues(alpha: 0.18)
                                        : AppColors.glassFillStrong,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSpeaking
                                          ? activePersona.accentColor
                                          : AppColors.goldMuted.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isSpeaking
                                            ? Icons.volume_up
                                            : Icons.record_voice_over,
                                        color: isSpeaking
                                            ? activePersona.accentColor
                                            : AppColors.textSecondary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isSpeaking
                                            ? 'CHANNELING (${activePersona.name})...'
                                            : 'SPEAK WISDOM (${activePersona.name})',
                                        style: GoogleFonts.cinzel(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.bold,
                                          color: isSpeaking
                                              ? activePersona.accentColor
                                              : AppColors.textPrimary,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 14),

                          // Upright Meaning Section
                          _buildMeaningBlock(
                            title: 'UPRIGHT PROPHECY',
                            icon: Icons.arrow_upward,
                            iconColor: AppColors.goldBright,
                            content: card.meaningUpright,
                          ),
                          const SizedBox(height: 12),

                          // Reversed Meaning Section
                          _buildMeaningBlock(
                            title: 'REVERSED PROPHECY',
                            icon: Icons.arrow_downward,
                            iconColor: const Color(0xFFFF8B8B),
                            content: card.meaningReversed,
                          ),
                          const SizedBox(height: 14),

                          // Wallpaper Forge Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                                WallpaperStudioScreen.show(context, card: card);
                              },
                              icon: const Icon(Icons.wallpaper, color: AppColors.goldBright, size: 16),
                              label: Text(
                                'FORGE SACRED 4K WALLPAPER',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldBright,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.5)),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() => CelestialVoiceService.instance.stop());
  }

  Widget _buildMeaningBlock({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glassFillStrong,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              height: 1.5,
              color: AppColors.textPrimary.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCards = _getFilteredCards();
    final state = ref.watch(readingNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Gradient matching active altar
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: state.altarTheme.backgroundGradient,
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Column(
                  children: [
                    // Header Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.goldBright, size: 18),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SACRED TAROT CODEX',
                              style: GoogleFonts.cinzel(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              'Explore the 78 Arcana Archetypes & Artwork',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Deck Sanctuary',
                        icon: const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 20),
                        onPressed: () => DeckSwitcherModal.show(context),
                      ),
                      IconButton(
                        tooltip: 'Wallpaper Studio',
                        icon: const Icon(Icons.wallpaper, color: AppColors.goldBright, size: 20),
                        onPressed: () => WallpaperStudioScreen.show(context),
                      ),
                    ],
                  ),
                ),

                // Search Bar & Filter Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    borderRadius: 14,
                    fillColor: AppColors.cosmicSurface.withValues(alpha: 0.6),
                    borderColor: AppColors.glassBorder,
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontSize: 13),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search, color: AppColors.goldBright, size: 20),
                        hintText: 'Search card by archetype, keyword, or element...',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                          fontSize: 12.5,
                        ),
                        border: InputBorder.none,
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 16, color: AppColors.textSecondary),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                      ),
                      onChanged: (val) {
                        setState(() => _searchQuery = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Arcana Filter Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      _buildFilterTab('Major Arcana (22)', 'major'),
                      const SizedBox(width: 8),
                      _buildFilterTab('Minor Arcana (56)', 'minor'),
                      const SizedBox(width: 8),
                      _buildFilterTab('Full Deck (78)', 'all'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Cards Grid
                Expanded(
                  child: filteredCards.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.search_off, size: 48, color: AppColors.goldMuted),
                              const SizedBox(height: 12),
                              Text(
                                'No sacred archetypes match your query',
                                style: GoogleFonts.cinzel(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 140,
                            childAspectRatio: 0.62,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: filteredCards.length,
                          itemBuilder: (context, index) {
                            final card = filteredCards[index];
                            return GestureDetector(
                              onTap: () => _showCardInspection(card),
                              child: Hero(
                                tag: 'codex_card_${card.id}',
                                child: TarotCardWidget(
                                  card: card,
                                  isFaceUp: true,
                                  width: 120,
                                  height: 180,
                                  index: index % 6,
                                  deckTheme: state.deckTheme,
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // Balanced AdMob Sanctuary Banner (hides for Pro users)
                const MysticAdBanner(),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);
}

  Widget _buildFilterTab(String label, String value) {
    final isSelected = _filterArcana == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _filterArcana = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.goldBright.withValues(alpha: 0.2)
                : AppColors.glassFillStrong,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
              width: isSelected ? 1.4 : 1.0,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
