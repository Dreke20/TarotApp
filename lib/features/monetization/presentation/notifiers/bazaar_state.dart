import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/celestial_bazaar_models.dart';

part 'bazaar_state.freezed.dart';

/// Immutable state for the Mystic Bazaar & Temple Treasury.
@freezed
abstract class BazaarState with _$BazaarState {
  const BazaarState._();

  const factory BazaarState({
    @Default(0) int shards,
    @Default(<ActiveSanctuaryCandle>[]) List<ActiveSanctuaryCandle> activeCandles,
    @Default(<String>{'foil_standard'}) Set<String> unlockedFoils,
    @Default('foil_standard') String equippedFoil,
    @Default(<String>{}) Set<String> unlockedDecks,
    CelestialFlashDiscount? activeFlashDiscount,
    @Default(<SynastryDossier>[]) List<SynastryDossier> dossiers,
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? message,
    String? errorMessage,
  }) = _BazaarState;

  bool isFoilUnlocked(String foilId) =>
      foilId == 'foil_standard' || unlockedFoils.contains(foilId);

  CardFoilFinish get currentFoil => CardFoilFinish.fromId(equippedFoil);
}
