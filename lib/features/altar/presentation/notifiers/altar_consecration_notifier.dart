import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/sensory_service.dart';
import '../../domain/altar_consecration_state.dart';
import '../../domain/altar_crystal.dart';
import '../../domain/sacred_herb.dart';

part 'altar_consecration_notifier.g.dart';

const String _prefHerbKey = 'oraculum_active_herb';
const String _prefPurifiedKey = 'oraculum_altar_is_purified';
const String _prefPurifiedAtKey = 'oraculum_altar_purified_at';
const String _prefCrystalsKey = 'oraculum_altar_placed_crystals';

@Riverpod(keepAlive: true)
class AltarConsecrationNotifier extends _$AltarConsecrationNotifier {
  late SensoryService _sensory;

  @override
  AltarConsecrationState build() {
    _sensory = ref.watch(sensoryServiceProvider);
    _loadPersistedState();
    return const AltarConsecrationState();
  }

  Future<void> _loadPersistedState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final herbId = prefs.getString(_prefHerbKey);
      final isPurified = prefs.getBool(_prefPurifiedKey) ?? false;
      final purifiedAtStr = prefs.getString(_prefPurifiedAtKey);
      final crystalsJson = prefs.getString(_prefCrystalsKey);

      SacredHerb activeHerb = state.activeHerb;
      if (herbId != null) {
        activeHerb = SacredHerb.fromId(herbId);
      }

      DateTime? lastPurifiedAt;
      if (purifiedAtStr != null) {
        lastPurifiedAt = DateTime.tryParse(purifiedAtStr);
      }

      Map<String, String> placedCrystals = Map<String, String>.from(state.placedCrystals);
      if (crystalsJson != null) {
        final decoded = jsonDecode(crystalsJson) as Map<String, dynamic>;
        placedCrystals = decoded.map((k, v) => MapEntry(k, v.toString()));
      }

      state = state.copyWith(
        activeHerb: activeHerb,
        isPurified: isPurified,
        purificationProgress: isPurified ? 1.0 : 0.0,
        lastPurifiedAt: lastPurifiedAt,
        placedCrystals: placedCrystals,
      );
    } catch (_) {}
  }

  /// Sets the active smudge herb or incense.
  Future<void> selectHerb(SacredHerb herb) async {
    state = state.copyWith(activeHerb: herb);
    _sensory.cardSelectionHaptic();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefHerbKey, herb.id);
    } catch (_) {}
  }

  /// Increments progress as user wafts smoke across the altar.
  void addWaftingProgress(double delta) {
    if (state.isPurified) return;

    final newProgress = (state.purificationProgress + delta).clamp(0.0, 1.0);
    _sensory.smokeCrackleHaptic();

    if (newProgress >= 1.0) {
      completePurification();
    } else {
      state = state.copyWith(purificationProgress: newProgress);
    }
  }

  /// Consecrates and marks the altar as fully purified.
  Future<void> completePurification() async {
    final now = DateTime.now();
    state = state.copyWith(
      isPurified: true,
      purificationProgress: 1.0,
      lastPurifiedAt: now,
    );
    _sensory.altarPurifiedHaptic();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefPurifiedKey, true);
      await prefs.setString(_prefPurifiedAtKey, now.toIso8601String());
    } catch (_) {}
  }

  /// Resets purification state for a fresh ritual cleansing.
  Future<void> resetPurification() async {
    state = state.copyWith(
      isPurified: false,
      purificationProgress: 0.0,
    );
    _sensory.shuffleHaptic();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefPurifiedKey, false);
    } catch (_) {}
  }

  /// Assigns a guardian crystal to a specific grid corner.
  Future<void> placeCrystal(GridCorner corner, AltarCrystal crystal) async {
    final updated = Map<String, String>.from(state.placedCrystals);
    updated[corner.name] = crystal.id;
    state = state.copyWith(placedCrystals: updated);
    _sensory.crystalPlacementHaptic();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefCrystalsKey, jsonEncode(updated));
    } catch (_) {}
  }

  /// Clears a crystal from a specific corner.
  Future<void> removeCrystal(GridCorner corner) async {
    final updated = Map<String, String>.from(state.placedCrystals);
    updated.remove(corner.name);
    state = state.copyWith(placedCrystals: updated);
    _sensory.cardSelectionHaptic();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefCrystalsKey, jsonEncode(updated));
    } catch (_) {}
  }
}

/// Backward compatibility alias for altarConsecrationProvider
final altarConsecrationNotifierProvider = altarConsecrationProvider;
