// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oracle_persona_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OraclePersonaNotifier)
final oraclePersonaProvider = OraclePersonaNotifierProvider._();

final class OraclePersonaNotifierProvider
    extends $NotifierProvider<OraclePersonaNotifier, OraclePersona> {
  OraclePersonaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oraclePersonaProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oraclePersonaNotifierHash();

  @$internal
  @override
  OraclePersonaNotifier create() => OraclePersonaNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OraclePersona value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OraclePersona>(value),
    );
  }
}

String _$oraclePersonaNotifierHash() =>
    r'da150b3992b2fcd2fd530b01b8c3d8e7f2a83fd1';

abstract class _$OraclePersonaNotifier extends $Notifier<OraclePersona> {
  OraclePersona build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OraclePersona, OraclePersona>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OraclePersona, OraclePersona>,
              OraclePersona,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
