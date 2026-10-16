import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/domain/oracle_persona.dart';

/// The 3 rhythmic phases of the sacred 4-7-8 breathing sequence.
enum BreathingPhase {
  inhale(
    title: 'INHALE',
    durationSeconds: 4,
    guidance: 'Draw the cosmic breath inward...',
    subGuidance: 'Expand your awareness with celestial prana',
  ),
  hold(
    title: 'HOLD',
    durationSeconds: 7,
    guidance: 'Still the mind in the sacred void...',
    subGuidance: 'Anchor your intention into the heart center',
  ),
  exhale(
    title: 'EXHALE',
    durationSeconds: 8,
    guidance: 'Release all doubt and control...',
    subGuidance: 'Surrender expectations to the cosmic current',
  );

  final String title;
  final int durationSeconds;
  final String guidance;
  final String subGuidance;

  const BreathingPhase({
    required this.title,
    required this.durationSeconds,
    required this.guidance,
    required this.subGuidance,
  });
}

/// GPU-accelerated glowing canvas breathing orb for 4-7-8 intention centering.
class BreathingOrbWidget extends StatelessWidget {
  final BreathingPhase phase;
  final int secondsRemaining;
  final double scale;
  final double pulseValue;
  final OraclePersona? persona;
  final double size;

  const BreathingOrbWidget({
    super.key,
    required this.phase,
    required this.secondsRemaining,
    required this.scale,
    this.pulseValue = 0.0,
    this.persona,
    this.size = 250,
  });

  @override
  Widget build(BuildContext context) {
    final auraColor = persona?.accentColor ?? AppColors.goldBright;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // GPU Custom Painted Sacred Geometry Breathing Orb
          CustomPaint(
            size: Size(size, size),
            painter: _BreathingOrbPainter(
              phase: phase,
              scale: scale,
              pulseValue: pulseValue,
              auraColor: auraColor,
            ),
          ),

          // Central Typography & Seconds Display
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                phase.title,
                style: GoogleFonts.cinzel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.5,
                  color: auraColor,
                  shadows: [
                    Shadow(
                      color: auraColor.withValues(alpha: 0.6),
                      blurRadius: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$secondsRemaining',
                style: GoogleFonts.cinzel(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      color: auraColor.withValues(alpha: 0.8),
                      blurRadius: 20,
                    ),
                    const Shadow(
                      color: Colors.black,
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              Text(
                'SECONDS',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreathingOrbPainter extends CustomPainter {
  final BreathingPhase phase;
  final double scale; // 0.45 to 1.0
  final double pulseValue; // 0.0 to 1.0
  final Color auraColor;

  _BreathingOrbPainter({
    required this.phase,
    required this.scale,
    required this.pulseValue,
    required this.auraColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Outer subtle boundary ring
    final boundaryPaint = Paint()
      ..color = AppColors.goldMuted.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, maxRadius - 4, boundaryPaint);

    // Cardinal 8-point tick marks on outer boundary
    final tickPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.45)
      ..strokeWidth = 1.5;
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi) / 4;
      final start = Offset(
        center.dx + (maxRadius - 8) * math.cos(angle),
        center.dy + (maxRadius - 8) * math.sin(angle),
      );
      final end = Offset(
        center.dx + (maxRadius - 2) * math.cos(angle),
        center.dy + (maxRadius - 2) * math.sin(angle),
      );
      canvas.drawLine(start, end, tickPaint);
    }

    // Dynamic animated radius based on breathing scale
    // In hold phase, add gentle organic heartbeat pulse oscillation
    final holdPulseOffset = (phase == BreathingPhase.hold)
        ? math.sin(pulseValue * 2 * math.pi) * 4.0
        : 0.0;

    final currentRadius =
        (maxRadius * 0.40) + ((maxRadius * 0.50) * scale) + holdPulseOffset;

    // 1. Outermost Diffuse Atmospheric Glow
    final diffusePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          auraColor.withValues(alpha: 0.28),
          auraColor.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.2, 0.7, 1.0],
      ).createShader(
          Rect.fromCircle(center: center, radius: currentRadius * 1.35));
    canvas.drawCircle(center, currentRadius * 1.35, diffusePaint);

    // 2. Mid Celestial Aura Ring
    final midAuraPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.etherealLavender.withValues(alpha: 0.35),
          auraColor.withValues(alpha: 0.18),
          Colors.transparent,
        ],
        stops: const [0.3, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: currentRadius));
    canvas.drawCircle(center, currentRadius, midAuraPaint);

    // 3. Concentric Sacred Geometry Ring
    final geoPaint = Paint()
      ..color = auraColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, currentRadius, geoPaint);

    // 4. Inner Prana Core
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.65),
          auraColor.withValues(alpha: 0.40),
          AppColors.backgroundMidnight.withValues(alpha: 0.85),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
          Rect.fromCircle(center: center, radius: currentRadius * 0.72));
    canvas.drawCircle(center, currentRadius * 0.72, corePaint);

    // 5. Delicate inner dash ring
    final innerRingPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(center, currentRadius * 0.50, innerRingPaint);
  }

  @override
  bool shouldRepaint(covariant _BreathingOrbPainter oldDelegate) {
    return oldDelegate.scale != scale ||
        oldDelegate.phase != phase ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.auraColor != auraColor;
  }
}
