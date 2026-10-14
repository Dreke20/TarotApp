import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_entry.freezed.dart';
part 'dream_entry.g.dart';

@freezed
abstract class DreamEntry with _$DreamEntry {
  const factory DreamEntry({
    required String id,
    required DateTime recordedAt,
    required String title,
    required String narrative,
    required String mood,
    @Default([]) List<String> symbols,
    String? jungianAnalysis,
    String? correlatedTarotCardId,
    String? correlatedTarotCardName,
    String? archetypalMessage,
  }) = _DreamEntry;

  factory DreamEntry.fromJson(Map<String, dynamic> json) =>
      _$DreamEntryFromJson(json);
}
