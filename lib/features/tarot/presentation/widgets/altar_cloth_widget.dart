import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../altar/presentation/notifiers/altar_cloth_notifier.dart';
import '../../../altar/presentation/widgets/altar_cloth_painter.dart';

class AltarClothWidget extends ConsumerWidget {
  final Widget child;
  final double minHeight;

  const AltarClothWidget({
    super.key,
    required this.child,
    this.minHeight = 360,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCloth = ref.watch(altarClothProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Consecrated Altar Cloth Drape
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomPaint(
                painter: AltarClothPainter(cloth: activeCloth),
              ),
            ),
          ),

          // Underlying subtle gold radial glow
          Container(
            width: 500,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.goldBright.withValues(alpha: 0.08),
                  AppColors.backgroundViolet.withValues(alpha: 0.04),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // Concentric Sacred Altar Geometry
          Positioned.fill(
            child: CustomPaint(
              painter: const _AltarMandalaPainter(),
            ),
          ),

          child,
        ],
      ),
    );
  }
}

class _AltarMandalaPainter extends CustomPainter {
  const _AltarMandalaPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = max(min(size.width, size.height) * 0.48, 190.0);

    final outerPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final midPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final innerPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final dotPaint = Paint()
      ..color = AppColors.goldBright.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    // Outer Circle & Sub-ring
    canvas.drawCircle(center, maxRadius, outerPaint);
    canvas.drawCircle(center, maxRadius * 0.94, innerPaint);

    // Inner Concentric Circles
    canvas.drawCircle(center, maxRadius * 0.74, midPaint);
    canvas.drawCircle(center, maxRadius * 0.50, innerPaint);
    canvas.drawCircle(center, maxRadius * 0.28, innerPaint);

    // 24 Astrological & Cardinal Radial Rays
    for (int i = 0; i < 24; i++) {
      final isMajor = i % 2 == 0;
      final angle = (i * 15) * (pi / 180);
      final rStart = maxRadius * (isMajor ? 0.28 : 0.50);
      final p1 = Offset(
        center.dx + cos(angle) * rStart,
        center.dy + sin(angle) * rStart,
      );
      final p2 = Offset(
        center.dx + cos(angle) * (isMajor ? maxRadius : maxRadius * 0.94),
        center.dy + sin(angle) * (isMajor ? maxRadius : maxRadius * 0.94),
      );
      canvas.drawLine(p1, p2, isMajor ? midPaint : innerPaint);

      // Star point nodes on middle ring
      if (isMajor) {
        final nodePos = Offset(
          center.dx + cos(angle) * (maxRadius * 0.74),
          center.dy + sin(angle) * (maxRadius * 0.74),
        );
        canvas.drawCircle(nodePos, (i % 6 == 0) ? 2.6 : 1.6, dotPaint);

        // Outer rim diamonds
        final rimPos = Offset(
          center.dx + cos(angle) * maxRadius,
          center.dy + sin(angle) * maxRadius,
        );
        canvas.drawCircle(rimPos, 2.0, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
