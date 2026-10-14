import 'package:freezed_annotation/freezed_annotation.dart';

part 'hexagram.freezed.dart';
part 'hexagram.g.dart';

@freezed
abstract class Hexagram with _$Hexagram {
  const factory Hexagram({
    required int number,
    required String name,
    required String englishTitle,
    required String chineseCharacter,
    required String upperTrigram,
    required String lowerTrigram,
    required List<int> lines, // 6 binary lines: 1 = Yang (solid), 0 = Yin (broken) from bottom to top
    required String judgment,
    required String image,
    required String guidance,
  }) = _Hexagram;

  factory Hexagram.fromJson(Map<String, dynamic> json) =>
      _$HexagramFromJson(json);
}
