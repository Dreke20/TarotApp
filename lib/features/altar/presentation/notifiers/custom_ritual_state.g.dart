// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_ritual_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomRitualState _$CustomRitualStateFromJson(Map<String, dynamic> json) =>
    _CustomRitualState(
      customSpells:
          (json['customSpells'] as List<dynamic>?)
              ?.map(
                (e) => SeekerRitualSpell.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      activeRunningSpell: json['activeRunningSpell'] == null
          ? null
          : SeekerRitualSpell.fromJson(
              json['activeRunningSpell'] as Map<String, dynamic>,
            ),
      activeStepIndex: (json['activeStepIndex'] as num?)?.toInt() ?? 0,
      isRunning: json['isRunning'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      stepProgress: (json['stepProgress'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$CustomRitualStateToJson(_CustomRitualState instance) =>
    <String, dynamic>{
      'customSpells': instance.customSpells,
      'activeRunningSpell': instance.activeRunningSpell,
      'activeStepIndex': instance.activeStepIndex,
      'isRunning': instance.isRunning,
      'isCompleted': instance.isCompleted,
      'stepProgress': instance.stepProgress,
    };
