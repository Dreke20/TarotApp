// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hands_free_voice_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(handsFreeVoiceService)
final handsFreeVoiceServiceProvider = HandsFreeVoiceServiceProvider._();

final class HandsFreeVoiceServiceProvider
    extends
        $FunctionalProvider<
          HandsFreeVoiceService,
          HandsFreeVoiceService,
          HandsFreeVoiceService
        >
    with $Provider<HandsFreeVoiceService> {
  HandsFreeVoiceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'handsFreeVoiceServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$handsFreeVoiceServiceHash();

  @$internal
  @override
  $ProviderElement<HandsFreeVoiceService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HandsFreeVoiceService create(Ref ref) {
    return handsFreeVoiceService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HandsFreeVoiceService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HandsFreeVoiceService>(value),
    );
  }
}

String _$handsFreeVoiceServiceHash() =>
    r'45be14ed8b974c3b4bb13a38cb7150a9e28b48cd';

@ProviderFor(HandsFreeVoiceNotifier)
final handsFreeVoiceProvider = HandsFreeVoiceNotifierProvider._();

final class HandsFreeVoiceNotifierProvider
    extends $NotifierProvider<HandsFreeVoiceNotifier, HandsFreeVoiceState> {
  HandsFreeVoiceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'handsFreeVoiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$handsFreeVoiceNotifierHash();

  @$internal
  @override
  HandsFreeVoiceNotifier create() => HandsFreeVoiceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HandsFreeVoiceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HandsFreeVoiceState>(value),
    );
  }
}

String _$handsFreeVoiceNotifierHash() =>
    r'58bdeadd73626d4e365ebae24760710400d8f894';

abstract class _$HandsFreeVoiceNotifier extends $Notifier<HandsFreeVoiceState> {
  HandsFreeVoiceState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HandsFreeVoiceState, HandsFreeVoiceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HandsFreeVoiceState, HandsFreeVoiceState>,
              HandsFreeVoiceState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
