// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_ritual_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomRitualNotifier)
final customRitualProvider = CustomRitualNotifierProvider._();

final class CustomRitualNotifierProvider
    extends $NotifierProvider<CustomRitualNotifier, CustomRitualState> {
  CustomRitualNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customRitualProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customRitualNotifierHash();

  @$internal
  @override
  CustomRitualNotifier create() => CustomRitualNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomRitualState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomRitualState>(value),
    );
  }
}

String _$customRitualNotifierHash() =>
    r'5c8ac4c4495d10b525cb0b7e4fadfb32d9879af8';

abstract class _$CustomRitualNotifier extends $Notifier<CustomRitualState> {
  CustomRitualState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CustomRitualState, CustomRitualState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CustomRitualState, CustomRitualState>,
              CustomRitualState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
