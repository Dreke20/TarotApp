import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AltarClothWidget extends StatelessWidget {
  final Widget child;

  const AltarClothWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Concentric Sacred Altar Geometry
        Positioned.fill(
          child: CustomPaint(
            painter: _AltarMandalaPainter(),
          ),
        ),
        child,
      ],
    );
  }
}

class _AltarMandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) * 0.46;

    final outerPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final innerPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Outer Circle
    canvas.drawCircle(center, maxRadius, outerPaint);

    // Inner Concentric Circles
    canvas.drawCircle(center, maxRadius * 0.78, innerPaint);
    canvas.drawCircle(center, maxRadius * 0.52, innerPaint);
    canvas.drawCircle(center, maxRadius * 0.28, innerPaint);

    // 12 Astrological Radial Rays
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (pi / 180);
      final p1 = Offset(
        center.dx + cos(angle) * (maxRadius * 0.28),
        center.dy + sin(angle) * (maxRadius * 0.28),
      );
      final p2 = Offset(
        center.dx + cos(angle) * maxRadius,
        center.dy + sin(angle) * maxRadius,
      );
      canvas.drawLine(p1, p2, innerPaint);

      // Star point nodes
      final nodePos = Offset(
        center.dx + cos(angle) * (maxRadius * 0.78),
        center.dy + sin(angle) * (maxRadius * 0.78),
      );
      canvas.drawCircle(
        nodePos,
        2.0,
        Paint()
          ..color = AppColors.goldBright.withValues(alpha: 0.25)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
