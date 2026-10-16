import 'package:freezed_annotation/freezed_annotation.dart';
import 'altar_crystal.dart';
import 'sacred_herb.dart';

part 'altar_consecration_state.freezed.dart';
part 'altar_consecration_state.g.dart';

@freezed
abstract class AltarConsecrationState with _$AltarConsecrationState {
  const factory AltarConsecrationState({
    @Default(SacredHerb.paloSanto) SacredHerb activeHerb,
    @Default(false) bool isPurified,
    @Default(0.0) double purificationProgress,
    @Default({
      'topLeft': 'clear_quartz',
      'topRight': 'amethyst',
      'bottomLeft': 'black_tourmaline',
      'bottomRight': 'citrine',
    })
    Map<String, String> placedCrystals,
    DateTime? lastPurifiedAt,
  }) = _AltarConsecrationState;

  const AltarConsecrationState._();

  factory AltarConsecrationState.fromJson(Map<String, dynamic> json) =>
      _$AltarConsecrationStateFromJson(json);

  /// Retrieves the crystal assigned to a specific grid corner.
  AltarCrystal? crystalAt(GridCorner corner) {
    final crystalId = placedCrystals[corner.name] ?? placedCrystals[corner.id];
    if (crystalId == null) return null;
    return AltarCrystal.fromId(crystalId);
  }

  /// Whether the altar is fully purified and surrounded by a 4-stone grid.
  bool get isFullyConsecrated => isPurified && placedCrystals.length >= 4;

  /// Summary phrase of the current altar consecration for prompt injection and UI chips.
  String get summaryText {
    final stones = [
      crystalAt(GridCorner.topLeft)?.name,
      crystalAt(GridCorner.topRight)?.name,
      crystalAt(GridCorner.bottomLeft)?.name,
      crystalAt(GridCorner.bottomRight)?.name,
    ].whereType<String>().join(', ');

    if (!isPurified) {
      return 'Altar awaiting sacred smoke purification.';
    }
    return '${activeHerb.name} smoke purification active. Guardian grid: $stones.';
  }
}
