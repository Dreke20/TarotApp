import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mystic_performance_service.freezed.dart';
part 'mystic_performance_service.g.dart';

/// Performance and energy conservation configuration for Oraculum.
@freezed
abstract class MysticPerformanceSettings with _$MysticPerformanceSettings {
  const factory MysticPerformanceSettings({
    @Default(false) bool isBatterySaverEnabled,
    @Default(60) int maxParticleCount,
    @Default(true) bool enableHolographicSensors,
    @Default(true) bool enableGpuParticleDrift,
  }) = _MysticPerformanceSettings;

  factory MysticPerformanceSettings.fromJson(Map<String, dynamic> json) =>
      _$MysticPerformanceSettingsFromJson(json);
}

@Riverpod(keepAlive: true)
class MysticPerformanceNotifier extends _$MysticPerformanceNotifier {
  static const String _kPrefBatterySaverKey = 'oraculum_battery_saver_mode';

  @override
  MysticPerformanceSettings build() {
    _loadFromStorage();
    return const MysticPerformanceSettings();
  }

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isSaver = prefs.getBool(_kPrefBatterySaverKey) ?? false;
      state = _createSettings(isSaver);
    } catch (_) {}
  }

  Future<void> toggleBatterySaver() async {
    await setBatterySaver(!state.isBatterySaverEnabled);
  }

  Future<void> setBatterySaver(bool enabled) async {
    state = _createSettings(enabled);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kPrefBatterySaverKey, enabled);
    } catch (_) {}
  }

  MysticPerformanceSettings _createSettings(bool isSaver) {
    if (isSaver) {
      return const MysticPerformanceSettings(
        isBatterySaverEnabled: true,
        maxParticleCount: 16,
        enableHolographicSensors: false,
        enableGpuParticleDrift: false,
      );
    } else {
      return const MysticPerformanceSettings(
        isBatterySaverEnabled: false,
        maxParticleCount: 60,
        enableHolographicSensors: true,
        enableGpuParticleDrift: true,
      );
    }
  }
}
