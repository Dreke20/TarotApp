// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensory_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SensorySettingsNotifier)
final sensorySettingsProvider = SensorySettingsNotifierProvider._();

final class SensorySettingsNotifierProvider
    extends $NotifierProvider<SensorySettingsNotifier, SensorySettings> {
  SensorySettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sensorySettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sensorySettingsNotifierHash();

  @$internal
  @override
  SensorySettingsNotifier create() => SensorySettingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SensorySettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SensorySettings>(value),
    );
  }
}

String _$sensorySettingsNotifierHash() =>
    r'c4e3a78c2d173766a904e975a5c1fefdeb4e5921';

abstract class _$SensorySettingsNotifier extends $Notifier<SensorySettings> {
  SensorySettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SensorySettings, SensorySettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SensorySettings, SensorySettings>,
              SensorySettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(sensoryService)
final sensoryServiceProvider = SensoryServiceProvider._();

final class SensoryServiceProvider
    extends $FunctionalProvider<SensoryService, SensoryService, SensoryService>
    with $Provider<SensoryService> {
  SensoryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sensoryServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sensoryServiceHash();

  @$internal
  @override
  $ProviderElement<SensoryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SensoryService create(Ref ref) {
    return sensoryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SensoryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SensoryService>(value),
    );
  }
}

String _$sensoryServiceHash() => r'c3282d5dcf815e944bcf7047edd51e2af42bfa3b';
