import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/mystic_performance_service.dart';

/// Wraps any widget (e.g. a Tarot Card) with a 3D perspective tilt and
/// dynamic iridescent gold foil reflection responding to physical device
/// gyroscope/accelerometer sensors or touchscreen gesture drags.
class HolographicFoilCard extends ConsumerStatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final bool enableSensorTilt;
  final bool enableTouchTilt;
  final BorderRadius borderRadius;

  const HolographicFoilCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.18, // ~10 degrees
    this.enableSensorTilt = true,
    this.enableTouchTilt = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  ConsumerState<HolographicFoilCard> createState() => _HolographicFoilCardState();
}

class _HolographicFoilCardState extends ConsumerState<HolographicFoilCard>
    with SingleTickerProviderStateMixin {
  double _tiltX = 0.0; // pitch (rotation around X)
  double _tiltY = 0.0; // roll (rotation around Y)
  double _targetTiltX = 0.0;
  double _targetTiltY = 0.0;

  StreamSubscription<AccelerometerEvent>? _sensorSub;
  late AnimationController _springController;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(_smoothLerp);

    _initSensor();
  }

  void _initSensor() {
    final perf = ref.read(mysticPerformanceProvider);
    if (!widget.enableSensorTilt || !perf.enableHolographicSensors) return;
    // Only attempt hardware sensor listener on mobile platforms
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

    try {
      _sensorSub = accelerometerEventStream().listen(
        (event) {
          if (!mounted) return;
          // Normal phone holding: x is roll (-10 to 10), y is pitch (0 to 10)
          // Map to -1.0 to 1.0 range
          final normX = (-event.x / 9.8).clamp(-1.0, 1.0);
          final normY = ((event.y - 4.5) / 9.8).clamp(-1.0, 1.0);

          setState(() {
            _targetTiltY = normX * widget.maxTiltAngle;
            _targetTiltX = normY * widget.maxTiltAngle;
          });
          if (!_springController.isAnimating) {
            _springController.forward(from: 0.0);
          }
        },
        onError: (e) {
          debugPrint('[HolographicFoilCard] Sensor stream note: $e');
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('[HolographicFoilCard] Accelerometer setup note: $e');
    }
  }

  void _smoothLerp() {
    setState(() {
      _tiltX += (_targetTiltX - _tiltX) * 0.25;
      _tiltY += (_targetTiltY - _tiltY) * 0.25;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    if (!widget.enableTouchTilt) return;
    final dx = (details.localPosition.dx / size.width - 0.5) * 2;
    final dy = (details.localPosition.dy / size.height - 0.5) * 2;
    setState(() {
      _targetTiltY = dx * widget.maxTiltAngle;
      _targetTiltX = -dy * widget.maxTiltAngle;
    });
    if (!_springController.isAnimating) {
      _springController.forward(from: 0.0);
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      _targetTiltX = 0.0;
      _targetTiltY = 0.0;
    });
    _springController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _sensorSub?.cancel();
    _springController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sheen highlights move oppositely to perspective angle
    final sheenAlignmentX = (-_tiltY / widget.maxTiltAngle).clamp(-1.0, 1.0);
    final sheenAlignmentY = (-_tiltX / widget.maxTiltAngle).clamp(-1.0, 1.0);

    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0015) // Subtle 3D perspective
      ..rotateX(_tiltX)
      ..rotateY(_tiltY);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardSize = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onPanUpdate: (d) => _handlePanUpdate(d, cardSize),
          onPanEnd: _handlePanEnd,
          child: Transform(
            alignment: FractionalOffset.center,
            transform: transform,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Stack(
                children: [
                  // Base Card Content
                  widget.child,

                  // Holographic Metallic Specular Foil Shimmer
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget.borderRadius,
                          gradient: LinearGradient(
                            begin: Alignment(
                              sheenAlignmentX - 0.8,
                              sheenAlignmentY - 0.8,
                            ),
                            end: Alignment(
                              sheenAlignmentX + 0.8,
                              sheenAlignmentY + 0.8,
                            ),
                            colors: [
                              Colors.transparent,
                              const Color(0x33FFD700), // Soft Gold
                              const Color(0x66FFFFFF), // Radiant Starlight White
                              const Color(0x33E0B0FF), // Iridescent Amethyst
                              const Color(0x3380E5FF), // Cyan Sheen
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.35, 0.50, 0.65, 0.75, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Edge Glow Reflection along the border
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget.borderRadius,
                          border: Border.all(
                            color: Color.lerp(
                              const Color(0x33C5A059),
                              const Color(0x88FFD700),
                              (sheenAlignmentX.abs() + sheenAlignmentY.abs()) / 2,
                            )!,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
