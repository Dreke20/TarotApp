// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oracle_dialogue_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OracleDialogueMessage _$OracleDialogueMessageFromJson(
  Map<String, dynamic> json,
) => _OracleDialogueMessage(
  id: json['id'] as String,
  sender: $enumDecode(_$DialogueSenderEnumMap, json['sender']),
  text: json['text'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  referencedCard: json['referencedCard'] == null
      ? null
      : TarotCard.fromJson(json['referencedCard'] as Map<String, dynamic>),
  personaId: json['personaId'] as String?,
  isSpoken: json['isSpoken'] as bool? ?? false,
);

Map<String, dynamic> _$OracleDialogueMessageToJson(
  _OracleDialogueMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender': _$DialogueSenderEnumMap[instance.sender]!,
  'text': instance.text,
  'timestamp': instance.timestamp.toIso8601String(),
  'referencedCard': instance.referencedCard,
  'personaId': instance.personaId,
  'isSpoken': instance.isSpoken,
};

const _$DialogueSenderEnumMap = {
  DialogueSender.seeker: 'seeker',
  DialogueSender.oracle: 'oracle',
};
