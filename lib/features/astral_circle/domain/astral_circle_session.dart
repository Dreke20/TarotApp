import 'package:freezed_annotation/freezed_annotation.dart';

part 'astral_circle_session.freezed.dart';
part 'astral_circle_session.g.dart';

/// Participant role inside the shared sacred circle.
enum AstralParticipantRole {
  @JsonValue('host')
  host,
  @JsonValue('guest')
  guest,
}

/// Status of the shared circle reading session.
enum AstralCircleStatus {
  @JsonValue('waiting')
  waiting,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

/// Record of a card drawn and placed upon the shared altar.
@freezed
abstract class AstralCardPlacement with _$AstralCardPlacement {
  const factory AstralCardPlacement({
    required String cardId,
    required int positionIndex,
    @Default(false) bool isReversed,
    required AstralParticipantRole placedBy,
    required String placedByName,
    required DateTime timestamp,
  }) = _AstralCardPlacement;

  factory AstralCardPlacement.fromJson(Map<String, dynamic> json) =>
      _$AstralCardPlacementFromJson(json);
}

/// A real-time synchronized multiplayer tarot session between two seekers.
@freezed
abstract class AstralCircleSession with _$AstralCircleSession {
  const factory AstralCircleSession({
    required String id,
    required String roomCode,
    required String hostId,
    required String hostName,
    String? guestId,
    String? guestName,
    @Default('threeCard') String spreadType,
    @Default([]) List<AstralCardPlacement> drawnCards,
    @Default(AstralParticipantRole.host) AstralParticipantRole activeTurn,
    String? oracleSynthesis,
    @Default(AstralCircleStatus.waiting) AstralCircleStatus status,
    required DateTime createdAt,
  }) = _AstralCircleSession;

  factory AstralCircleSession.fromJson(Map<String, dynamic> json) =>
      _$AstralCircleSessionFromJson(json);
}
