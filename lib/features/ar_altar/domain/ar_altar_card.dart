import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tarot/domain/tarot_card.dart';

part 'ar_altar_card.freezed.dart';

/// A card resting on the projected AR mandala at a fixed spread slot.
@freezed
abstract class ArAltarCard with _$ArAltarCard {
  const factory ArAltarCard({
    required String id,
    required TarotCard card,
    required int slotIndex,
    required String positionName,
    required DateTime placedAt,
    @Default(false) bool isRevealed,
  }) = _ArAltarCard;
}

/// Device orientation relative to where the mandala was anchored (radians).
@freezed
abstract class ArPose with _$ArPose {
  const factory ArPose({
    @Default(0.0) double yaw,
    @Default(0.0) double pitch,
  }) = _ArPose;
}

/// Supported AR spreads and their position names.
enum ArSpread {
  single(<String>['Guidance']),
  threeCard(<String>['Past', 'Present', 'Future']),
  cross(<String>['Present', 'Challenge', 'Root', 'Horizon', 'Outcome']);

  const ArSpread(this.positions);
  final List<String> positions;

  int get size => positions.length;

  String get label => switch (this) {
        ArSpread.single => '1 CARD',
        ArSpread.threeCard => '3 CARDS',
        ArSpread.cross => 'CROSS',
      };
}
