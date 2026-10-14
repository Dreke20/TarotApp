// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_spread_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomSpreadNotifier)
final customSpreadProvider = CustomSpreadNotifierProvider._();

final class CustomSpreadNotifierProvider
    extends $NotifierProvider<CustomSpreadNotifier, List<CustomSpread>> {
  CustomSpreadNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customSpreadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customSpreadNotifierHash();

  @$internal
  @override
  CustomSpreadNotifier create() => CustomSpreadNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CustomSpread> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CustomSpread>>(value),
    );
  }
}

String _$customSpreadNotifierHash() =>
    r'a4848ecac5f560ed68aaec028ceb3e6f5f0c23a4';

abstract class _$CustomSpreadNotifier extends $Notifier<List<CustomSpread>> {
  List<CustomSpread> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<CustomSpread>, List<CustomSpread>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CustomSpread>, List<CustomSpread>>,
              List<CustomSpread>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
