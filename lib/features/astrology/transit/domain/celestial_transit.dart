import 'package:freezed_annotation/freezed_annotation.dart';

part 'celestial_transit.freezed.dart';
part 'celestial_transit.g.dart';

/// A single celestial planet or luminary currently transiting through the zodiac.
@freezed
abstract class CelestialTransitBody with _$CelestialTransitBody {
  const factory CelestialTransitBody({
    required String name,
    required String glyph,
    required String sign,
    required double degree,
    required String element,
    @Default(false) bool isRetrograde,
    @Default(1) int house,
    required String tarotArchetype,
  }) = _CelestialTransitBody;

  factory CelestialTransitBody.fromJson(Map<String, dynamic> json) =>
      _$CelestialTransitBodyFromJson(json);
}

/// An angular aspect formed between a real-time transiting planet and the seeker's natal placement.
@freezed
abstract class TransitAspect with _$TransitAspect {
  const factory TransitAspect({
    required String transitingPlanet,
    required String transitingGlyph,
    required String natalPlacement,
    required String natalGlyph,
    required String aspectType,
    required String aspectGlyph,
    required double orbDegrees,
    required bool isHarmonious,
    required String channelingGuidance,
  }) = _TransitAspect;

  factory TransitAspect.fromJson(Map<String, dynamic> json) =>
      _$TransitAspectFromJson(json);
}

/// The current classical Chaldean planetary hour and day governance.
@freezed
abstract class PlanetaryHour with _$PlanetaryHour {
  const factory PlanetaryHour({
    required String planetName,
    required String planetGlyph,
    required String dayRuler,
    required int hourIndex,
    required bool isDayHour,
    required String rulingElement,
    required String sacredVibration,
    required String consecrationMantra,
    required String recommendedSpread,
  }) = _PlanetaryHour;

  factory PlanetaryHour.fromJson(Map<String, dynamic> json) =>
      _$PlanetaryHourFromJson(json);
}

/// Complete celestial transit snapshot combining real-time sky coordinates,
/// personal natal aspects, and planetary hour alignment.
@freezed
abstract class CelestialTransitSnapshot with _$CelestialTransitSnapshot {
  const factory CelestialTransitSnapshot({
    required DateTime timestamp,
    required PlanetaryHour planetaryHour,
    required List<CelestialTransitBody> bodies,
    required List<TransitAspect> aspects,
    required String lunarPhase,
    required double lunarIllumination,
  }) = _CelestialTransitSnapshot;

  factory CelestialTransitSnapshot.fromJson(Map<String, dynamic> json) =>
      _$CelestialTransitSnapshotFromJson(json);
}
