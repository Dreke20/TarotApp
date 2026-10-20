import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tarot/domain/tarot_card.dart';

part 'tarot_lens_scan_result.freezed.dart';
part 'tarot_lens_scan_result.g.dart';

@freezed
abstract class TarotLensScanResult with _$TarotLensScanResult {
  const factory TarotLensScanResult({
    required TarotCard card,
    @Default(96) int confidencePercent,
    @Default(false) bool isReversed,
    @Default([]) List<String> detectedSymbols,
    required String scryingAnalysis,
    required String physicalAltarRitual,
    String? capturedImagePath,
    @Default(true) bool isHighConfidence,
  }) = _TarotLensScanResult;

  factory TarotLensScanResult.fromJson(Map<String, dynamic> json) =>
      _$TarotLensScanResultFromJson(json);
}
