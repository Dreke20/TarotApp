// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astral_circle_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AstralCardPlacement _$AstralCardPlacementFromJson(Map<String, dynamic> json) =>
    _AstralCardPlacement(
      cardId: json['cardId'] as String,
      positionIndex: (json['positionIndex'] as num).toInt(),
      isReversed: json['isReversed'] as bool? ?? false,
      placedBy: $enumDecode(_$AstralParticipantRoleEnumMap, json['placedBy']),
      placedByName: json['placedByName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AstralCardPlacementToJson(
  _AstralCardPlacement instance,
) => <String, dynamic>{
  'cardId': instance.cardId,
  'positionIndex': instance.positionIndex,
  'isReversed': instance.isReversed,
  'placedBy': _$AstralParticipantRoleEnumMap[instance.placedBy]!,
  'placedByName': instance.placedByName,
  'timestamp': instance.timestamp.toIso8601String(),
};

const _$AstralParticipantRoleEnumMap = {
  AstralParticipantRole.host: 'host',
  AstralParticipantRole.guest: 'guest',
};

_AstralCircleSession _$AstralCircleSessionFromJson(
  Map<String, dynamic> json,
) => _AstralCircleSession(
  id: json['id'] as String,
  roomCode: json['roomCode'] as String,
  hostId: json['hostId'] as String,
  hostName: json['hostName'] as String,
  guestId: json['guestId'] as String?,
  guestName: json['guestName'] as String?,
  spreadType: json['spreadType'] as String? ?? 'threeCard',
  drawnCards:
      (json['drawnCards'] as List<dynamic>?)
          ?.map((e) => AstralCardPlacement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  activeTurn:
      $enumDecodeNullable(_$AstralParticipantRoleEnumMap, json['activeTurn']) ??
      AstralParticipantRole.host,
  oracleSynthesis: json['oracleSynthesis'] as String?,
  status:
      $enumDecodeNullable(_$AstralCircleStatusEnumMap, json['status']) ??
      AstralCircleStatus.waiting,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AstralCircleSessionToJson(
  _AstralCircleSession instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomCode': instance.roomCode,
  'hostId': instance.hostId,
  'hostName': instance.hostName,
  'guestId': instance.guestId,
  'guestName': instance.guestName,
  'spreadType': instance.spreadType,
  'drawnCards': instance.drawnCards,
  'activeTurn': _$AstralParticipantRoleEnumMap[instance.activeTurn]!,
  'oracleSynthesis': instance.oracleSynthesis,
  'status': _$AstralCircleStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$AstralCircleStatusEnumMap = {
  AstralCircleStatus.waiting: 'waiting',
  AstralCircleStatus.active: 'active',
  AstralCircleStatus.completed: 'completed',
};
