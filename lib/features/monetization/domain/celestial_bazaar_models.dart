import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'celestial_bazaar_models.freezed.dart';
part 'celestial_bazaar_models.g.dart';

/// Available consumable Starlight Shard bundles.
enum ShardPack {
  small(
    id: 'starlight_shards_small',
    shardCount: 10,
    title: '10 Starlight Shards',
    tagline: 'Novice Seeker Pouch',
    price: '\$1.99',
    bonusText: null,
  ),
  medium(
    id: 'starlight_shards_medium',
    shardCount: 30,
    title: '30 Starlight Shards',
    tagline: 'Adept Diviner Chest',
    price: '\$4.99',
    bonusText: 'MOST POPULAR · +25% BONUS',
  ),
  large(
    id: 'starlight_shards_large',
    shardCount: 75,
    title: '75 Starlight Shards',
    tagline: 'High Hierophant Vault',
    price: '\$9.99',
    bonusText: 'BEST VALUE · +60% BONUS',
  ),
  treasury(
    id: 'starlight_shards_treasury',
    shardCount: 175,
    title: '175 Starlight Shards',
    tagline: 'Sovereign Celestial Treasury',
    price: '\$19.99',
    bonusText: 'MEGA VALUE · +100% BONUS',
  );

  final String id;
  final int shardCount;
  final String title;
  final String tagline;
  final String price;
  final String? bonusText;

  const ShardPack({
    required this.id,
    required this.shardCount,
    required this.title,
    required this.tagline,
    required this.price,
    this.bonusText,
  });

  static ShardPack fromId(String id) {
    return ShardPack.values.firstWhere(
      (p) => p.id == id,
      orElse: () => ShardPack.small,
    );
  }
}

/// The 4 elemental sanctuary intention candles.
enum CandleType {
  protection(
    id: 'candle_protection',
    name: 'Solar Ward of Protection',
    element: 'Solar Fire',
    intentionPrompt: 'Ward off shadows, anxiety, and psychic intrusion.',
    glyph: '☀️',
    colorHex: 0xFFFFD700, // Solar Gold
    secondaryColorHex: 0xFFF59E0B,
    shardCost: 3,
    usdPrice: '\$0.99',
  ),
  love(
    id: 'candle_love',
    name: 'Venusian Heart & Harmony',
    element: 'Venusian Water',
    intentionPrompt: 'Attract soulful connection, self-love, and forgiveness.',
    glyph: '💖',
    colorHex: 0xFFF472B6, // Rose Quartz
    secondaryColorHex: 0xFFEC4899,
    shardCost: 3,
    usdPrice: '\$0.99',
  ),
  abundance(
    id: 'candle_abundance',
    name: 'Jupiterian Golden Fortune',
    element: 'Jupiterian Earth',
    intentionPrompt: 'Call upon prosperous opportunities and sovereign wealth.',
    glyph: '✨',
    colorHex: 0xFF34D399, // Emerald Mint
    secondaryColorHex: 0xFF059669,
    shardCost: 3,
    usdPrice: '\$0.99',
  ),
  clarity(
    id: 'candle_clarity',
    name: 'Lunar Third-Eye Insight',
    element: 'Lunar Aether',
    intentionPrompt: 'Unveil subconscious truth, clear intuition, and lucid vision.',
    glyph: '👁️',
    colorHex: 0xFFA78BFA, // Amethyst Violet
    secondaryColorHex: 0xFF7C3AED,
    shardCost: 3,
    usdPrice: '\$0.99',
  );

  final String id;
  final String name;
  final String element;
  final String intentionPrompt;
  final String glyph;
  final int colorHex;
  final int secondaryColorHex;
  final int shardCost;
  final String usdPrice;

  const CandleType({
    required this.id,
    required this.name,
    required this.element,
    required this.intentionPrompt,
    required this.glyph,
    required this.colorHex,
    required this.secondaryColorHex,
    required this.shardCost,
    required this.usdPrice,
  });

