import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/encrypted_vault_storage.dart';
import '../domain/celestial_bazaar_models.dart';

/// Storage service persisting bazaar unlocks, active candles, and shard balances.
class CelestialBazaarStorage {
  CelestialBazaarStorage._();
  static final CelestialBazaarStorage instance = CelestialBazaarStorage._();

  static const String _prefShardsKey = 'oraculum_starlight_tokens';
  static const String _prefCandlesKey = 'oraculum_active_sanctuary_candles';
  static const String _prefUnlockedFoilsKey = 'oraculum_unlocked_foil_finishes';
  static const String _prefEquippedFoilKey = 'oraculum_equipped_foil_finish';
  static const String _prefUnlockedDecksKey = 'oraculum_unlocked_collector_decks';
  static const String _prefSynastryDossiersKey = 'oraculum_synastry_dossiers';

  /// Fetches cryptographically verified Starlight Shard count.
  Future<int> getShards() async {
    try {
      return await EncryptedVaultStorage.instance.getSignedInt(_prefShardsKey);
    } catch (_) {
      return 0;
    }
  }

  /// Saves updated Starlight Shard count with HMAC verification.
  Future<void> setShards(int count) async {
    try {
      await EncryptedVaultStorage.instance.setSignedInt(_prefShardsKey, count);
    } catch (e) {
      debugPrint('[BazaarStorage] Error setting shards: $e');
    }
  }

  /// Loads currently active intention candles, purging expired ones.
  Future<List<ActiveSanctuaryCandle>> getActiveCandles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefCandlesKey);
      if (raw == null || raw.isEmpty) return const [];

      final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
      final candles = list
          .map((item) => ActiveSanctuaryCandle.fromJson(item as Map<String, dynamic>))
          .where((candle) => candle.isLit)
          .toList();

      return candles;
    } catch (e) {
      debugPrint('[BazaarStorage] Error loading candles: $e');
      return const [];
    }
  }

  /// Persists the active candles list.
  Future<void> saveActiveCandles(List<ActiveSanctuaryCandle> candles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final activeList = candles.where((c) => c.isLit).toList();
      final jsonStr = jsonEncode(activeList.map((c) => c.toJson()).toList());
      await prefs.setString(_prefCandlesKey, jsonStr);
    } catch (e) {
      debugPrint('[BazaarStorage] Error saving candles: $e');
    }
  }

  /// Gets the set of unlocked foil finish IDs.
  Future<Set<String>> getUnlockedFoils() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_prefUnlockedFoilsKey) ?? [CardFoilFinish.standard.id];
      return list.toSet();
    } catch (_) {
      return {CardFoilFinish.standard.id};
    }
  }

  /// Adds an unlocked foil finish.
  Future<void> unlockFoil(String foilId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_prefUnlockedFoilsKey) ?? [CardFoilFinish.standard.id];
      if (!list.contains(foilId)) {
        list.add(foilId);
        await prefs.setStringList(_prefUnlockedFoilsKey, list);
      }
    } catch (e) {
      debugPrint('[BazaarStorage] Error unlocking foil: $e');
    }
  }

  /// Gets the currently equipped foil finish ID.
  Future<String> getEquippedFoil() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_prefEquippedFoilKey) ?? CardFoilFinish.standard.id;
    } catch (_) {
      return CardFoilFinish.standard.id;
    }
  }

  /// Sets the currently equipped foil finish ID.
  Future<void> setEquippedFoil(String foilId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefEquippedFoilKey, foilId);
    } catch (e) {
      debugPrint('[BazaarStorage] Error equipping foil: $e');
    }
  }

  /// Gets unlocked collector decks.
  Future<Set<String>> getUnlockedDecks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_prefUnlockedDecksKey) ?? [];
      return list.toSet();
    } catch (_) {
      return {};
    }
  }

  /// Adds an unlocked collector deck.
  Future<void> unlockDeck(String deckId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_prefUnlockedDecksKey) ?? [];
      if (!list.contains(deckId)) {
        list.add(deckId);
        await prefs.setStringList(_prefUnlockedDecksKey, list);
      }
    } catch (e) {
      debugPrint('[BazaarStorage] Error unlocking deck: $e');
    }
  }

  /// Loads saved synastry dossiers.
  Future<List<SynastryDossier>> getSynastryDossiers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefSynastryDossiersKey);
      if (raw == null || raw.isEmpty) return const [];
      final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((item) => SynastryDossier.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('[BazaarStorage] Error loading synastry dossiers: $e');
      return const [];
    }
  }

  /// Saves a newly generated synastry dossier.
  Future<void> saveSynastryDossier(SynastryDossier dossier) async {
    try {
      final existing = await getSynastryDossiers();
      final updated = [dossier, ...existing.where((d) => d.id != dossier.id)];
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(updated.map((d) => d.toJson()).toList());
      await prefs.setString(_prefSynastryDossiersKey, jsonStr);
    } catch (e) {
      debugPrint('[BazaarStorage] Error saving synastry dossier: $e');
    }
  }
}
