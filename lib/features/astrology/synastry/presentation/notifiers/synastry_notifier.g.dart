// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synastry_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SynastryNotifier)
final synastryProvider = SynastryNotifierProvider._();

final class SynastryNotifierProvider
    extends $NotifierProvider<SynastryNotifier, SynastryState> {
  SynastryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'synastryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$synastryNotifierHash();

  @$internal
  @override
  SynastryNotifier create() => SynastryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SynastryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SynastryState>(value),
    );
  }
}

String _$synastryNotifierHash() => r'7d94bdf729c327de42396ffd753347d12c35467a';

abstract class _$SynastryNotifier extends $Notifier<SynastryState> {
  SynastryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SynastryState, SynastryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SynastryState, SynastryState>,
              SynastryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
