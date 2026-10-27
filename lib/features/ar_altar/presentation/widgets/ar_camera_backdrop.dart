import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/stardust_particle_field.dart';

/// Full-bleed live camera feed, or a starfield when the camera is unavailable.
class ArCameraBackdrop extends StatelessWidget {
  const ArCameraBackdrop({super.key, required this.controller});

  final CameraController? controller;

  @override
  Widget build(BuildContext context) {
    final CameraController? c = controller;
    if (c == null || !c.value.isInitialized || c.value.previewSize == null) {
      return const DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.cosmicBackgroundGradient),
        child: StardustParticleField(),
      );
    }
    final Size preview = c.value.previewSize!;
    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            // previewSize is reported in landscape; swap for portrait.
            width: preview.height,
            height: preview.width,
            child: CameraPreview(c),
          ),
        ),
      ),
    );
  }
}
