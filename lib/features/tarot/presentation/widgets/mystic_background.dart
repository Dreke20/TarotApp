import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/stardust_particle_field.dart';
import '../../domain/altar_theme.dart';

/// Immersive celestial background featuring deep cosmic gradients,
/// soft luminous nebula orbs, and customizable altar themes.
class MysticBackground extends StatefulWidget {
  final Widget child;
  final AltarTheme altarTheme;

  const MysticBackground({
    super.key,
    required this.child,
    this.altarTheme = AltarTheme.midnightNebula,
  });

  @override
  State<MysticBackground> createState() => _MysticBackgroundState();
}

class _MysticBackgroundState extends State<MysticBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base cosmic dark gradient from active altar theme
        Container(
          decoration: BoxDecoration(
            gradient: widget.altarTheme.backgroundGradient,
          ),
        ),

        // Animated ambient nebulae
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            return Stack(
              children: [
                // Top right nebula glow
                Positioned(
                  top: -80 + sin(t * pi) * 20,
                  right: -60 + cos(t * pi) * 20,
                  child: Container(
                    width: 340,
                    height: 340,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.altarTheme.primaryColor.withValues(alpha: 0.14),
                          widget.altarTheme.primaryColor.withValues(alpha: 0.03),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom left luminous candlelight aura
                Positioned(
                  bottom: -60 - sin(t * pi) * 25,
                  left: -80 + cos(t * pi) * 20,
                  child: Container(
                    width: 380,
                    height: 380,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.altarTheme.secondaryColor.withValues(alpha: 0.16),
                          widget.altarTheme.primaryColor.withValues(alpha: 0.03),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Core starlight glow
                Center(
                  child: Opacity(
                    opacity: 0.12 + (t * 0.08),
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.goldBright,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Interactive Stardust Particle Field & Constellation Trails
        Positioned.fill(
          child: StardustParticleField(
            enableAmbientDrift: true,
            enableTouchTrails: true,
            child: SafeArea(child: widget.child),
          ),
        ),
      ],
    );
  }
}
