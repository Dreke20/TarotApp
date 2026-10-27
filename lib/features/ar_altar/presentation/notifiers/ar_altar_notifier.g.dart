// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_altar_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(arCameraService)
final arCameraServiceProvider = ArCameraServiceProvider._();

final class ArCameraServiceProvider
    extends
        $FunctionalProvider<ArCameraService, ArCameraService, ArCameraService>
    with $Provider<ArCameraService> {
  ArCameraServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arCameraServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arCameraServiceHash();

  @$internal
  @override
  $ProviderElement<ArCameraService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArCameraService create(Ref ref) {
    return arCameraService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArCameraService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArCameraService>(value),
    );
  }
}

String _$arCameraServiceHash() => r'4a695d0ab9e673fa5779c7d7ba7260de70516493';

@ProviderFor(arPoseTracker)
final arPoseTrackerProvider = ArPoseTrackerProvider._();

final class ArPoseTrackerProvider
    extends $FunctionalProvider<ArPoseTracker, ArPoseTracker, ArPoseTracker>
    with $Provider<ArPoseTracker> {
  ArPoseTrackerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arPoseTrackerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arPoseTrackerHash();

  @$internal
  @override
  $ProviderElement<ArPoseTracker> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArPoseTracker create(Ref ref) {
    return arPoseTracker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArPoseTracker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArPoseTracker>(value),
    );
  }
}

String _$arPoseTrackerHash() => r'2c4b4b86a8f93fa54882b25590fbc243224c2993';

/// High-frequency device pose, kept separate from [ArAltarNotifier] so 60 Hz
/// sensor updates only rebuild the projected plane, not the whole screen.

@ProviderFor(ArPoseNotifier)
final arPoseProvider = ArPoseNotifierProvider._();

/// High-frequency device pose, kept separate from [ArAltarNotifier] so 60 Hz
/// sensor updates only rebuild the projected plane, not the whole screen.
final class ArPoseNotifierProvider
    extends $NotifierProvider<ArPoseNotifier, ArPose> {
  /// High-frequency device pose, kept separate from [ArAltarNotifier] so 60 Hz
  /// sensor updates only rebuild the projected plane, not the whole screen.
  ArPoseNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arPoseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arPoseNotifierHash();

  @$internal
  @override
  ArPoseNotifier create() => ArPoseNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArPose value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArPose>(value),
    );
  }
}

String _$arPoseNotifierHash() => r'bb2fe9c91929470edae85df137fae9ab11073c03';

/// High-frequency device pose, kept separate from [ArAltarNotifier] so 60 Hz
/// sensor updates only rebuild the projected plane, not the whole screen.

abstract class _$ArPoseNotifier extends $Notifier<ArPose> {
  ArPose build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ArPose, ArPose>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArPose, ArPose>,
              ArPose,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ArAltarNotifier)
final arAltarProvider = ArAltarNotifierProvider._();

final class ArAltarNotifierProvider
    extends $NotifierProvider<ArAltarNotifier, ArAltarState> {
  ArAltarNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arAltarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arAltarNotifierHash();

  @$internal
  @override
  ArAltarNotifier create() => ArAltarNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArAltarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArAltarState>(value),
    );
  }
}

String _$arAltarNotifierHash() => r'db28d27d2fae7f08f1c9093700a3c955cc7e60fe';

abstract class _$ArAltarNotifier extends $Notifier<ArAltarState> {
  ArAltarState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ArAltarState, ArAltarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ArAltarState, ArAltarState>,
              ArAltarState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
