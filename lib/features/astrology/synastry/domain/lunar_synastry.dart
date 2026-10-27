import 'package:freezed_annotation/freezed_annotation.dart';

part 'lunar_synastry.freezed.dart';
part 'lunar_synastry.g.dart';

/// Partner profile containing astrological placements and soul archetype.
@freezed
abstract class SynastryPartner with _$SynastryPartner {
  const factory SynastryPartner({
    required String name,
    required DateTime birthDate,
    required String sunSign,
    required String moonSign,
    required String risingSign,
    required String dominantElement,
    required int soulCardNumber,
    required String soulCardName,
  }) = _SynastryPartner;

  factory SynastryPartner.fromJson(Map<String, dynamic> json) =>
      _$SynastryPartnerFromJson(json);
}

/// A specific planetary aspect and energetic bond between two charts.
@freezed
abstract class SynastryAspect with _$SynastryAspect {
  const factory SynastryAspect({
    required String title,
    required String placementA,
    required String placementB,
    required String aspectType,
    required int harmonyStars, // 1 to 5
    required String dynamicDescription,
    required String tarotTalisman,
  }) = _SynastryAspect;

  factory SynastryAspect.fromJson(Map<String, dynamic> json) =>
      _$SynastryAspectFromJson(json);
}

/// Complete synthesized Lunar Synastry reading.
@freezed
abstract class LunarSynastryReading with _$LunarSynastryReading {
  const factory LunarSynastryReading({
    required SynastryPartner partnerA,
    required SynastryPartner partnerB,
    required int compatibilityScore, // 0 - 100
    required String bondTitle,
    required String relationshipArchetype,
    required String elementalConfluence,
    required String elementalDynamic,
    required double elementalBalancePercent,
    required String moonPhaseSynergy,
    required List<SynastryAspect> aspects,
    required String karmicLesson,
    required String soulChallenge,
    required String sacredRitual,
    required String oracleProphecy,
  }) = _LunarSynastryReading;

  factory LunarSynastryReading.fromJson(Map<String, dynamic> json) =>
      _$LunarSynastryReadingFromJson(json);
}
