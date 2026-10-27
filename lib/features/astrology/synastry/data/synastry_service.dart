import '../domain/lunar_synastry.dart';
import 'synastry_calculator.dart';

/// Predefined astrological partnership archetype presets.
class SynastryPreset {
  final String id;
  final String name;
  final String description;
  final String glyph;
  final SynastryPartner partnerA;
  final SynastryPartner partnerB;

  const SynastryPreset({
    required this.id,
    required this.name,
    required this.description,
    required this.glyph,
    required this.partnerA,
    required this.partnerB,
  });

  static final SynastryPreset twinFlame = SynastryPreset(
    id: 'preset_twin_flame',
    name: 'Twin Flame Sovereign Union',
    description: 'Leo Solar Radiance meeting Sagittarius Cosmic Quest',
    glyph: '🔥',
    partnerA: SynastryCalculator.createPartner(
      name: 'Seeker',
      birthDate: DateTime(1996, 8, 8),
      sunSignOverride: 'Leo',
      moonSignOverride: 'Aries',
    ),
    partnerB: SynastryCalculator.createPartner(
      name: 'Beloved',
      birthDate: DateTime(1998, 12, 12),
      sunSignOverride: 'Sagittarius',
      moonSignOverride: 'Leo',
    ),
  );

  static final SynastryPreset solLuna = SynastryPreset(
    id: 'preset_sol_luna',
    name: 'Sacred Sol-Luna Alchemy',
    description: 'Scorpio Oceanic Depth paired with Cancer Lunar Intuition',
    glyph: '🌊',
    partnerA: SynastryCalculator.createPartner(
      name: 'Seeker',
      birthDate: DateTime(1994, 11, 4),
      sunSignOverride: 'Scorpio',
      moonSignOverride: 'Pisces',
    ),
    partnerB: SynastryCalculator.createPartner(
      name: 'Beloved',
      birthDate: DateTime(1995, 7, 7),
      sunSignOverride: 'Cancer',
      moonSignOverride: 'Scorpio',
    ),
  );

  static final SynastryPreset airFire = SynastryPreset(
    id: 'preset_air_fire',
    name: 'Visionary Air & Fire Catalyst',
    description: 'Gemini Celestial Intellect igniting Aries Creative Courage',
    glyph: '⚡',
    partnerA: SynastryCalculator.createPartner(
      name: 'Seeker',
      birthDate: DateTime(1997, 6, 1),
      sunSignOverride: 'Gemini',
      moonSignOverride: 'Aquarius',
    ),
    partnerB: SynastryCalculator.createPartner(
      name: 'Partner',
      birthDate: DateTime(1999, 4, 10),
      sunSignOverride: 'Aries',
      moonSignOverride: 'Gemini',
    ),
  );

  static final SynastryPreset earthWater = SynastryPreset(
    id: 'preset_earth_water',
    name: 'Sacred Grove of Earth & Water',
    description: 'Taurus Enduring Devotion nurturing Pisces Ethereal Dreamscape',
    glyph: '🌿',
    partnerA: SynastryCalculator.createPartner(
      name: 'Seeker',
      birthDate: DateTime(1993, 5, 5),
      sunSignOverride: 'Taurus',
      moonSignOverride: 'Capricorn',
    ),
    partnerB: SynastryCalculator.createPartner(
      name: 'Beloved',
      birthDate: DateTime(1995, 3, 3),
      sunSignOverride: 'Pisces',
      moonSignOverride: 'Cancer',
    ),
  );

  static final List<SynastryPreset> allPresets = [
    twinFlame,
    solLuna,
    airFire,
    earthWater,
  ];
}

/// Service providing astrological compatibility calculations, preset generation,
/// and altar intention synthesis.
class SynastryService {
  const SynastryService();

  /// Scrys the lunar synastry connection between two partners.
  LunarSynastryReading scryConnection({
    required SynastryPartner partnerA,
    required SynastryPartner partnerB,
  }) {
    return SynastryCalculator.calculateSynastry(
      partnerA: partnerA,
      partnerB: partnerB,
    );
  }

  /// Synthesizes an altar question or intention anchor from the reading.
  String createAltarIntention(LunarSynastryReading reading) {
    return 'How can ${reading.partnerA.name} and ${reading.partnerB.name} harmonize the ${reading.bondTitle} and navigate our ${reading.elementalConfluence}?';
  }
}
