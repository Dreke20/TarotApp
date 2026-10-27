import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Sacred-geometry altar mandala drawn flat on the projected plane.
class ArMandalaPainter extends CustomPainter {
  ArMandalaPainter({required this.rotation, required this.glow});

  /// 0..1 slow rotation phase.
  final double rotation;

  /// 0..1 intensity (brighter once anchored / while dealing).
  final double glow;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.shortestSide / 2;
    final double a0 = rotation * 2 * pi;

    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(colors: <Color>[
          AppColors.goldMetallic.withValues(alpha: 0.18 + 0.14 * glow),
          AppColors.purpleDeep.withValues(alpha: 0.35),
          Colors.transparent,
        ], stops: const <double>[0.0, 0.7, 1.0])
            .createShader(Rect.fromCircle(center: c, radius: r)),
    );

    final Paint line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = AppColors.goldBright.withValues(alpha: 0.45 + 0.4 * glow);
    final Paint faint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = AppColors.goldMuted.withValues(alpha: 0.35 + 0.25 * glow);

    for (final double f in <double>[0.96, 0.88, 0.62, 0.34]) {
      canvas.drawCircle(c, r * f, f == 0.88 || f == 0.34 ? faint : line);
    }

    // Twelve zodiacal ticks on the outer band.
    for (int i = 0; i < 12; i++) {
      final double a = a0 + i * pi / 6;
      canvas.drawLine(
        c + Offset(cos(a), sin(a)) * r * 0.88,
        c + Offset(cos(a), sin(a)) * r * 0.96,
        line,
      );
      canvas.drawCircle(c + Offset(cos(a + pi / 12), sin(a + pi / 12)) * r * 0.92, 2.2,
          Paint()..color = AppColors.goldBright.withValues(alpha: 0.6 * (0.5 + glow)));
    }

    // Counter-rotating hexagram.
    for (int tri = 0; tri < 2; tri++) {
      final Path p = Path();
      for (int k = 0; k < 3; k++) {
        final double a = -a0 * 0.6 + tri * pi / 3 + k * 2 * pi / 3 - pi / 2;
        final Offset pt = c + Offset(cos(a), sin(a)) * r * 0.62;
        k == 0 ? p.moveTo(pt.dx, pt.dy) : p.lineTo(pt.dx, pt.dy);
      }
      p.close();
      canvas.drawPath(p, line);
    }

    // Flower-of-life petals in the core.
    for (int i = 0; i < 6; i++) {
      final double a = a0 * 0.4 + i * pi / 3;
      canvas.drawCircle(c + Offset(cos(a), sin(a)) * r * 0.17, r * 0.17, faint);
    }
  }

  @override
  bool shouldRepaint(covariant ArMandalaPainter old) =>
      old.rotation != rotation || old.glow != glow;
}
