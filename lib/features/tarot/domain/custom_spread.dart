import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_spread.freezed.dart';
part 'custom_spread.g.dart';

@freezed
abstract class CustomSpread with _$CustomSpread {
  const factory CustomSpread({
    required String id,
    required String title,
    required String description,
    required List<String> positions,
    @Default('custom') String layoutType,
    @Default(true) bool isUserCreated,
  }) = _CustomSpread;

  factory CustomSpread.fromJson(Map<String, dynamic> json) =>
      _$CustomSpreadFromJson(json);
}
