import '../../data/ephemeris_calculator.dart';
import '../domain/lunar_synastry.dart';

/// Esoteric engine calculating astrological synastry, planetary aspects,
/// elemental confluence, and Tarot archetypal bonds between two partners.
class SynastryCalculator {
  static const List<String> _zodiacOrder = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  static const Map<String, String> _signElements = {
    'Aries': 'Fire',
    'Leo': 'Fire',
    'Sagittarius': 'Fire',
    'Taurus': 'Earth',
    'Virgo': 'Earth',
    'Capricorn': 'Earth',
    'Gemini': 'Air',
    'Libra': 'Air',
    'Aquarius': 'Air',
    'Cancer': 'Water',
    'Scorpio': 'Water',
    'Pisces': 'Water',
  };

  static const Map<int, String> _majorArcanaNames = {
    0: '0. The Fool',
    1: 'I. The Magician',
    2: 'II. The High Priestess',
    3: 'III. The Empress',
    4: 'IV. The Emperor',
    5: 'V. The Hierophant',
    6: 'VI. The Lovers',
    7: 'VII. The Chariot',
    8: 'VIII. Strength',
    9: 'IX. The Hermit',
    10: 'X. Wheel of Fortune',
    11: 'XI. Justice',
    12: 'XII. The Hanged Man',
    13: 'XIII. Death',
    14: 'XIV. Temperance',
    15: 'XV. The Devil',
    16: 'XVI. The Tower',
    17: 'XVII. The Star',
    18: 'XVIII. The Moon',
    19: 'XIX. The Sun',
    20: 'XX. Judgement',
    21: 'XXI. The World',
  };

  /// Constructs a full [SynastryPartner] from birth date or explicit signs.
  static SynastryPartner createPartner({
    required String name,
    required DateTime birthDate,
    String? sunSignOverride,
    String? moonSignOverride,
    String? risingSignOverride,
  }) {
    final String sun = sunSignOverride ?? EphemerisCalculator.getZodiacSignFromDate(birthDate);
    final int sunIndex = _zodiacOrder.indexOf(sun);
    final String moon = moonSignOverride ?? _zodiacOrder[(sunIndex + 4) % 12];
    final String rising = risingSignOverride ?? _zodiacOrder[(sunIndex + 8) % 12];
    final String element = _signElements[sun] ?? 'Fire';
    final int soulCardNum = EphemerisCalculator.calculateSoulCardNumber(birthDate);
    final String soulCardName = _majorArcanaNames[soulCardNum] ?? 'XVII. The Star';

    return SynastryPartner(
      name: name,
      birthDate: birthDate,
      sunSign: sun,
      moonSign: moon,
      risingSign: rising,
      dominantElement: element,
      soulCardNumber: soulCardNum,
      soulCardName: soulCardName,
    );
  }

  /// Calculates angular aspect distance between two zodiac signs (0 to 6 steps).
  static int _signDistance(String signA, String signB) {
    final int idxA = _zodiacOrder.indexOf(signA);
    final int idxB = _zodiacOrder.indexOf(signB);
    if (idxA == -1 || idxB == -1) return 0;
    final int diff = (idxA - idxB).abs();
    return diff > 6 ? 12 - diff : diff;
  }

  /// Derives astrological aspect definition from sign distance.
  static (String aspectType, int stars, String titleModifier) _describeAspect(int dist) {
    switch (dist) {
      case 0:
        return ('Conjunction (0°)', 5, 'Golden Alchemical Union');
      case 4:
        return ('Trine (120°)', 5, 'Harmonic Flow of Grace');
      case 2:
        return ('Sextile (60°)', 4, 'Symbiotic Creative Spark');
      case 6:
        return ('Opposition (180°)', 4, 'Magnetic Dynamic Polarity');
      case 3:
        return ('Square (90°)', 3, 'Karmic Catalyst & Growth Tension');
      default:
        return ('Quincunx / Semi-Sextile', 3, 'Mystic Calibration');
    }
  }

