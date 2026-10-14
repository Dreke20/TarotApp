import 'package:freezed_annotation/freezed_annotation.dart';

part 'natal_chart.freezed.dart';
part 'natal_chart.g.dart';

@freezed
abstract class PlanetPlacement with _$PlanetPlacement {
  const factory PlanetPlacement({
    required String planet,
    required String symbol,
    required String sign,
    required String element,
    required String house,
    required String meaning,
    required String tarotCorrelation,
  }) = _PlanetPlacement;

  factory PlanetPlacement.fromJson(Map<String, dynamic> json) =>
      _$PlanetPlacementFromJson(json);
}

@freezed
abstract class NatalChart with _$NatalChart {
  const factory NatalChart({
    required String sunSign,
    required String moonSign,
    required String risingSign,
    required List<PlanetPlacement> placements,
    required double firePercent,
    required double earthPercent,
    required double airPercent,
    required double waterPercent,
    required String dominantElement,
    required String soulArchetype,
  }) = _NatalChart;

  factory NatalChart.fromJson(Map<String, dynamic> json) =>
      _$NatalChartFromJson(json);
}
