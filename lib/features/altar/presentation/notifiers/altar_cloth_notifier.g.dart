// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altar_cloth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AltarClothNotifier)
final altarClothProvider = AltarClothNotifierProvider._();

final class AltarClothNotifierProvider
    extends $NotifierProvider<AltarClothNotifier, AltarCloth> {
  AltarClothNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'altarClothProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$altarClothNotifierHash();

  @$internal
  @override
  AltarClothNotifier create() => AltarClothNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AltarCloth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AltarCloth>(value),
    );
  }
}

String _$altarClothNotifierHash() =>
    r'bfa7790c047a4a1f7af04d562cfb9912008ba040';

abstract class _$AltarClothNotifier extends $Notifier<AltarCloth> {
  AltarCloth build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AltarCloth, AltarCloth>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AltarCloth, AltarCloth>,
              AltarCloth,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
