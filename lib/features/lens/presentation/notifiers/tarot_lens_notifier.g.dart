// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarot_lens_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tarotLensService)
final tarotLensServiceProvider = TarotLensServiceProvider._();

final class TarotLensServiceProvider
    extends
        $FunctionalProvider<
          TarotLensService,
          TarotLensService,
          TarotLensService
        >
    with $Provider<TarotLensService> {
  TarotLensServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tarotLensServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tarotLensServiceHash();

  @$internal
  @override
  $ProviderElement<TarotLensService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TarotLensService create(Ref ref) {
    return tarotLensService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TarotLensService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TarotLensService>(value),
    );
  }
}

String _$tarotLensServiceHash() => r'e90dc6ac56fcdc8cbdbffa1c027c6110a9879eb2';

@ProviderFor(TarotLensNotifier)
final tarotLensProvider = TarotLensNotifierProvider._();

final class TarotLensNotifierProvider
    extends $NotifierProvider<TarotLensNotifier, TarotLensState> {
  TarotLensNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tarotLensProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tarotLensNotifierHash();

  @$internal
  @override
  TarotLensNotifier create() => TarotLensNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TarotLensState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TarotLensState>(value),
    );
  }
}

String _$tarotLensNotifierHash() => r'daf820b71819153651979b8df9a9147576ac3709';

abstract class _$TarotLensNotifier extends $Notifier<TarotLensState> {
  TarotLensState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TarotLensState, TarotLensState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TarotLensState, TarotLensState>,
              TarotLensState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
