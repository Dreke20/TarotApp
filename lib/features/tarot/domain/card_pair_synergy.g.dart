// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_pair_synergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardPairSynergy _$CardPairSynergyFromJson(Map<String, dynamic> json) =>
    _CardPairSynergy(
      firstCard: TarotCard.fromJson(json['firstCard'] as Map<String, dynamic>),
      secondCard: TarotCard.fromJson(
        json['secondCard'] as Map<String, dynamic>,
      ),
      alchemicalTitle: json['alchemicalTitle'] as String,
      alchemicalPhase: json['alchemicalPhase'] as String,
      element1: json['element1'] as String,
      element2: json['element2'] as String,
      elementalReaction: json['elementalReaction'] as String,
      harmonyScore: (json['harmonyScore'] as num).toInt(),
      tensionType: json['tensionType'] as String,
      synthesisInsight: json['synthesisInsight'] as String,
      actionableFormula: json['actionableFormula'] as String,
    );

Map<String, dynamic> _$CardPairSynergyToJson(_CardPairSynergy instance) =>
    <String, dynamic>{
      'firstCard': _cardToJson(instance.firstCard),
      'secondCard': _cardToJson(instance.secondCard),
      'alchemicalTitle': instance.alchemicalTitle,
      'alchemicalPhase': instance.alchemicalPhase,
      'element1': instance.element1,
      'element2': instance.element2,
      'elementalReaction': instance.elementalReaction,
      'harmonyScore': instance.harmonyScore,
      'tensionType': instance.tensionType,
      'synthesisInsight': instance.synthesisInsight,
      'actionableFormula': instance.actionableFormula,
    };
