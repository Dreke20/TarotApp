import '../domain/natal_chart.dart';

class EphemerisCalculator {
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

  static const List<String> _zodiacOrder = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  static const Map<String, String> _signTarot = {
    'Aries': 'IV. The Emperor',
    'Taurus': 'V. The Hierophant',
    'Gemini': 'VI. The Lovers',
    'Cancer': 'VII. The Chariot',
    'Leo': 'VIII. Strength',
    'Virgo': 'IX. The Hermit',
    'Libra': 'XI. Justice',
    'Scorpio': 'XIII. Death',
    'Sagittarius': 'XIV. Temperance',
    'Capricorn': 'XV. The Devil',
    'Aquarius': 'XVII. The Star',
    'Pisces': 'XVIII. The Moon',
  };

  static NatalChart calculateChart({
    required String sunSign,
    String? moonSign,
    String? risingSign,
  }) {
    final validSun = _cleanSign(sunSign);
    final validMoon = _cleanSign(moonSign ?? _offsetSign(validSun, 4));
    final validRising = _cleanSign(risingSign ?? _offsetSign(validSun, 8));

    final sunIndex = _zodiacOrder.indexOf(validSun);

    // Ephemeris derivations for inner & outer sacred planets
    final mercurySign = _zodiacOrder[(sunIndex + 1) % 12];
    final venusSign = _zodiacOrder[(sunIndex + 11) % 12];
    final marsSign = _zodiacOrder[(sunIndex + 3) % 12];
    final jupiterSign = _zodiacOrder[(sunIndex + 6) % 12];
    final saturnSign = _zodiacOrder[(sunIndex + 9) % 12];

    final placements = [
      PlanetPlacement(
        planet: 'Sun',
        symbol: '☉',
        sign: validSun,
        element: _signElements[validSun] ?? 'Fire',
        house: '1st House of Self',
        meaning: 'Core vital force, conscious purpose, solar identity and spiritual light.',
        tarotCorrelation: 'XIX. The Sun & ${_signTarot[validSun]}',
      ),
      PlanetPlacement(
        planet: 'Moon',
        symbol: '☽',
        sign: validMoon,
        element: _signElements[validMoon] ?? 'Water',
        house: '4th House of the Soul',
        meaning: 'Emotional subconscious, lunar intuition, primal memory and instinct.',
        tarotCorrelation: 'II. The High Priestess & ${_signTarot[validMoon]}',
      ),
      PlanetPlacement(
        planet: 'Rising / Ascendant',
        symbol: '🌅',
        sign: validRising,
        element: _signElements[validRising] ?? 'Air',
        house: 'Eastern Horizon',
        meaning: 'Sacred outward demeanor, aura presentation, and initiatory threshold into the physical realm.',
        tarotCorrelation: '0. The Fool & ${_signTarot[validRising]}',
      ),
      PlanetPlacement(
        planet: 'Mercury',
        symbol: '☿',
        sign: mercurySign,
        element: _signElements[mercurySign] ?? 'Air',
        house: '3rd House of Mind',
        meaning: 'Hermetic communication, intellectual reasoning, esoteric trade, and mental clarity.',
        tarotCorrelation: 'I. The Magician & ${_signTarot[mercurySign]}',
      ),
      PlanetPlacement(
        planet: 'Venus',
        symbol: '♀',
        sign: venusSign,
        element: _signElements[venusSign] ?? 'Earth',
        house: '2nd House of Values',
        meaning: 'Harmonic attraction, beauty, intimate love bonds, and spiritual wealth.',
        tarotCorrelation: 'III. The Empress & ${_signTarot[venusSign]}',
      ),
      PlanetPlacement(
        planet: 'Mars',
        symbol: '♂',
        sign: marsSign,
        element: _signElements[marsSign] ?? 'Fire',
        house: '8th House of Will',
        meaning: 'Primal willpower, courage, sacred boundaries, and dynamic transformative drive.',
        tarotCorrelation: 'XVI. The Tower & ${_signTarot[marsSign]}',
      ),
      PlanetPlacement(
        planet: 'Jupiter',
        symbol: '♃',
        sign: jupiterSign,
        element: _signElements[jupiterSign] ?? 'Fire',
        house: '9th House of Wisdom',
        meaning: 'Higher spiritual philosophy, expanding horizons, fortune, and divine grace.',
        tarotCorrelation: 'X. Wheel of Fortune & ${_signTarot[jupiterSign]}',
      ),
      PlanetPlacement(
        planet: 'Saturn',
        symbol: '♄',
        sign: saturnSign,
        element: _signElements[saturnSign] ?? 'Earth',
        house: '10th House of Legacy',
        meaning: 'Karmic architecture, sacred patience, time, discipline, and master craftsmanship.',
        tarotCorrelation: 'XXI. The World & ${_signTarot[saturnSign]}',
      ),
    ];

    // Compute element percentages
    int fire = 0;
    int earth = 0;
    int air = 0;
    int water = 0;

    for (final p in placements) {
      switch (p.element) {
        case 'Fire':
          fire++;
          break;
        case 'Earth':
          earth++;
          break;
        case 'Air':
          air++;
          break;
        case 'Water':
          water++;
          break;
      }
    }

    final total = placements.length.toDouble();
    final firePct = fire / total;
    final earthPct = earth / total;
    final airPct = air / total;
    final waterPct = water / total;

    String dominant = 'Fire';
    double maxPct = firePct;
    if (earthPct > maxPct) {
      dominant = 'Earth';
      maxPct = earthPct;
    }
    if (airPct > maxPct) {
      dominant = 'Air';
      maxPct = airPct;
    }
    if (waterPct > maxPct) {
      dominant = 'Water';
      maxPct = waterPct;
    }

    return NatalChart(
      sunSign: validSun,
      moonSign: validMoon,
      risingSign: validRising,
      placements: placements,
      firePercent: firePct,
      earthPercent: earthPct,
      airPercent: airPct,
      waterPercent: waterPct,
      dominantElement: dominant,
      soulArchetype: 'The ${_signTarot[validSun]?.split(".").last.trim() ?? "Mystic"}',
    );
  }

  static String _cleanSign(String sign) {
    for (final s in _zodiacOrder) {
      if (s.toLowerCase() == sign.toLowerCase().trim()) return s;
    }
    return 'Scorpio';
  }

  static String _offsetSign(String sign, int offset) {
    final idx = _zodiacOrder.indexOf(sign);
    if (idx == -1) return 'Scorpio';
    return _zodiacOrder[(idx + offset) % 12];
  }
}
