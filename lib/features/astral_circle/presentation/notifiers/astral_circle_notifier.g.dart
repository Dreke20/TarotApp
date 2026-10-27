// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astral_circle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(astralCircleService)
final astralCircleServiceProvider = AstralCircleServiceProvider._();

final class AstralCircleServiceProvider
    extends
        $FunctionalProvider<
          AstralCircleService,
          AstralCircleService,
          AstralCircleService
        >
    with $Provider<AstralCircleService> {
  AstralCircleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'astralCircleServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$astralCircleServiceHash();

  @$internal
  @override
  $ProviderElement<AstralCircleService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AstralCircleService create(Ref ref) {
    return astralCircleService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AstralCircleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AstralCircleService>(value),
    );
  }
}

String _$astralCircleServiceHash() =>
    r'a5866f8b10147cddd9d41840ad57dc83d20236dd';

@ProviderFor(AstralCircleNotifier)
final astralCircleProvider = AstralCircleNotifierProvider._();

final class AstralCircleNotifierProvider
    extends
        $NotifierProvider<
          AstralCircleNotifier,
          AsyncValue<AstralCircleSession?>
        > {
  AstralCircleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'astralCircleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$astralCircleNotifierHash();

  @$internal
  @override
  AstralCircleNotifier create() => AstralCircleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<AstralCircleSession?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AstralCircleSession?>>(
        value,
      ),
    );
  }
}

String _$astralCircleNotifierHash() =>
    r'5017e03f2a3a53a260bf1746b96c66093a21f63b';

abstract class _$AstralCircleNotifier
    extends $Notifier<AsyncValue<AstralCircleSession?>> {
  AsyncValue<AstralCircleSession?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<AstralCircleSession?>,
              AsyncValue<AstralCircleSession?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AstralCircleSession?>,
                AsyncValue<AstralCircleSession?>
              >,
              AsyncValue<AstralCircleSession?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
