// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_weaver_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SoundWeaverNotifier)
final soundWeaverProvider = SoundWeaverNotifierProvider._();

final class SoundWeaverNotifierProvider
    extends $NotifierProvider<SoundWeaverNotifier, SoundWeaverState> {
  SoundWeaverNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soundWeaverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soundWeaverNotifierHash();

  @$internal
  @override
  SoundWeaverNotifier create() => SoundWeaverNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SoundWeaverState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SoundWeaverState>(value),
    );
  }
}

String _$soundWeaverNotifierHash() =>
    r'caf6d48f2396965427b5f21f1624474f4eececb7';

abstract class _$SoundWeaverNotifier extends $Notifier<SoundWeaverState> {
  SoundWeaverState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SoundWeaverState, SoundWeaverState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SoundWeaverState, SoundWeaverState>,
              SoundWeaverState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
