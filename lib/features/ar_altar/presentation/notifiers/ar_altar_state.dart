import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/ar_altar_card.dart';

part 'ar_altar_state.freezed.dart';

@freezed
abstract class ArAltarState with _$ArAltarState {
  const factory ArAltarState({
    @Default(<ArAltarCard>[]) List<ArAltarCard> cards,
    @Default(ArSpread.threeCard) ArSpread spread,
    @Default(false) bool isMandalaAnchored,
    @Default(false) bool isDealing,
    @Default(false) bool isCameraReady,
    @Default(false) bool isCameraStarting,
    String? cameraError,
    String? selectedCardId,
  }) = _ArAltarState;

  const ArAltarState._();

  bool get allRevealed => cards.isNotEmpty && cards.every((ArAltarCard c) => c.isRevealed);

  ArAltarCard? get selectedCard {
    for (final ArAltarCard c in cards) {
      if (c.id == selectedCardId) return c;
    }
    return null;
  }
}