  /// Calculates a complete synthesized Lunar Synastry reading.
  static LunarSynastryReading calculateSynastry({
    required SynastryPartner partnerA,
    required SynastryPartner partnerB,
  }) {
    // 1. Calculate Key Planetary Aspects
    final List<SynastryAspect> aspects = [];

    // Aspect 1: Sun (A) to Moon (B) - The Divine Sacred Union
    final int distSunMoon = _signDistance(partnerA.sunSign, partnerB.moonSign);
    final (aspectType1, stars1, mod1) = _describeAspect(distSunMoon);
    aspects.add(
      SynastryAspect(
        title: '$mod1: Conscious Light & Deep Soul Instinct',
        placementA: '${partnerA.name}\'s Sun in ${partnerA.sunSign}',
        placementB: '${partnerB.name}\'s Moon in ${partnerB.moonSign}',
        aspectType: aspectType1,
        harmonyStars: stars1,
        dynamicDescription:
            '${partnerA.name}\'s solar essence deeply soothes and inspires ${partnerB.name}\'s lunar emotional core. This aspect bridges conscious will with subconscious safety, creating an innate sense of home.',
        tarotTalisman: 'XIX. The Sun & II. The High Priestess',
      ),
    );

    // Aspect 2: Moon (A) to Moon (B) - Emotional & Lunar Synchronicity
    final int distMoonMoon = _signDistance(partnerA.moonSign, partnerB.moonSign);
    final (aspectType2, stars2, mod2) = _describeAspect(distMoonMoon);
    aspects.add(
      SynastryAspect(
        title: '$mod2: Nocturnal Empathy & Psychic Resonance',
        placementA: '${partnerA.name}\'s Moon in ${partnerA.moonSign}',
        placementB: '${partnerB.name}\'s Moon in ${partnerB.moonSign}',
        aspectType: aspectType2,
        harmonyStars: stars2,
        dynamicDescription:
            'How both souls navigate shadow, grief, and tender joy. Their lunar wavelengths commune without spoken words, attuning to shared subconscious currents.',
        tarotTalisman: 'XVIII. The Moon & XIV. Temperance',
      ),
    );

    // Aspect 3: Sun (A) to Sun (B) - Core Purpose & Ego Synergy
    final int distSunSun = _signDistance(partnerA.sunSign, partnerB.sunSign);
    final (aspectType3, stars3, mod3) = _describeAspect(distSunSun);
    aspects.add(
      SynastryAspect(
        title: '$mod3: Solar Will & Creative Destiny',
        placementA: '${partnerA.name}\'s Sun in ${partnerA.sunSign}',
        placementB: '${partnerB.name}\'s Sun in ${partnerB.sunSign}',
        aspectType: aspectType3,
        harmonyStars: stars3,
        dynamicDescription:
            'The interaction between outward aspirations and life paths. Whether flowing like kindred spirits or acting as sharpening stones, their life purposes cross with divine intentionality.',
        tarotTalisman: 'I. The Magician & VII. The Chariot',
      ),
    );

    // Aspect 4: Soul Card Resonance (Pythagorean Tarot)
    final int soulDiff = (partnerA.soulCardNumber - partnerB.soulCardNumber).abs();
    final int soulStars = soulDiff == 0 ? 5 : (soulDiff % 3 == 0 ? 5 : (soulDiff <= 4 ? 4 : 3));
    aspects.add(
      SynastryAspect(
        title: 'Pythagorean Arcana Conjunction',
        placementA: '${partnerA.name}: ${partnerA.soulCardName}',
        placementB: '${partnerB.name}: ${partnerB.soulCardName}',
        aspectType: 'Soul Number Archetype',
        harmonyStars: soulStars,
        dynamicDescription:
            'The archetypal cross between ${partnerA.soulCardName} and ${partnerB.soulCardName} represents the spiritual contract underpinning this encounter.',
        tarotTalisman: 'VI. The Lovers & XXI. The World',
      ),
    );

    // 2. Elemental Confluence & Dynamic
    final String elemA = partnerA.dominantElement;
    final String elemB = partnerB.dominantElement;
    final String elementalConfluence = '$elemA & $elemB Confluence';

    final (String elementalDynamic, double balancePercent, int elemBonus) =
        _evaluateElements(elemA, elemB);

    // 3. Moon Phase Synergy
    final String moonPhaseSynergy =
        _evaluateMoonSynergy(partnerA.moonSign, partnerB.moonSign);

    // 4. Compatibility Score (Bounded 62% - 98% for realistic, spiritually uplifting guidance)
    final double rawScore = ((stars1 + stars2 + stars3 + soulStars) / 20.0) * 80.0 + elemBonus;
    final int compatibilityScore = rawScore.clamp(64.0, 98.0).round();

    // 5. Archetypal Titles & Oracle Channelings
    final (String bondTitle, String relArchetype) =
        _generateArchetype(elemA, elemB, compatibilityScore);

    final String karmicLesson = _generateKarmicLesson(elemA, elemB);
    final String soulChallenge = _generateSoulChallenge(distSunSun, distMoonMoon);
    final String sacredRitual = _generateRitual(partnerA, partnerB);
    final String oracleProphecy = _generateOracleProphecy(partnerA, partnerB, bondTitle);

    return LunarSynastryReading(
      partnerA: partnerA,
      partnerB: partnerB,
      compatibilityScore: compatibilityScore,
      bondTitle: bondTitle,
      relationshipArchetype: relArchetype,
      elementalConfluence: elementalConfluence,
      elementalDynamic: elementalDynamic,
      elementalBalancePercent: balancePercent,
      moonPhaseSynergy: moonPhaseSynergy,
      aspects: aspects,
      karmicLesson: karmicLesson,
      soulChallenge: soulChallenge,
      sacredRitual: sacredRitual,
      oracleProphecy: oracleProphecy,
    );
  }

