// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DreamNotifier)
final dreamProvider = DreamNotifierProvider._();

final class DreamNotifierProvider
    extends $NotifierProvider<DreamNotifier, List<DreamEntry>> {
  DreamNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dreamNotifierHash();

  @$internal
  @override
  DreamNotifier create() => DreamNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<DreamEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<DreamEntry>>(value),
    );
  }
}

String _$dreamNotifierHash() => r'bde426b022f76e951b0f5a88f6454d6fa2c12800';

abstract class _$DreamNotifier extends $Notifier<List<DreamEntry>> {
  List<DreamEntry> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<DreamEntry>, List<DreamEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<DreamEntry>, List<DreamEntry>>,
              List<DreamEntry>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
