// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celestial_transit_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CelestialTransitNotifier)
final celestialTransitProvider = CelestialTransitNotifierProvider._();

final class CelestialTransitNotifierProvider
    extends
        $NotifierProvider<CelestialTransitNotifier, CelestialTransitSnapshot> {
  CelestialTransitNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'celestialTransitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$celestialTransitNotifierHash();

  @$internal
  @override
  CelestialTransitNotifier create() => CelestialTransitNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CelestialTransitSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CelestialTransitSnapshot>(value),
    );
  }
}

String _$celestialTransitNotifierHash() =>
    r'5f4be0c6954171c02c50275884201d4fd34b63f2';

abstract class _$CelestialTransitNotifier
    extends $Notifier<CelestialTransitSnapshot> {
  CelestialTransitSnapshot build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<CelestialTransitSnapshot, CelestialTransitSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CelestialTransitSnapshot, CelestialTransitSnapshot>,
              CelestialTransitSnapshot,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
