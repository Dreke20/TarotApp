// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensory_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$sensoryServiceHash() => r'3e2ce19878b31e96c171ca7dfadc4d4625b5d8da';
