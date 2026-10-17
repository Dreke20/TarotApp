// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monetization_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MonetizationNotifier)
final monetizationProvider = MonetizationNotifierProvider._();

final class MonetizationNotifierProvider
    extends $NotifierProvider<MonetizationNotifier, MonetizationState> {
  MonetizationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monetizationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monetizationNotifierHash();

  @$internal
  @override
  MonetizationNotifier create() => MonetizationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MonetizationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MonetizationState>(value),
    );
  }
}

String _$monetizationNotifierHash() =>
    r'1af8326db1ae4effa78d4b4ad72a3c7d22a3178f';

abstract class _$MonetizationNotifier extends $Notifier<MonetizationState> {
  MonetizationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MonetizationState, MonetizationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MonetizationState, MonetizationState>,
              MonetizationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
