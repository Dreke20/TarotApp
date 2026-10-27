// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oracle_dialogue_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(oracleDialogueService)
final oracleDialogueServiceProvider = OracleDialogueServiceProvider._();

final class OracleDialogueServiceProvider
    extends
        $FunctionalProvider<
          OracleDialogueService,
          OracleDialogueService,
          OracleDialogueService
        >
    with $Provider<OracleDialogueService> {
  OracleDialogueServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oracleDialogueServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oracleDialogueServiceHash();

  @$internal
  @override
  $ProviderElement<OracleDialogueService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OracleDialogueService create(Ref ref) {
    return oracleDialogueService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OracleDialogueService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OracleDialogueService>(value),
    );
  }
}

String _$oracleDialogueServiceHash() =>
    r'02fb8316c0b25580f9c8b76f1192d0a581eb1578';

@ProviderFor(oracleSpeechService)
final oracleSpeechServiceProvider = OracleSpeechServiceProvider._();

final class OracleSpeechServiceProvider
    extends
        $FunctionalProvider<
          OracleSpeechService,
          OracleSpeechService,
          OracleSpeechService
        >
    with $Provider<OracleSpeechService> {
  OracleSpeechServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oracleSpeechServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oracleSpeechServiceHash();

  @$internal
  @override
  $ProviderElement<OracleSpeechService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OracleSpeechService create(Ref ref) {
    return oracleSpeechService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OracleSpeechService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OracleSpeechService>(value),
    );
  }
}

String _$oracleSpeechServiceHash() =>
    r'a3d71412014b0dc1c11f7ebccae0f7ccaed24ac8';

/// Drives the two-way Conversational Voice Oracle:
/// idle → listening → synthesizing → speaking → (hands-free) listening …

@ProviderFor(OracleDialogueNotifier)
final oracleDialogueProvider = OracleDialogueNotifierProvider._();

/// Drives the two-way Conversational Voice Oracle:
/// idle → listening → synthesizing → speaking → (hands-free) listening …
final class OracleDialogueNotifierProvider
    extends $NotifierProvider<OracleDialogueNotifier, OracleDialogueViewState> {
  /// Drives the two-way Conversational Voice Oracle:
  /// idle → listening → synthesizing → speaking → (hands-free) listening …
  OracleDialogueNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oracleDialogueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oracleDialogueNotifierHash();

  @$internal
  @override
  OracleDialogueNotifier create() => OracleDialogueNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OracleDialogueViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OracleDialogueViewState>(value),
    );
  }
}

String _$oracleDialogueNotifierHash() =>
    r'5151474e27cef8144abd24bb7c653156ee08b756';

/// Drives the two-way Conversational Voice Oracle:
/// idle → listening → synthesizing → speaking → (hands-free) listening …

abstract class _$OracleDialogueNotifier
    extends $Notifier<OracleDialogueViewState> {
  OracleDialogueViewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<OracleDialogueViewState, OracleDialogueViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OracleDialogueViewState, OracleDialogueViewState>,
              OracleDialogueViewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
