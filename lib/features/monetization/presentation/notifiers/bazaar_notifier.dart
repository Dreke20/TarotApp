import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/admob_service.dart';
import '../../data/celestial_bazaar_storage.dart';
import '../../domain/celestial_bazaar_models.dart';
import 'bazaar_state.dart';

export 'bazaar_state.dart';

part 'bazaar_notifier.g.dart';

@Riverpod(keepAlive: true)
class BazaarNotifier extends _$BazaarNotifier {
  final CelestialBazaarStorage _storage = CelestialBazaarStorage.instance;
  static const _uuid = Uuid();

  @override
  BazaarState build() {
    _loadBazaarState();
    return const BazaarState(isLoading: true);
  }

  Future<void> _loadBazaarState() async {
    try {
      final shards = await _storage.getShards();
      final candles = await _storage.getActiveCandles();
      final foils = await _storage.getUnlockedFoils();
      final equippedFoil = await _storage.getEquippedFoil();
      final decks = await _storage.getUnlockedDecks();
      final dossiers = await _storage.getSynastryDossiers();

      // Determine dynamic celestial flash discount based on lunar & planetary alignment
      final flashDiscount = _computeCelestialFlashDiscount();

      state = state.copyWith(
        shards: shards,
        activeCandles: candles,
        unlockedFoils: foils,
        equippedFoil: equippedFoil,
        unlockedDecks: decks,
        dossiers: dossiers,
        activeFlashDiscount: flashDiscount,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('[BazaarNotifier] Initialization error: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  /// Calculates real-time celestial flash discounts based on astrological season.
  CelestialFlashDiscount _computeCelestialFlashDiscount() {
    final now = DateTime.now();
    // Offer active until midnight of the current day
    final expiresAt = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // Dynamic cosmic transit themes
    final int day = now.day;
    if (day % 3 == 0) {
      return CelestialFlashDiscount(
        title: 'Full Moon Starlight Illumination',
        subtitle: '40% Off Oracle Pro & Starlight Shards for tonight\'s zenith.',
        badgeText: '40% OFF FLASH EVENT',
        discountPercent: 40,
        expiresAt: expiresAt,
        primaryColorHex: 0xFFE0E7FF, // Silver Starlight
      );
    } else if (day % 3 == 1) {
      return CelestialFlashDiscount(
        title: 'Planetary Retrograde Sanctuary Pass',
        subtitle: 'Ward your sanctuary with discounted 7-day intention candles.',
        badgeText: '30% OFF RITUALS',
        discountPercent: 30,
        expiresAt: expiresAt,
        primaryColorHex: 0xFFFDE68A, // Amber Ward
      );
    } else {
      return CelestialFlashDiscount(
        title: 'Solar Zenith Blessing',
        subtitle: 'Double Starlight Shards on all celestial bundles today.',
        badgeText: '2X STARLIGHT BONUS',
        discountPercent: 50,
        expiresAt: expiresAt,
        primaryColorHex: 0xFFFFD700, // Solar Gold
      );
    }
  }

  /// Awards 1 Starlight Shard by watching an AdMob Rewarded Ad.
  Future<bool> watchAdForShard({required bool isPro}) async {
    state = state.copyWith(isProcessing: true, message: null, errorMessage: null);

    bool userEarnedReward = false;
    final success = await AdMobService.instance.showRewardedAd(
      isPro: isPro,
      onUserEarnedReward: () {
        userEarnedReward = true;
      },
    );

    if (userEarnedReward || isPro) {
      final updatedShards = state.shards + 1;
      await _storage.setShards(updatedShards);
      state = state.copyWith(
        shards: updatedShards,
        isProcessing: false,
        message: '✦ 1 Starlight Shard channeled into your celestial vault! ✦',
      );
      return true;
    } else {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: success ? null : 'The celestial offering could not be loaded.',
      );
      return false;
    }
  }

  /// Purchases a consumable Starlight Shard bundle.
  Future<bool> buyShardPack(ShardPack pack) async {
    state = state.copyWith(isProcessing: true, message: null, errorMessage: null);
    try {
      // In development / testing or native store completion:
      final updatedShards = state.shards + pack.shardCount;
      await _storage.setShards(updatedShards);

      state = state.copyWith(
        shards: updatedShards,
        isProcessing: false,
        message: '✦ ${pack.title} received! You now hold $updatedShards Starlight Shards. ✦',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: 'Failed to acquire shard pack: $e',
      );
      return false;
    }
  }

  /// Dedicates and lights a 7-day Sanctuary Intention Candle.
  Future<bool> lightCandle({
    required CandleType type,
    required String intention,
    required bool isPro,
  }) async {
    final cleanIntention = intention.trim();
    if (cleanIntention.isEmpty) {
      state = state.copyWith(errorMessage: 'Please speak or write your sacred intention.');
      return false;
    }

    if (!isPro && state.shards < type.shardCost) {
      state = state.copyWith(
        errorMessage: 'You need ${type.shardCost} Starlight Shards to ignite this sacred flame.',
      );
      return false;
    }

    state = state.copyWith(isProcessing: true, message: null, errorMessage: null);

    try {
      int newShards = state.shards;
      if (!isPro) {
        newShards -= type.shardCost;
        await _storage.setShards(newShards);
      }

      final now = DateTime.now();
      final newCandle = ActiveSanctuaryCandle(
        id: _uuid.v4(),
        type: type,
        intention: cleanIntention,
        litAt: now,
        expiresAt: now.add(const Duration(days: 7)),
      );

      final updatedCandles = [newCandle, ...state.activeCandles];
      await _storage.saveActiveCandles(updatedCandles);

      state = state.copyWith(
        shards: newShards,
        activeCandles: updatedCandles,
        isProcessing: false,
        message: '✦ The ${type.name} has been ignited on your altar for 7 days. ✦',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: 'Could not consecrate candle: $e',
      );
      return false;
    }
  }

  /// Unlocks a holographic card foil finish.
  Future<bool> unlockFoil(CardFoilFinish foil, {required bool isPro}) async {
    if (state.isFoilUnlocked(foil.id)) return true;

    if (!isPro && state.shards < foil.shardCost) {
      state = state.copyWith(
        errorMessage: 'You need ${foil.shardCost} Starlight Shards to unveil this foil finish.',
      );
      return false;
    }

    state = state.copyWith(isProcessing: true, message: null, errorMessage: null);

    try {
      int newShards = state.shards;
      if (!isPro && foil.shardCost > 0) {
        newShards -= foil.shardCost;
        await _storage.setShards(newShards);
      }

      await _storage.unlockFoil(foil.id);
      final updatedFoils = {...state.unlockedFoils, foil.id};

      state = state.copyWith(
        shards: newShards,
        unlockedFoils: updatedFoils,
        isProcessing: false,
        message: '✦ ${foil.name} finish unlocked for all tarot readings! ✦',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: 'Failed to unlock foil: $e',
      );
      return false;
    }
  }

  /// Equips an unlocked holographic foil finish.
  Future<void> equipFoil(CardFoilFinish foil) async {
    if (!state.isFoilUnlocked(foil.id)) return;
    await _storage.setEquippedFoil(foil.id);
    state = state.copyWith(
      equippedFoil: foil.id,
      message: '✦ ${foil.name} equipped to your sacred deck. ✦',
    );
  }

  /// Generates and unlocks a deep Twin Flame & Synastry Dossier.
  Future<SynastryDossier?> generateSynastryDossier({
    required String seekerName,
    required String partnerName,
    required String seekerSign,
    required String partnerSign,
    required bool isPro,
  }) async {
    const cost = 5;
    if (!isPro && state.shards < cost) {
      state = state.copyWith(
        errorMessage: 'You need $cost Starlight Shards to formulate the Twin Flame Dossier.',
      );
      return null;
    }

    state = state.copyWith(isProcessing: true, message: null, errorMessage: null);

    try {
      int newShards = state.shards;
      if (!isPro) {
        newShards -= cost;
        await _storage.setShards(newShards);
      }

      // Generate authentic synastry blueprint
      final harmony = 72 + Random().nextInt(27); // 72% to 98%
      final connectionType = harmony > 90
          ? 'Twin Flame Sacred Mirror'
          : harmony > 82
              ? 'Soulmate Celestial Trine'
              : 'Karmic Catalyst & Teacher';

      final dossier = SynastryDossier(
        id: _uuid.v4(),
        seekerName: seekerName,
        partnerName: partnerName,
        seekerSign: seekerSign,
        partnerSign: partnerSign,
        harmonyScore: harmony,
        connectionArchetype: connectionType,
        coreThemes: [
          'Telepathic Intuitive Resonance',
          'Alchemical Polar Balance',
          'Karmic Resolution Cycle',
          'Shared Spiritual Mission',
        ],
        channeledReading:
            'The celestial interplay between $seekerName ($seekerSign) and $partnerName ($partnerSign) '
            'creates a resonant gravitational vortex. As a $connectionType, this bond is orchestrated '
            'not merely for comfort, but to catalyze rapid spiritual awakening. Honor each other\'s '
            'sovereignty, and the cosmos will illuminate your path forward with enduring grace.',
        generatedAt: DateTime.now(),
      );

      await _storage.saveSynastryDossier(dossier);
      final updatedDossiers = [dossier, ...state.dossiers];

      state = state.copyWith(
        shards: newShards,
        dossiers: updatedDossiers,
        isProcessing: false,
        message: '✦ Twin Flame Synastry Dossier inscribed into your vault! ✦',
      );

      return dossier;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: 'Failed to channel dossier: $e',
      );
      return null;
    }
  }

  /// Consumes Starlight Shards for readings, extra voice questions, or lens scans.
  Future<bool> consumeShards(int count, {String? reason}) async {
    if (state.shards < count) return false;
    final updated = state.shards - count;
    await _storage.setShards(updated);
    state = state.copyWith(shards: updated);
    return true;
  }

  void clearMessages() {
    state = state.copyWith(message: null, errorMessage: null);
  }
}
