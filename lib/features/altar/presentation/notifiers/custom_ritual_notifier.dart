import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/sensory_service.dart';
import '../../domain/seeker_ritual_spell.dart';
import 'custom_ritual_state.dart';

part 'custom_ritual_notifier.g.dart';

const String _prefCustomSpellsKey = 'oraculum_custom_ritual_spells';

@Riverpod(keepAlive: true)
class CustomRitualNotifier extends _$CustomRitualNotifier {
  late SensoryService _sensory;

  @override
  CustomRitualState build() {
    _sensory = ref.watch(sensoryServiceProvider);
    _loadCustomSpells();
    return const CustomRitualState();
  }

  Future<void> _loadCustomSpells() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedJson = prefs.getString(_prefCustomSpellsKey);
      if (savedJson != null) {
        final List<dynamic> decoded = jsonDecode(savedJson) as List<dynamic>;
        final spells = decoded
            .map((item) => SeekerRitualSpell.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(customSpells: spells);
      }
    } catch (_) {}
  }

  Future<void> saveCustomSpell(SeekerRitualSpell spell) async {
    _sensory.cardSelectionHaptic();
    final current = List<SeekerRitualSpell>.from(state.customSpells);
    final existingIdx = current.indexWhere((s) => s.id == spell.id);
    if (existingIdx != -1) {
      current[existingIdx] = spell;
    } else {
      current.insert(0, spell);
    }

    state = state.copyWith(customSpells: current);
    await _persistSpells(current);
  }

  Future<void> deleteCustomSpell(String spellId) async {
    _sensory.cardSelectionHaptic();
    final updated = state.customSpells.where((s) => s.id != spellId).toList();
    state = state.copyWith(customSpells: updated);
    await _persistSpells(updated);
  }

  Future<void> _persistSpells(List<SeekerRitualSpell> spells) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(spells.map((s) => s.toJson()).toList());
      await prefs.setString(_prefCustomSpellsKey, encoded);
    } catch (_) {}
  }

  /// Begins orchestrating a ritual spell execution runner.
  void startSpellExecution(SeekerRitualSpell spell) {
    _sensory.lightImpact();
    state = state.copyWith(
      activeRunningSpell: spell,
      activeStepIndex: 0,
      isRunning: true,
      isCompleted: false,
      stepProgress: 0.0,
    );
  }

  /// Updates progress of the active step (0.0 to 1.0).
  void updateStepProgress(double progress) {
    state = state.copyWith(stepProgress: progress.clamp(0.0, 1.0));
  }

  /// Advances to next step in the ritual spell or completes.
  void advanceStep() {
    _sensory.mediumImpact();
    if (state.activeRunningSpell == null) return;

    final nextIndex = state.activeStepIndex + 1;
    if (nextIndex >= state.activeRunningSpell!.steps.length) {
      _sensory.heavyImpact();
      state = state.copyWith(
        isRunning: false,
        isCompleted: true,
        stepProgress: 1.0,
      );
    } else {
      state = state.copyWith(
        activeStepIndex: nextIndex,
        stepProgress: 0.0,
      );
    }
  }

  /// Stops and cancels the active spell runner.
  void cancelExecution() {
    _sensory.lightImpact();
    state = state.copyWith(
      activeRunningSpell: null,
      activeStepIndex: 0,
      isRunning: false,
      isCompleted: false,
      stepProgress: 0.0,
    );
  }
}
