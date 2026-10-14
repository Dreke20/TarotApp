import 'package:freezed_annotation/freezed_annotation.dart';

part 'rune.freezed.dart';
part 'rune.g.dart';

@freezed
abstract class Rune with _$Rune {
  const factory Rune({
    required String id,
    required String name,
    required String symbol,
    required String englishMeaning,
    required String aett,
    required String uprightMeaning,
    required String reversedMeaning,
    @Default(false) bool isReversed,
    String? positionName,
  }) = _Rune;

  factory Rune.fromJson(Map<String, dynamic> json) => _$RuneFromJson(json);
}
