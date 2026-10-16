import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/biometric_vault_service.dart';
import '../../../../core/widgets/biometric_gate_barrier.dart';
import '../../domain/reading.dart';
import '../notifiers/reading_notifier.dart';
import '../widgets/glass_container.dart';
import '../widgets/mystic_background.dart';
import '../widgets/reading_result_sheet.dart';
import '../../../monetization/presentation/widgets/mystic_ad_banner.dart';

/// Screen listing past tarot readings retrieved from Supabase with search and favorite filters.
class ReadingsHistoryScreen extends ConsumerStatefulWidget {
  const ReadingsHistoryScreen({super.key});

  @override
  ConsumerState<ReadingsHistoryScreen> createState() =>
      _ReadingsHistoryScreenState();
}

class _ReadingsHistoryScreenState extends ConsumerState<ReadingsHistoryScreen> {
  bool _onlyFavorites = false;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readingNotifierProvider);
    final notifier = ref.read(readingNotifierProvider.notifier);

    // Apply filtering
    final filteredHistory = state.history.where((r) {
      if (_onlyFavorites && !r.isFavorite) return false;
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesQuestion = r.question.toLowerCase().contains(q);
        final matchesCards =
            r.cards.any((c) => c.name.toLowerCase().contains(q));
        final matchesNotes = r.notes.toLowerCase().contains(q);
        if (!matchesQuestion && !matchesCards && !matchesNotes) return false;
      }
      return true;
    }).toList();

    return BiometricGateBarrier(
      title: 'SANCTUARY VAULT LOCKED',
      subtitle: 'Scan your biometric fingerprint or face to unseal past readings.',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppColors.goldBright),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'SACRED JOURNAL',
            style: GoogleFonts.cinzel(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
          actions: [
            Consumer(
              builder: (context, ref, _) {
                final vaultState = ref.watch(biometricVaultProvider);
                final isEnabled = vaultState.value ?? false;
                return IconButton(
                  icon: Icon(
                    isEnabled ? Icons.fingerprint : Icons.lock_outline,
                    color: isEnabled ? AppColors.goldBright : AppColors.goldMuted,
                  ),
                  tooltip: isEnabled ? 'Biometric Vault Consecrated' : 'Enable Biometric Vault',
                  onPressed: () async {
                    await ref.read(biometricVaultProvider.notifier).toggleVault(!isEnabled);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            !isEnabled
                                ? 'Biometric Altar Vault consecrated.'
                                : 'Biometric Altar Vault disengaged.',
                            style: GoogleFonts.plusJakartaSans(),
                          ),
                          backgroundColor: AppColors.backgroundMidnight,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      body: MysticBackground(
        altarTheme: state.altarTheme,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
          children: [
            const SizedBox(height: 100),

            // Search Bar & Favorites Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.glassFillStrong,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search,
                              size: 18, color: AppColors.textMuted),
                          hintText: 'Search inquiries, cards, notes...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _onlyFavorites = !_onlyFavorites),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 11),
                      decoration: BoxDecoration(
                        color: _onlyFavorites
                            ? AppColors.goldBright.withValues(alpha: 0.2)
                            : AppColors.glassFill,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _onlyFavorites
                              ? AppColors.goldBright
                              : AppColors.glassBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _onlyFavorites ? Icons.star : Icons.star_border,
                            size: 16,
                            color: _onlyFavorites
                                ? AppColors.goldBright
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'STARRED',
                            style: GoogleFonts.cinzel(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: _onlyFavorites
                                  ? AppColors.goldBright
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // AI Archetypal Pattern Insights
            _buildArchetypalPatternCard(state.history),

            // Journal List
            Expanded(
              child: filteredHistory.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredHistory.length,
                      itemBuilder: (context, index) {
                        final reading = filteredHistory[index];
                        return _buildHistoryCard(context, reading, notifier);
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
  ),
);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cosmicSurface.withValues(alpha: 0.5),
                border: Border.all(
                  color: AppColors.goldMuted.withValues(alpha: 0.4),
                ),
              ),
              child: const Icon(
                Icons.auto_stories,
                color: AppColors.goldBright,
                size: 36,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              _onlyFavorites
                  ? 'No Starred Readings'
                  : 'No Readings Found',
              style: GoogleFonts.cinzel(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _onlyFavorites
                  ? 'Star your most profound readings to view them here.'
                  : 'Consult the Oracle on the altar to receive sacred prophecies.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    Reading reading,
    ReadingNotifier notifier,
  ) {
    final dateFormat = DateFormat('MMM d, y • h:mm a');

    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      borderRadius: 18,
      onTap: () {
        ReadingResultSheet.show(
          context,
          reading: reading,
          onNewReading: () => notifier.resetTable(),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date, Spread Badge & Favorite Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat.format(reading.createdAt.toLocal()),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.etherealLavender
                            .withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      reading.spreadType == 'celtic_cross'
                          ? 'The Celtic Cross'
                          : reading.spreadType == 'three_fates'
                              ? 'The Three Fates'
                              : 'Daily Guidance',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => notifier.toggleFavorite(
                        reading.id, !reading.isFavorite),
                    child: Icon(
                      reading.isFavorite ? Icons.star : Icons.star_border,
                      size: 18,
                      color: reading.isFavorite
                          ? AppColors.goldBright
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Question
          Text(
            reading.question,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Cards drawn badges
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: reading.cards.map((card) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      AppColors.backgroundMidnight.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.glassBorder,
                  ),
                ),
                child: Text(
                  '${card.name}${card.isReversed ? " (Rev)" : ""}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.5,
                    color: AppColors.etherealLavender,
                  ),
                ),
              );
            }).toList(),
          ),

          if (reading.summary != null) ...[
            const SizedBox(height: 10),
            Text(
              reading.summary!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ],

          if (reading.notes.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.goldBright.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: AppColors.goldBright.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit_note,
                      size: 14, color: AppColors.goldBright),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      reading.notes,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildArchetypalPatternCard(List<Reading> history) {
    if (history.isEmpty) return const SizedBox.shrink();

    final cardCounts = <String, int>{};
    final elementCounts = <String, int>{'Fire': 0, 'Water': 0, 'Air': 0, 'Earth': 0};

    for (final reading in history) {
      for (final card in reading.cards) {
        cardCounts[card.name] = (cardCounts[card.name] ?? 0) + 1;
        if (card.element != null && elementCounts.containsKey(card.element)) {
          elementCounts[card.element!] = (elementCounts[card.element!] ?? 0) + 1;
        }
      }
    }

    final topCards = cardCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final mostFrequent = topCards.isNotEmpty ? topCards.first.key : 'None';
    final topElement = elementCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final dominantElement = topElement.first.key;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, size: 16, color: AppColors.goldBright),
              const SizedBox(width: 8),
              Text(
                'AI ARCHETYPAL PATTERNS',
                style: GoogleFonts.cinzel(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                '${history.length} READINGS',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GUIDING ARCHETYPE',
                        style: GoogleFonts.cinzel(fontSize: 8.5, color: AppColors.textSecondary),
                      ),
                      Text(
                        mostFrequent,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DOMINANT ELEMENT',
                        style: GoogleFonts.cinzel(fontSize: 8.5, color: AppColors.textSecondary),
                      ),
                      Text(
                        dominantElement.toUpperCase(),
                        style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
