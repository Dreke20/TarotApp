// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_back_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CardBackNotifier)
final cardBackProvider = CardBackNotifierProvider._();

final class CardBackNotifierProvider
    extends $NotifierProvider<CardBackNotifier, CardBackDesign> {
  CardBackNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cardBackProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cardBackNotifierHash();

  @$internal
  @override
  CardBackNotifier create() => CardBackNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CardBackDesign value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CardBackDesign>(value),
    );
  }
}

String _$cardBackNotifierHash() => r'c8bee39bf8a80223e024a5a70833acad2fbbdfe7';

abstract class _$CardBackNotifier extends $Notifier<CardBackDesign> {
  CardBackDesign build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CardBackDesign, CardBackDesign>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CardBackDesign, CardBackDesign>,
              CardBackDesign,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
