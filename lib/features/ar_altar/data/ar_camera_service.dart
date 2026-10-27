import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

/// Owns the live rear-camera feed behind the AR Altar.
class ArCameraService {
  CameraController? _controller;

  CameraController? get controller => _controller;
  bool get isReady => _controller?.value.isInitialized ?? false;

  /// Starts the rear camera. Returns an error message, or null on success.
  Future<String?> start() async {
    if (isReady) return null;
    try {
      final List<CameraDescription> cameras = await availableCameras();
      if (cameras.isEmpty) return 'No camera found on this device.';
      final CameraDescription back = cameras.firstWhere(
        (CameraDescription c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final CameraController controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      _controller = controller;
      return null;
    } on CameraException catch (e) {
      debugPrint('ArCameraService error: ${e.code} ${e.description}');
      if (e.code.toLowerCase().contains('access')) {
        return 'Camera permission denied. The altar will appear over a starfield instead.';
      }
      return 'The camera could not start. The altar will appear over a starfield instead.';
    } catch (e) {
      debugPrint('ArCameraService error: $e');
      return 'The camera could not start. The altar will appear over a starfield instead.';
    }
  }

  Future<void> stop() async {
    final CameraController? c = _controller;
    _controller = null;
    try {
      await c?.dispose();
    } catch (e) {
      debugPrint('ArCameraService dispose error: $e');
    }
  }
}
