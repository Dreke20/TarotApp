import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarot_app/core/constants/app_colors.dart';
import 'package:tarot_app/features/tarot/presentation/notifiers/reading_notifier.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/glass_container.dart';
import 'package:tarot_app/features/astrology/transit/domain/celestial_transit.dart';
import 'package:tarot_app/features/astrology/transit/presentation/notifiers/celestial_transit_notifier.dart';
import 'package:tarot_app/features/astrology/transit/presentation/widgets/celestial_wheel_painter.dart';

class CelestialTransitScreen extends ConsumerStatefulWidget {
  const CelestialTransitScreen({super.key});

  @override
  ConsumerState<CelestialTransitScreen> createState() => _CelestialTransitScreenState();
}

class _CelestialTransitScreenState extends ConsumerState<CelestialTransitScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(celestialTransitProvider);

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
          'CELESTIAL TRANSITS',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 20, color: AppColors.goldBright),
            onPressed: () {
              HapticFeedback.lightImpact();
              ref.read(celestialTransitProvider.notifier).refreshTransit();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.4,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.5),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 40),
          children: [
            // Chaldean Planetary Hour Card
            _buildPlanetaryHourBanner(snapshot.planetaryHour),

            const SizedBox(height: 18),

            // Celestial Scrying Wheel Canvas
            Center(
              child: SizedBox(
                width: 320,
                height: 320,
                child: AnimatedBuilder(
                  animation: _animController,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: CelestialWheelPainter(
                        transitingBodies: snapshot.bodies,
                        animationProgress: _animController.value,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Transiting Planets Strip
            Text(
              'LIVE CELESTIAL SKY COORDINATES',
              style: GoogleFonts.cinzel(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            _buildTransitingPlanetsList(snapshot.bodies),

            const SizedBox(height: 22),

            // Personal Transit-to-Natal Aspects
            Text(
              'PERSONAL TRANSIT-TO-NATAL ASPECTS',
              style: GoogleFonts.cinzel(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.etherealLavender,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            if (snapshot.aspects.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'No direct major aspects under 8° orb detected today.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              )
            else
              ...snapshot.aspects.map((aspect) => _buildAspectCard(aspect)),

            const SizedBox(height: 28),

            // Anchor Transit Action Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldBright,
                foregroundColor: const Color(0xFF0D0B14),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                HapticFeedback.heavyImpact();
                final transitSummary = 'Hour of ${snapshot.planetaryHour.planetName}: ${snapshot.planetaryHour.sacredVibration}';
                ref.read(readingNotifierProvider.notifier).setQuestion(transitSummary);
                Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.backgroundMidnight,
                    content: Text(
                      '✦ Altar anchored to ${snapshot.planetaryHour.planetName} Planetary Hour.',
                      style: GoogleFonts.plusJakartaSans(color: AppColors.goldBright),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('✦', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    'ANCHOR TRANSIT TO ALTAR',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanetaryHourBanner(PlanetaryHour hour) {
    return GlassContainer(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      borderColor: AppColors.goldBright.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldBright.withValues(alpha: 0.15),
                      border: Border.all(color: AppColors.goldBright, width: 1.2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      hour.planetGlyph,
                      style: const TextStyle(fontSize: 18, color: AppColors.goldBright),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HOUR OF ${hour.planetName.toUpperCase()}',
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        '${hour.dayRuler} Day · Hour ${hour.hourIndex} of 24 (${hour.isDayHour ? 'Diurnal' : 'Nocturnal'})',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.goldBright.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  hour.rulingElement,
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            hour.sacredVibration,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Mantra: "${hour.consecrationMantra}"',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransitingPlanetsList(List<CelestialTransitBody> bodies) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: bodies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final body = bodies[index];
          return GlassContainer(
            borderRadius: 14,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            borderColor: AppColors.glassBorder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      body.glyph,
                      style: const TextStyle(fontSize: 16, color: AppColors.goldBright),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      body.name,
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (body.isRetrograde) ...[
                      const SizedBox(width: 4),
                      const Text('℞', style: TextStyle(fontSize: 10, color: Color(0xFFFF5252))),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${body.degree}° ${body.sign}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.goldMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body.tarotArchetype,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAspectCard(TransitAspect aspect) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        borderRadius: 14,
        padding: const EdgeInsets.all(12),
        borderColor: aspect.isHarmonious
            ? const Color(0xFF50E3C2).withValues(alpha: 0.3)
            : const Color(0xFFFF758F).withValues(alpha: 0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${aspect.transitingGlyph} ${aspect.aspectGlyph} ${aspect.natalGlyph}',
                      style: const TextStyle(fontSize: 15, color: AppColors.goldBright),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${aspect.transitingPlanet} ${aspect.aspectType} Natal ${aspect.natalPlacement}',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${aspect.orbDegrees}° orb',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              aspect.channelingGuidance,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
