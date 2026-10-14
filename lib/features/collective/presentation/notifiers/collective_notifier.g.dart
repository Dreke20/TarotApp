// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collective_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectiveNotifier)
final collectiveProvider = CollectiveNotifierProvider._();

final class CollectiveNotifierProvider
    extends $NotifierProvider<CollectiveNotifier, CollectivePulse> {
  CollectiveNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectiveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectiveNotifierHash();

  @$internal
  @override
  CollectiveNotifier create() => CollectiveNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectivePulse value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectivePulse>(value),
    );
  }
}

String _$collectiveNotifierHash() =>
    r'23b39671bf5af51b8612ce67c79bdd16f72e6560';

abstract class _$CollectiveNotifier extends $Notifier<CollectivePulse> {
  CollectivePulse build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CollectivePulse, CollectivePulse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CollectivePulse, CollectivePulse>,
              CollectivePulse,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