  Color get primaryColor => Color(colorHex);
  Color get secondaryColor => Color(secondaryColorHex);
}

/// An active burning intention candle dedicated in the Sanctuary Altar.
@freezed
abstract class ActiveSanctuaryCandle with _$ActiveSanctuaryCandle {
  const ActiveSanctuaryCandle._();

  const factory ActiveSanctuaryCandle({
    required String id,
    required CandleType type,
    required String intention,
    required DateTime litAt,
    required DateTime expiresAt,
  }) = _ActiveSanctuaryCandle;

  factory ActiveSanctuaryCandle.fromJson(Map<String, dynamic> json) =>
      _$ActiveSanctuaryCandleFromJson(json);

  bool get isLit => DateTime.now().isBefore(expiresAt);

  int get daysRemaining {
    final diff = expiresAt.difference(DateTime.now());
    if (diff.isNegative) return 0;
    return diff.inDays + 1;
  }
}

/// Holographic foil finish shaders available for custom card rendering.
enum CardFoilFinish {
  standard(
    id: 'foil_standard',
    name: 'Classic Velvet Matte',
    tagline: 'Original hermetic finish',
    shardCost: 0,
    price: 'Free',
    accentColor: Color(0xFFD4AF37),
    isFree: true,
  ),
  prismaticIridescent(
    id: 'foil_prismatic_iridescent',
    name: 'Prismatic Iridescent',
    tagline: 'Rainbow spectrum shimmer',
    shardCost: 8,
    price: '\$1.99',
    accentColor: Color(0xFF67E8F9),
    isFree: false,
  ),
  goldenSunburst(
    id: 'foil_golden_sunburst',
    name: '24k Golden Sunburst',
    tagline: 'Brilliant solar flare illumination',
    shardCost: 8,
    price: '\$1.99',
    accentColor: Color(0xFFFFD700),
    isFree: false,
  ),
  velvetStarlight(
    id: 'foil_velvet_starlight',
    name: 'Deep Cosmic Starlight',
    tagline: 'Galactic nebula & violet shimmer',
    shardCost: 8,
    price: '\$1.99',
    accentColor: Color(0xFFC084FC),
    isFree: false,
  );

  final String id;
  final String name;
  final String tagline;
  final int shardCost;
  final String price;
  final Color accentColor;
  final bool isFree;

  const CardFoilFinish({
    required this.id,
    required this.name,
    required this.tagline,
    required this.shardCost,
    required this.price,
    required this.accentColor,
    required this.isFree,
  });

  static CardFoilFinish fromId(String? id) {
    return CardFoilFinish.values.firstWhere(
      (f) => f.id == id,
      orElse: () => CardFoilFinish.standard,
    );
  }
}

/// An active astrological milestone flash discount event.
@freezed
abstract class CelestialFlashDiscount with _$CelestialFlashDiscount {
  const factory CelestialFlashDiscount({
    required String title,
    required String subtitle,
    required String badgeText,
    required int discountPercent,
    required DateTime expiresAt,
    required int primaryColorHex,
  }) = _CelestialFlashDiscount;

  factory CelestialFlashDiscount.fromJson(Map<String, dynamic> json) =>
      _$CelestialFlashDiscountFromJson(json);
}

/// A purchased or generated Twin Flame & Synastry Dossier.
@freezed
abstract class SynastryDossier with _$SynastryDossier {
  const factory SynastryDossier({
    required String id,
    required String seekerName,
    required String partnerName,
    required String seekerSign,
    required String partnerSign,
    required int harmonyScore,
    required String connectionArchetype,
    required String channeledReading,
    required List<String> coreThemes,
    required DateTime generatedAt,
  }) = _SynastryDossier;

  factory SynastryDossier.fromJson(Map<String, dynamic> json) =>
      _$SynastryDossierFromJson(json);
}
