import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/seeker_ritual_spell.dart';

part 'custom_ritual_state.freezed.dart';
part 'custom_ritual_state.g.dart';

@freezed
abstract class CustomRitualState with _$CustomRitualState {
  const factory CustomRitualState({
    @Default([]) List<SeekerRitualSpell> customSpells,
    SeekerRitualSpell? activeRunningSpell,
    @Default(0) int activeStepIndex,
    @Default(false) bool isRunning,
    @Default(false) bool isCompleted,
    @Default(0.0) double stepProgress,
  }) = _CustomRitualState;

  const CustomRitualState._();

  factory CustomRitualState.fromJson(Map<String, dynamic> json) =>
      _$CustomRitualStateFromJson(json);

  List<SeekerRitualSpell> get allSpells => [
        ...SeekerRitualSpell.curatedSpells,
        ...customSpells,
      ];

  RitualSpellStep? get currentStep {
    if (activeRunningSpell == null ||
        activeStepIndex < 0 ||
        activeStepIndex >= activeRunningSpell!.steps.length) {
      return null;
    }
    return activeRunningSpell!.steps[activeStepIndex];
  }
}
