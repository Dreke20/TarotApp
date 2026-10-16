// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReadingNotifier)
final readingProvider = ReadingNotifierProvider._();

final class ReadingNotifierProvider
    extends $NotifierProvider<ReadingNotifier, ReadingState> {
  ReadingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingNotifierHash();

  @$internal
  @override
  ReadingNotifier create() => ReadingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReadingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReadingState>(value),
    );
  }
}

String _$readingNotifierHash() => r'fdaf9cfb743edb9a97f8e3676e507fcea6f20c7e';

abstract class _$ReadingNotifier extends $Notifier<ReadingState> {
  ReadingState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReadingState, ReadingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReadingState, ReadingState>,
              ReadingState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
