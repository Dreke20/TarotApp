import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../data/ephemeris_calculator.dart';
import '../../domain/natal_chart.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/screens/lunar_synastry_screen.dart';

class NatalChartScreen extends ConsumerWidget {
  const NatalChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authNotifierProvider).profile;
    final chart = EphemerisCalculator.calculateChart(
      sunSign: profile?.zodiacSign ?? 'Scorpio',
      moonSign: profile?.moonSign,
      risingSign: profile?.risingSign,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'NATAL EPHEMERIS',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.3,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.5),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Astrological Mandala Card
              _buildMandalaHeader(chart),

              const SizedBox(height: 18),

              // Elemental Alchemy Breakdown
              _buildElementalAlchemy(chart),

              const SizedBox(height: 18),

              // Lunar Synastry Portal Card
              _buildSynastryPortal(context),

              const SizedBox(height: 22),

              // Celestial Placements & Tarot Correlations
              Text(
                'CELESTIAL PLACEMENTS & TAROT MATRIX',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              ...chart.placements.asMap().entries.map((entry) {
                return _buildPlacementCard(entry.value, entry.key);
              }),
            ],
          ),
        ),
      ),
    ),
  ),
);
}

  Widget _buildMandalaHeader(NatalChart chart) {
    return GlassContainer(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.85),
      borderColor: AppColors.goldBright.withValues(alpha: 0.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBigSignPillar('☉ SUN', chart.sunSign, 'Vitality'),
              Container(width: 1, height: 48, color: AppColors.glassBorder),
              _buildBigSignPillar('☽ MOON', chart.moonSign, 'Intuition'),
              Container(width: 1, height: 48, color: AppColors.glassBorder),
              _buildBigSignPillar('🌅 RISING', chart.risingSign, 'Presence'),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, size: 16, color: AppColors.goldBright),
                  const SizedBox(width: 8),
                  Text(
                    'Soul Archetype:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
              Text(
                chart.soulArchetype.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.05, end: 0);
  }

  Widget _buildBigSignPillar(String title, String sign, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.etherealLavender,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          sign,
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildElementalAlchemy(NatalChart chart) {
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.75),
      borderColor: AppColors.glassBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ELEMENTAL BALANCE',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.etherealLavender,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'Dominant: ${chart.dominantElement}',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildElementBar('🔥 Fire', chart.firePercent, const Color(0xFFFF6B6B)),
          const SizedBox(height: 8),
          _buildElementBar('🌍 Earth', chart.earthPercent, const Color(0xFF6BCB77)),
          const SizedBox(height: 8),
          _buildElementBar('💨 Air', chart.airPercent, const Color(0xFF4D96FF)),
          const SizedBox(height: 8),
          _buildElementBar('🌊 Water', chart.waterPercent, const Color(0xFF9D4EDD)),
        ],
      ),
    );
  }

  Widget _buildElementBar(String label, double percent, Color barColor) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textPrimary),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: AppColors.glassFillStrong,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 38,
          child: Text(
            '${(percent * 100).toInt()}%',
            textAlign: TextAlign.end,
            style: GoogleFonts.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlacementCard(PlanetPlacement p, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: 16,
        padding: const EdgeInsets.all(14),
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.8),
        borderColor: AppColors.glassBorder,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                      ),
                      child: Center(
                        child: Text(
                          p.symbol,
                          style: const TextStyle(fontSize: 16, color: AppColors.goldBright),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${p.planet.toUpperCase()} IN ${p.sign.toUpperCase()}',
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                          ),
                        ),
                        Text(
                          '${p.house} • ${p.element} Element',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              p.meaning,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textPrimary.withValues(alpha: 0.9),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.goldBright.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_stories, size: 14, color: AppColors.goldBright),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Tarot Arcana: ${p.tarotCorrelation}',
                      style: GoogleFonts.cinzel(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 350.ms, delay: (index * 40).ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildSynastryPortal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2C1B4D).withValues(alpha: 0.8),
            const Color(0xFF19122C).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF758F).withValues(alpha: 0.4), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFF758F).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Text('💞', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LUNAR SYNASTRY & COMPATIBILITY',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF758F),
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  'Scry planetary aspects & Tarot archetypes with a beloved partner',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFFF758F), size: 16),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LunarSynastryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
