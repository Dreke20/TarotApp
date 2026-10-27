import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../domain/ar_altar_card.dart';

/// Integrates gyroscope rotation into a yaw/pitch pose relative to the moment
/// the mandala was anchored, so the projection stays fixed in the room while
/// the seeker moves their phone.
///
/// This is sensor-based (3-DoF) anchoring, not ARCore plane detection: it
/// tracks rotation, not physical translation.
class ArPoseTracker {
  ArPoseTracker({Stream<GyroscopeEvent>? gyroscope})
      : _gyroscope = gyroscope ??
            gyroscopeEventStream(samplingPeriod: SensorInterval.gameInterval);

  final Stream<GyroscopeEvent> _gyroscope;
  final StreamController<ArPose> _poses = StreamController<ArPose>.broadcast();
  StreamSubscription<GyroscopeEvent>? _sub;
  DateTime? _last;
  double _yaw = 0;
  double _pitch = 0;

  static const double maxYaw = 1.1;
  static const double maxPitch = 0.7;

  Stream<ArPose> get poses => _poses.stream;

  void start() {
    _sub ??= _gyroscope.listen(
      _onGyro,
      onError: (Object _) {/* no gyroscope: projection simply stays centred */},
    );
  }

  /// Exposed for tests: feed a gyroscope sample (rad/s) at [at].
  void ingest(double gx, double gy, DateTime at) {
    final DateTime? last = _last;
    _last = at;
    if (last == null) return;
    final double dt = at.difference(last).inMicroseconds / 1e6;
    if (dt <= 0 || dt > 0.25) return; // ignore stalls / clock jumps
    _yaw = (_yaw + gy * dt).clamp(-maxYaw, maxYaw);
    _pitch = (_pitch + gx * dt).clamp(-maxPitch, maxPitch);
    _poses.add(ArPose(yaw: _yaw, pitch: _pitch));
  }

  void _onGyro(GyroscopeEvent e) => ingest(e.x, e.y, DateTime.now());

  /// Re-anchors the mandala straight ahead.
  void recenter() {
    _yaw = 0;
    _pitch = 0;
    _last = null;
    _poses.add(const ArPose());
  }

  Future<void> stop() async {
    await _sub?.cancel();
    _sub = null;
    _last = null;
  }

  Future<void> dispose() async {
    await stop();
    await _poses.close();
  }
}
