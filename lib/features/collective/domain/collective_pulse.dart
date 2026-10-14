import 'package:freezed_annotation/freezed_annotation.dart';

part 'collective_pulse.freezed.dart';
part 'collective_pulse.g.dart';

@freezed
abstract class CollectiveWish with _$CollectiveWish {
  const factory CollectiveWish({
    required String id,
    required String intention,
    required String zodiacSign,
    required DateTime createdAt,
  }) = _CollectiveWish;

  factory CollectiveWish.fromJson(Map<String, dynamic> json) =>
      _$CollectiveWishFromJson(json);
}

@freezed
abstract class CollectivePulse with _$CollectivePulse {
  const factory CollectivePulse({
    required String dominantGlobalCardName,
    required String dominantCardArcana,
    required String dominantAuraEnergy,
    required int totalReadingsToday,
    required List<String> topDrawnCards,
    required List<CollectiveWish> recentWishes,
  }) = _CollectivePulse;

  factory CollectivePulse.fromJson(Map<String, dynamic> json) =>
      _$CollectivePulseFromJson(json);
}