  static (String, double, int) _evaluateElements(String elemA, String elemB) {
    if (elemA == elemB) {
      return (
        'Twin Elemental Resonance: Effortless instinctual mirroring, shared rhythms and mutual understanding that require intentional grounding to prevent echo-chambers.',
        0.90,
        15,
      );
    }
    final Set<String> pair = {elemA, elemB};
    if (pair.contains('Fire') && pair.contains('Air')) {
      return (
        'Celestial Conflagration: Air fans Fire into blazing visionary insight, while Fire warms Air with courageous creative audacity.',
        0.95,
        18,
      );
    }
    if (pair.contains('Earth') && pair.contains('Water')) {
      return (
        'Sacred Alchemical Grove: Earth provides a fertile stone basin for Water\'s intuitive depths, yielding enduring emotional trust and manifest abundance.',
        0.94,
        17,
      );
    }
    if (pair.contains('Fire') && pair.contains('Water')) {
      return (
        'Volatile Steam & Sacred Transmutation: Passion meets psychic oceans. Highly transformative and magnetically intense, dissolving stagnation into alchemical vapor.',
        0.82,
        12,
      );
    }
    if (pair.contains('Air') && pair.contains('Earth')) {
      return (
        'Architects of Reality: Air conceives lofty celestial structures while Earth lays each stone. A powerhouse for manifest material creations and intellectual partnership.',
        0.84,
        13,
      );
    }
    // Fire & Earth or Air & Water
    return (
      'The Dynamic Hermetic Crucible: Contrasting primal rhythms that challenge both souls to expand beyond their familiar comfort zones.',
      0.80,
      11,
    );
  }

  static String _evaluateMoonSynergy(String moonA, String moonB) {
    final String elemA = _signElements[moonA] ?? 'Water';
    final String elemB = _signElements[moonB] ?? 'Water';

    if (elemA == elemB) {
      return 'Harmonic Moon Conjunction: Subconscious synchronicity where intuitive needs and emotional vulnerability feel instantly recognized and safe.';
    }
    return 'Complementary Lunar Axis ($moonA + $moonB): One soul brings the lantern of clarity while the other holds the chalice of empathy, guiding the connection through night passages.';
  }

  static (String, String) _generateArchetype(String elemA, String elemB, int score) {
    if (score >= 90) {
      return (
        'The Celestial Twin Flame Conjunction',
        'Alchemical Sovereign Union',
      );
    }
    if (score >= 82) {
      return (
        'The Sacred Sol-Luna Confluence',
        'Harmonic Karmic Partners',
      );
    }
    return (
      'The Alchemical Crucible of Mirroring',
      'Evolutionary Soul Catalysts',
    );
  }

  static String _generateKarmicLesson(String elemA, String elemB) {
    return 'To honor difference without seeking assimilation. True sacred union does not fuse two souls into one, but creates a sacred sanctuary where two entire universes dance together in sovereign reverence.';
  }

  static String _generateSoulChallenge(int distSun, int distMoon) {
    if (distSun == 3 || distMoon == 3) {
      return 'Tension of Will: Avoid projecting unmet internal needs onto the other. When friction arises, treat it as an astrological lens magnifying what asks for self-healing.';
    }
    return 'Comfort & Stagnation: The ease of this energetic flow can lull both souls into complacency. Intentionally cultivate shared adventures and creative altars to keep the flame vivid.';
  }

  static String _generateRitual(SynastryPartner a, SynastryPartner b) {
    return 'Light two beeswax candles on a clean altar. Braid two ribbons (one representing ${a.dominantElement}, one for ${b.dominantElement}) while speaking aloud three sovereign blessings for the partner\'s personal destiny.';
  }

  static String _generateOracleProphecy(SynastryPartner a, SynastryPartner b, String bondTitle) {
    return 'In the grand celestial ephemeris, your paths did not cross by arbitrary chance. Under the sigil of $bondTitle, ${a.name} and ${b.name} hold complementary keys to unlocking latent spiritual gifts. Walk beside each other with open palms, allowing the mystery of the cosmos to unfold your shared prophecy.';
  }
}
