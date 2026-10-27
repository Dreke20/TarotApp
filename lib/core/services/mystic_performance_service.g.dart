// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mystic_performance_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MysticPerformanceSettings _$MysticPerformanceSettingsFromJson(
  Map<String, dynamic> json,
) => _MysticPerformanceSettings(
  isBatterySaverEnabled: json['isBatterySaverEnabled'] as bool? ?? false,
  maxParticleCount: (json['maxParticleCount'] as num?)?.toInt() ?? 60,
  enableHolographicSensors: json['enableHolographicSensors'] as bool? ?? true,
  enableGpuParticleDrift: json['enableGpuParticleDrift'] as bool? ?? true,
);

Map<String, dynamic> _$MysticPerformanceSettingsToJson(
  _MysticPerformanceSettings instance,
) => <String, dynamic>{
  'isBatterySaverEnabled': instance.isBatterySaverEnabled,
  'maxParticleCount': instance.maxParticleCount,
  'enableHolographicSensors': instance.enableHolographicSensors,
  'enableGpuParticleDrift': instance.enableGpuParticleDrift,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MysticPerformanceNotifier)
final mysticPerformanceProvider = MysticPerformanceNotifierProvider._();

final class MysticPerformanceNotifierProvider
    extends
        $NotifierProvider<
          MysticPerformanceNotifier,
          MysticPerformanceSettings
        > {
  MysticPerformanceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mysticPerformanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mysticPerformanceNotifierHash();

  @$internal
  @override
  MysticPerformanceNotifier create() => MysticPerformanceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MysticPerformanceSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MysticPerformanceSettings>(value),
    );
  }
}

String _$mysticPerformanceNotifierHash() =>
    r'eba08709749240d6af68110d9176f5915590351e';

abstract class _$MysticPerformanceNotifier
    extends $Notifier<MysticPerformanceSettings> {
  MysticPerformanceSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<MysticPerformanceSettings, MysticPerformanceSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MysticPerformanceSettings, MysticPerformanceSettings>,
              MysticPerformanceSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
