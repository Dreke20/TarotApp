// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bazaar_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BazaarNotifier)
final bazaarProvider = BazaarNotifierProvider._();

final class BazaarNotifierProvider
    extends $NotifierProvider<BazaarNotifier, BazaarState> {
  BazaarNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bazaarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bazaarNotifierHash();

  @$internal
  @override
  BazaarNotifier create() => BazaarNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BazaarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BazaarState>(value),
    );
  }
}

String _$bazaarNotifierHash() => r'e51ce563293814a71e24a6caee15281ce39df7d8';

abstract class _$BazaarNotifier extends $Notifier<BazaarState> {
  BazaarState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BazaarState, BazaarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BazaarState, BazaarState>,
              BazaarState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
