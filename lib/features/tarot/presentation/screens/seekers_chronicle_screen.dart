import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../data/tarot_repository.dart';
import '../notifiers/reading_notifier.dart';
import '../widgets/glass_container.dart';

/// The Seeker's Chronicle:
/// Multi-chapter AI Destiny synthesis analyzing readings across 7-day and 30-day cycles.
class SeekersChronicleScreen extends ConsumerStatefulWidget {
  const SeekersChronicleScreen({super.key});

  @override
  ConsumerState<SeekersChronicleScreen> createState() => _SeekersChronicleScreenState();
}

class _SeekersChronicleScreenState extends ConsumerState<SeekersChronicleScreen> {
  int _selectedDays = 7;

  @override
  Widget build(BuildContext context) {
    final readingState = ref.watch(readingNotifierProvider);
    final authProfile = ref.watch(authNotifierProvider).profile;
    final repository = ref.read(tarotRepositoryProvider);

    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: _selectedDays));
    final filteredReadings = readingState.history
        .where((r) => r.createdAt.isAfter(cutoff))
        .toList();

    final chronicle = repository.synthesizeChronicle(
      days: _selectedDays,
      readings: filteredReadings,
      seekerSun: authProfile?.zodiacSign,
    );

    final dominantElement = chronicle['dominant_element']?.toString() ?? '';

    return Scaffold(
      backgroundColor: AppColors.backgroundMidnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "THE SEEKER'S CHRONICLE",
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.goldBright, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Copy Chronicle',
            icon: const Icon(Icons.share, color: AppColors.goldBright, size: 20),
            onPressed: () {
              final text = '${chronicle['title']}\n\n${chronicle['chapter']}\n\n'
                  'Breakthrough Insight: ${chronicle['breakthrough_insight']}\n\n'
                  'Trajectory: ${chronicle['trajectory']}';
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chronicle prophecy copied to clipboard!'),
                  backgroundColor: AppColors.backgroundMidnight,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cycle Duration Selector (7-Day vs 30-Day)
            Row(
              children: [
                Expanded(
                  child: _buildCycleTab(
                    title: '7-DAY CRUCIBLE',
                    subtitle: 'Weekly Lunar Rhythm',
                    isSelected: _selectedDays == 7,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedDays = 7);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCycleTab(
                    title: '30-DAY SOLSTICE',
                    subtitle: 'Monthly Destiny Epoch',
                    isSelected: _selectedDays == 30,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedDays = 30);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Metrics Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildMetricBadge(
                    label: 'SACRED SPREADS',
                    value: '${chronicle['total_readings'] ?? 0}',
                    icon: Icons.auto_stories,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricBadge(
                    label: 'ARCHETYPES',
                    value: '${chronicle['total_cards'] ?? 0}',
                    icon: Icons.style,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricBadge(
                    label: 'STALKER CARD',
                    value: chronicle['guiding_archetype'] ?? 'None',
                    icon: Icons.flare,
                    isSmallText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Elemental Dignity Matrix Breakdown
            if (dominantElement.isNotEmpty) ...[
              Text(
                'ELEMENTAL DIGNITY MATRIX',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              GlassContainer(
                padding: const EdgeInsets.all(14),
                borderRadius: 16,
                fillColor: AppColors.glassFillStrong,
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 16, color: AppColors.goldBright),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dominantElement,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
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

            // Chapter Prophecy Manuscript Container
            Text(
              'PROPHECY MANUSCRIPT',
              style: GoogleFonts.cinzel(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            GlassContainer(
              padding: const EdgeInsets.all(18),
              borderRadius: 20,
              fillColor: AppColors.glassFillStrong,
              borderColor: AppColors.goldBright.withValues(alpha: 0.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chronicle['title'] ?? 'The Sacred Cycle',
                    style: GoogleFonts.cinzel(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.glassBorder),
                  const SizedBox(height: 12),
                  Text(
                    chronicle['chapter'] ?? '',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      color: AppColors.textPrimary,
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Breakthrough Insight Callout
            if (chronicle['breakthrough_insight'] != null) ...[
              GlassContainer(
                padding: const EdgeInsets.all(14),
                borderRadius: 16,
                fillColor: AppColors.purpleDeep.withValues(alpha: 0.35),
                borderColor: AppColors.etherealLavender.withValues(alpha: 0.4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.etherealLavender,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BREAKTHROUGH INTEGRATION',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.etherealLavender,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chronicle['breakthrough_insight'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
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
              const SizedBox(height: 12),
            ],

            // Horizon Trajectory Callout
            if (chronicle['trajectory'] != null) ...[
              GlassContainer(
                padding: const EdgeInsets.all(14),
                borderRadius: 16,
                fillColor: AppColors.goldBright.withValues(alpha: 0.1),
                borderColor: AppColors.goldBright.withValues(alpha: 0.35),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.navigation_outlined,
                      color: AppColors.goldBright,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UPCOMING HORIZON TRAJECTORY',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chronicle['trajectory'],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
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
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCycleTab({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.goldBright.withValues(alpha: 0.18) : AppColors.glassFill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.cinzel(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.5,
                color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricBadge({
    required String label,
    required String value,
    required IconData icon,
    bool isSmallText = false,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      borderRadius: 14,
      fillColor: AppColors.glassFillStrong,
      child: Column(
        children: [
          Icon(icon, size: 16, color: AppColors.goldBright),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cinzel(
              fontSize: isSmallText ? 10.5 : 16,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
