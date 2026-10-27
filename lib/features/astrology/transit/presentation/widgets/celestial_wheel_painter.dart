import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tarot_app/core/constants/app_colors.dart';
import 'package:tarot_app/features/astrology/transit/domain/celestial_transit.dart';

/// Custom GPU Canvas painter rendering an interactive 12-house celestial transit scrying wheel.
class CelestialWheelPainter extends CustomPainter {
  final List<CelestialTransitBody> transitingBodies;
  final double animationProgress;

  CelestialWheelPainter({
    required this.transitingBodies,
    this.animationProgress = 1.0,
  });

  static const List<String> _zodiacSymbols = [
    '♈', '♉', '♊', '♋', '♌', '♍', '♎', '♏', '♐', '♑', '♒', '♓'
  ];

  static const List<Color> _elementColors = [
    Color(0xFFFF7A00), // Aries (Fire)
    Color(0xFF2EC4B6), // Taurus (Earth)
    Color(0xFFE0AAFF), // Gemini (Air)
    Color(0xFF48CAE4), // Cancer (Water)
    Color(0xFFFFB703), // Leo (Fire)
    Color(0xFF38B000), // Virgo (Earth)
    Color(0xFFC77DFF), // Libra (Air)
    Color(0xFF0077B6), // Scorpio (Water)
    Color(0xFFFF5400), // Sagittarius (Fire)
    Color(0xFF588157), // Capricorn (Earth)
    Color(0xFF7209B7), // Aquarius (Air)
    Color(0xFF03045E), // Pisces (Water)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = min(size.width, size.height) / 2 - 8;
    final zodiacRadius = outerRadius - 28;
    final innerRadius = zodiacRadius - 38;
    final centerHubRadius = 24.0;

    final basePaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Outer & Concentric Boundary Rings
    canvas.drawCircle(center, outerRadius, basePaint);
    canvas.drawCircle(center, zodiacRadius, basePaint);
    canvas.drawCircle(center, innerRadius, basePaint);
    canvas.drawCircle(center, centerHubRadius, Paint()..color = const Color(0xFF1E1638));
    canvas.drawCircle(center, centerHubRadius, Paint()..color = AppColors.goldBright.withValues(alpha: 0.4)..style = PaintingStyle.stroke..strokeWidth = 1.2);

    // 12 Zodiac segments
    const segmentAngle = 2 * pi / 12;
    for (int i = 0; i < 12; i++) {
      final startAngle = i * segmentAngle - pi / 2;

      // House division spokes
      final spokePaint = Paint()
        ..color = AppColors.glassBorder.withValues(alpha: 0.3)
        ..strokeWidth = 0.8;
      final spokeX = center.dx + outerRadius * cos(startAngle);
      final spokeY = center.dy + outerRadius * sin(startAngle);
      canvas.drawLine(center, Offset(spokeX, spokeY), spokePaint);

      // Zodiac Glyph in segment band
      final midAngle = startAngle + segmentAngle / 2;
      final glyphDist = (outerRadius + zodiacRadius) / 2;
      final gx = center.dx + glyphDist * cos(midAngle);
      final gy = center.dy + glyphDist * sin(midAngle);

      final textSpan = TextSpan(
        text: _zodiacSymbols[i],
        style: TextStyle(
          color: _elementColors[i].withValues(alpha: 0.85),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(gx - textPainter.width / 2, gy - textPainter.height / 2),
      );
    }

    // Render Transiting Planets on the outer band
    for (final body in transitingBodies) {
      final signIdx = _zodiacSymbols.indexOf(_getZodiacSymbolForSign(body.sign));
      if (signIdx == -1) continue;

      final signStartAngle = signIdx * segmentAngle - pi / 2;
      final degreeFraction = (body.degree / 30.0).clamp(0.0, 1.0);
      final planetAngle = signStartAngle + degreeFraction * segmentAngle;

      final planetDist = (zodiacRadius + innerRadius) / 2;
      final px = center.dx + planetDist * cos(planetAngle);
      final py = center.dy + planetDist * sin(planetAngle);

      // Planet Glow Orb
      final glowPaint = Paint()
        ..color = _getPlanetColor(body.name).withValues(alpha: 0.25 * animationProgress)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(Offset(px, py), 12, glowPaint);

      final dotPaint = Paint()..color = const Color(0xFF130E26);
      canvas.drawCircle(Offset(px, py), 9, dotPaint);

      final borderPaint = Paint()
        ..color = _getPlanetColor(body.name)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(Offset(px, py), 9, borderPaint);

      // Planet Glyph
      final span = TextSpan(
        text: body.glyph,
        style: TextStyle(
          color: _getPlanetColor(body.name),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      );
      final tp = TextPainter(text: span, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(px - tp.width / 2, py - tp.height / 2));
    }

    // Central Mystic Star in the Hub
    final hubText = TextSpan(
      text: '✦',
      style: TextStyle(
        color: AppColors.goldBright.withValues(alpha: 0.9),
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    final hubPainter = TextPainter(text: hubText, textDirection: TextDirection.ltr)..layout();
    hubPainter.paint(canvas, Offset(center.dx - hubPainter.width / 2, center.dy - hubPainter.height / 2));
  }

  String _getZodiacSymbolForSign(String sign) {
    const signs = [
      'Aries', 'Taurus', 'Gemini', 'Cancer',
      'Leo', 'Virgo', 'Libra', 'Scorpio',
      'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
    ];
    final idx = signs.indexOf(sign);
    if (idx != -1 && idx < _zodiacSymbols.length) {
      return _zodiacSymbols[idx];
    }
    return '♈';
  }

  Color _getPlanetColor(String planet) {
    switch (planet) {
      case 'Sun':
        return const Color(0xFFFFD700);
      case 'Moon':
        return const Color(0xFF8AB4F8);
      case 'Mercury':
        return const Color(0xFF50E3C2);
      case 'Venus':
        return const Color(0xFFFF758F);
      case 'Mars':
        return const Color(0xFFFF4D4D);
      case 'Jupiter':
        return const Color(0xFFFFD166);
      case 'Saturn':
        return const Color(0xFFB39DDB);
      default:
        return AppColors.goldBright;
    }
  }

  @override
  bool shouldRepaint(covariant CelestialWheelPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.transitingBodies != transitingBodies;
  }
}
