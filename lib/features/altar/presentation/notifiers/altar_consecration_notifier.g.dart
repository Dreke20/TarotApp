// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altar_consecration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AltarConsecrationNotifier)
final altarConsecrationProvider = AltarConsecrationNotifierProvider._();

final class AltarConsecrationNotifierProvider
    extends
        $NotifierProvider<AltarConsecrationNotifier, AltarConsecrationState> {
  AltarConsecrationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'altarConsecrationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$altarConsecrationNotifierHash();

  @$internal
  @override
  AltarConsecrationNotifier create() => AltarConsecrationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AltarConsecrationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AltarConsecrationState>(value),
    );
  }
}

String _$altarConsecrationNotifierHash() =>
    r'b21d9b1b05da78f643554f567b7bdaf8aab1f064';

abstract class _$AltarConsecrationNotifier
    extends $Notifier<AltarConsecrationState> {
  AltarConsecrationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AltarConsecrationState, AltarConsecrationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AltarConsecrationState, AltarConsecrationState>,
              AltarConsecrationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
