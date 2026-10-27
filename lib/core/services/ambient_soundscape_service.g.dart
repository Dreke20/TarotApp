// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambient_soundscape_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AmbientAudioNotifier)
final ambientAudioProvider = AmbientAudioNotifierProvider._();

final class AmbientAudioNotifierProvider
    extends $NotifierProvider<AmbientAudioNotifier, AmbientAudioState> {
  AmbientAudioNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ambientAudioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ambientAudioNotifierHash();

  @$internal
  @override
  AmbientAudioNotifier create() => AmbientAudioNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AmbientAudioState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AmbientAudioState>(value),
    );
  }
}

String _$ambientAudioNotifierHash() =>
    r'598dd36f269d39c3fd611d3dc01669b5d6a86c0e';

abstract class _$AmbientAudioNotifier extends $Notifier<AmbientAudioState> {
  AmbientAudioState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AmbientAudioState, AmbientAudioState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AmbientAudioState, AmbientAudioState>,
              AmbientAudioState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
