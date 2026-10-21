// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_style_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeckStyleNotifier)
final deckStyleProvider = DeckStyleNotifierProvider._();

final class DeckStyleNotifierProvider
    extends $NotifierProvider<DeckStyleNotifier, CardDeckStyle> {
  DeckStyleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckStyleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckStyleNotifierHash();

  @$internal
  @override
  DeckStyleNotifier create() => DeckStyleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CardDeckStyle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CardDeckStyle>(value),
    );
  }
}

String _$deckStyleNotifierHash() => r'310edea93dfeb74dfc85e17dc670b0a3649011a0';

abstract class _$DeckStyleNotifier extends $Notifier<CardDeckStyle> {
  CardDeckStyle build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CardDeckStyle, CardDeckStyle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CardDeckStyle, CardDeckStyle>,
              CardDeckStyle,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
