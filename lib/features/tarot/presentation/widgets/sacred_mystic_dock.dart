import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../astrology/presentation/screens/natal_chart_screen.dart';
import '../../../collective/presentation/screens/collective_sanctuary_screen.dart';
import '../../../divination/presentation/screens/iching_screen.dart';
import '../../../divination/presentation/screens/rune_casting_screen.dart';
import '../../../dream/presentation/screens/dream_journal_screen.dart';
import '../../../lens/presentation/screens/tarot_lens_screen.dart';
import '../screens/custom_spread_builder_screen.dart';
import 'glass_container.dart';

class SacredMysticDock extends StatelessWidget {
  const SacredMysticDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
          child: GlassContainer(
            borderRadius: 22,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.88),
            borderColor: AppColors.goldBright.withValues(alpha: 0.45),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDockItem(
                    context,
                    iconText: '🎴',
                    title: 'ALTAR',
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: 'ᚦ',
                    title: 'RUNES',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RuneCastingScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '☯',
                    title: 'I CHING',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const IChingScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '🌙',
                    title: 'DREAMS',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DreamJournalScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '📜',
                    title: 'GRIMOIRE',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CustomSpreadBuilderScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '🪐',
                    title: 'EPHEMERIS',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NatalChartScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '✨',
                    title: 'COLLECTIVE',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CollectiveSanctuaryScreen()),
                    ),
                  ),
                  _buildDivider(),
                  _buildDockItem(
                    context,
                    iconText: '🔍',
                    title: 'LENS',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TarotLensScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: AppColors.glassBorder.withValues(alpha: 0.6),
    );
  }

  Widget _buildDockItem(
    BuildContext context, {
    required String iconText,
    required String title,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          SensoryService().cardSelectionHaptic();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.goldBright.withValues(alpha: 0.22)
                : const Color(0xFF181522),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive
                  ? AppColors.goldBright
                  : AppColors.glassBorder.withValues(alpha: 0.65),
              width: isActive ? 1.4 : 1.0,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.goldBright.withValues(alpha: 0.35),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(iconText, style: const TextStyle(fontSize: 15)),
              const SizedBox(width: 7),
              Text(
                title,
                style: GoogleFonts.cinzel(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppColors.goldBright : AppColors.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
