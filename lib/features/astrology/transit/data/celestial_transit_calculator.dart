import '../../../../core/utils/lunar_calculator.dart';
import '../../domain/natal_chart.dart';
import '../domain/celestial_transit.dart';

/// Pure Dart astronomical calculator computing real-time celestial transit coordinates,
/// Chaldean planetary hours, and personal transit-to-natal aspects.
class CelestialTransitCalculator {
  static const List<String> _zodiacSigns = [
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

  // Chaldean Order of Planets (from slowest to fastest)
  static const List<String> _chaldeanOrder = [
    'Saturn', 'Jupiter', 'Mars', 'Sun', 'Venus', 'Mercury', 'Moon'
  ];

  static const Map<String, String> _planetGlyphs = {
    'Sun': '☉',
    'Moon': '☽',
    'Mercury': '☿',
    'Venus': '♀',
    'Mars': '♂',
    'Jupiter': '♃',
    'Saturn': '♄',
  };

  static const Map<String, String> _planetTarot = {
    'Sun': 'XIX. The Sun',
    'Moon': 'XVIII. The Moon',
    'Mercury': 'I. The Magician',
    'Venus': 'III. The Empress',
    'Mars': 'XVI. The Tower',
    'Jupiter': 'X. Wheel of Fortune',
    'Saturn': 'XXI. The World',
  };

  /// Calculates a complete real-time celestial transit snapshot.
  static CelestialTransitSnapshot calculateSnapshot({
    DateTime? date,
    NatalChart? seekerNatalChart,
  }) {
    final now = date ?? DateTime.now();
    final lunarInfo = LunarCalculator.getTodayLunarInfo(now);

    final bodies = _calculateTransitingBodies(now);
    final planetaryHour = calculateCurrentPlanetaryHour(now);
    final aspects = seekerNatalChart != null
        ? calculateTransitAspects(bodies, seekerNatalChart)
        : <TransitAspect>[];

    return CelestialTransitSnapshot(
      timestamp: now,
      planetaryHour: planetaryHour,
      bodies: bodies,
      aspects: aspects,
      lunarPhase: lunarInfo.phase.title,
      lunarIllumination: lunarInfo.illuminationPercent,
    );
  }

  /// Derives real-time planetary coordinates for the 7 classical planets.
  static List<CelestialTransitBody> _calculateTransitingBodies(DateTime date) {
    final nowUtc = date.toUtc();
    final jd = _calculateJulianDate(nowUtc);

    // Days since J2000.0 (JD 2451545.0)
    final d = jd - 2451545.0;

    // Mean longitudes (degrees 0 - 360) calibrated for classical bodies
    final sunLng = (280.46646 + 0.9856474 * d) % 360;
    final moonLng = (218.3165 + 13.176396 * d) % 360;
    final mercuryLng = (252.2509 + 4.0923344 * d) % 360;
    final venusLng = (181.9798 + 1.6021303 * d) % 360;
    final marsLng = (355.4330 + 0.5240207 * d) % 360;
    final jupiterLng = (34.3515 + 0.0830853 * d) % 360;
    final saturnLng = (50.0774 + 0.0334442 * d) % 360;

    final planetList = [
      ('Sun', sunLng, false),
      ('Moon', moonLng, false),
      ('Mercury', mercuryLng, (d % 116) > 95), // ~3 retrogrades a year
      ('Venus', venusLng, (d % 584) > 540),
      ('Mars', marsLng, (d % 780) > 700),
      ('Jupiter', jupiterLng, (d % 399) > 278),
      ('Saturn', saturnLng, (d % 378) > 238),
    ];

    return planetList.map((p) {
      final name = p.$1;
      final rawLng = (p.$2 < 0 ? p.$2 + 360 : p.$2);
      final signIdx = (rawLng / 30).floor() % 12;
      final sign = _zodiacSigns[signIdx];
      final deg = rawLng % 30;
      final element = _signElements[sign] ?? 'Spirit';
      final isRetrograde = p.$3;
      final house = (signIdx + 1);

      return CelestialTransitBody(
        name: name,
        glyph: _planetGlyphs[name] ?? '✦',
        sign: sign,
        degree: double.parse(deg.toStringAsFixed(1)),
        element: element,
        isRetrograde: isRetrograde,
        house: house,
        tarotArchetype: _planetTarot[name] ?? 'The High Priestess',
      );
    }).toList();
  }

  /// Calculates the active classical Chaldean planetary hour for any given time.
  static PlanetaryHour calculateCurrentPlanetaryHour(DateTime date) {
    final weekday = date.weekday; // 1 = Mon, ..., 7 = Sun

    // Day ruler map
    final dayRulers = {
      DateTime.sunday: 'Sun',
      DateTime.monday: 'Moon',
      DateTime.tuesday: 'Mars',
      DateTime.wednesday: 'Mercury',
      DateTime.thursday: 'Jupiter',
      DateTime.friday: 'Venus',
      DateTime.saturday: 'Saturn',
    };

    final dayRuler = dayRulers[weekday] ?? 'Sun';
    final dayRulerIdx = _chaldeanOrder.indexOf(dayRuler);

    // Approximate daylight vs nighttime (assuming 6:00 to 18:00 daylight)
    final hourOfDay = date.hour;
    final minuteOfDay = date.minute;
    final totalMinutes = hourOfDay * 60 + minuteOfDay;

    int hourIndex;
    bool isDayHour;

    if (totalMinutes >= 360 && totalMinutes < 1080) {
      // Day hours (0 to 11)
      isDayHour = true;
      hourIndex = ((totalMinutes - 360) / 60).floor().clamp(0, 11);
    } else {
      // Night hours (12 to 23)
      isDayHour = false;
      int nightMinutes = totalMinutes < 360 ? totalMinutes + 1440 - 1080 : totalMinutes - 1080;
      hourIndex = 12 + (nightMinutes / 60).floor().clamp(0, 11);
    }

    // Chaldean sequence: Each hour advances by 1 in the Chaldean order
    final hourPlanetIdx = (dayRulerIdx + hourIndex) % _chaldeanOrder.length;
    final planetName = _chaldeanOrder[hourPlanetIdx];
    final planetGlyph = _planetGlyphs[planetName] ?? '✦';

    final vibrations = {
      'Sun': 'Solar Radiance, Sovereign Will & Clarity of Soul',
      'Venus': 'Heart Harmony, Aesthetic Grace & Relational Devotion',
      'Mercury': 'Intuitive Intellect, Alchemical Dialogue & Synastry',
      'Moon': 'Subconscious Scrying, Psychic Receptivity & Dream Weaving',
      'Saturn': 'Hermetic Boundaries, Karmic Discipline & Altar Grounding',
      'Jupiter': 'Abundant Expansion, Visionary Wisdom & High Fortune',
      'Mars': 'Sacred Courage, Cord-Cutting & Sovereign Breakthrough',
    };

    final mantras = {
      'Sun': 'I ignite the inner solar hearth; my truth radiates unobstructed.',
      'Venus': 'I receive divine beauty and open my heart to harmonious mirrors.',
      'Mercury': 'My mind is a clear lens for celestial transmission.',
      'Moon': 'I trust the deep ocean of instinct and subconscious insight.',
      'Saturn': 'I stand anchored at the sacred center of reality and form.',
      'Jupiter': 'The universe conspires to expand my highest soul destiny.',
      'Mars': 'With razor focus, I sever illusion and claim my sacred will.',
    };

    final spreads = {
      'Sun': 'Daily Guidance or Celtic Cross',
      'Venus': 'Sol & Luna Synastry or Heart of Two',
      'Mercury': 'Conversational Voice Oracle or 3D Riffle',
      'Moon': 'Astral Dream Scrying or Shadow Mirror',
      'Saturn': 'Wheel of the Year or Three Fates Cut',
      'Jupiter': 'Career Crossroads or Seeker\'s Chronicle',
      'Mars': 'Hermetic Consecration or Smoke Smudge',
    };

    return PlanetaryHour(
      planetName: planetName,
      planetGlyph: planetGlyph,
      dayRuler: dayRuler,
      hourIndex: hourIndex + 1,
      isDayHour: isDayHour,
      rulingElement: _signElements[planetName == 'Sun' ? 'Leo' : (planetName == 'Moon' ? 'Cancer' : 'Aries')] ?? 'Fire',
      sacredVibration: vibrations[planetName] ?? 'Universal Harmony',
      consecrationMantra: mantras[planetName] ?? 'As above, so below.',
      recommendedSpread: spreads[planetName] ?? 'Astral Guidance Altar',
    );
  }

  /// Calculates aspects between real-time transiting planets and the seeker's natal placements.
  static List<TransitAspect> calculateTransitAspects(
    List<CelestialTransitBody> transits,
    NatalChart natal,
  ) {
    final aspects = <TransitAspect>[];

    for (final transit in transits) {
      final transitLng = _signAndDegreeToLongitude(transit.sign, transit.degree);

      for (final placement in natal.placements) {
        final natalLng = _signAndDegreeToLongitude(placement.sign, 15.0); // Mid-sign representative
        var diff = (transitLng - natalLng).abs();
        if (diff > 180) diff = 360 - diff;

        // Check major aspects
        if (diff <= 8.0) {
          aspects.add(TransitAspect(
            transitingPlanet: transit.name,
            transitingGlyph: transit.glyph,
            natalPlacement: '${placement.planet} in ${placement.sign}',
            natalGlyph: placement.symbol,
            aspectType: 'Conjunction',
            aspectGlyph: '☌',
            orbDegrees: double.parse(diff.toStringAsFixed(1)),
            isHarmonious: true,
            channelingGuidance: 'Potent fusion: Transiting ${transit.name} activates your natal ${placement.planet}. Direct focus into ${transit.tarotArchetype}.',
          ));
        } else if ((diff - 60.0).abs() <= 6.0) {
          final orb = (diff - 60.0).abs();
          aspects.add(TransitAspect(
            transitingPlanet: transit.name,
            transitingGlyph: transit.glyph,
            natalPlacement: '${placement.planet} in ${placement.sign}',
            natalGlyph: placement.symbol,
            aspectType: 'Sextile',
            aspectGlyph: '⚹',
            orbDegrees: double.parse(orb.toStringAsFixed(1)),
            isHarmonious: true,
            channelingGuidance: 'Supportive opportunity: Transiting ${transit.name} opens creative doors for your natal ${placement.planet}.',
          ));
        } else if ((diff - 90.0).abs() <= 7.0) {
          final orb = (diff - 90.0).abs();
          aspects.add(TransitAspect(
            transitingPlanet: transit.name,
            transitingGlyph: transit.glyph,
            natalPlacement: '${placement.planet} in ${placement.sign}',
            natalGlyph: placement.symbol,
            aspectType: 'Square',
            aspectGlyph: '□',
            orbDegrees: double.parse(orb.toStringAsFixed(1)),
            isHarmonious: false,
            channelingGuidance: 'Dynamic tension: Transiting ${transit.name} challenges your natal ${placement.planet}. Harness this friction for breakthrough.',
          ));
        } else if ((diff - 120.0).abs() <= 8.0) {
          final orb = (diff - 120.0).abs();
          aspects.add(TransitAspect(
            transitingPlanet: transit.name,
            transitingGlyph: transit.glyph,
            natalPlacement: '${placement.planet} in ${placement.sign}',
            natalGlyph: placement.symbol,
            aspectType: 'Trine',
            aspectGlyph: '△',
            orbDegrees: double.parse(orb.toStringAsFixed(1)),
            isHarmonious: true,
            channelingGuidance: 'Golden flow: Transiting ${transit.name} harmonizes effortlessly with your natal ${placement.planet}. High psychic receptivity.',
          ));
        } else if ((diff - 180.0).abs() <= 8.0) {
          final orb = (diff - 180.0).abs();
          aspects.add(TransitAspect(
            transitingPlanet: transit.name,
            transitingGlyph: transit.glyph,
            natalPlacement: '${placement.planet} in ${placement.sign}',
            natalGlyph: placement.symbol,
            aspectType: 'Opposition',
            aspectGlyph: '☍',
            orbDegrees: double.parse(orb.toStringAsFixed(1)),
            isHarmonious: false,
            channelingGuidance: 'Sacred polarity mirror: Transiting ${transit.name} opposes your natal ${placement.planet}. Seek equilibrium across the axis.',
          ));
        }
      }
    }

    // Limit to top 5 most exact aspects (smallest orb)
    aspects.sort((a, b) => a.orbDegrees.compareTo(b.orbDegrees));
    return aspects.take(6).toList();
  }

  static double _signAndDegreeToLongitude(String sign, double degree) {
    final idx = _zodiacSigns.indexOf(sign);
    if (idx == -1) return degree;
    return idx * 30.0 + degree;
  }

  static double _calculateJulianDate(DateTime utc) {
    int y = utc.year;
    int m = utc.month;
    final d = utc.day + (utc.hour + utc.minute / 60.0 + utc.second / 3600.0) / 24.0;
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (y + 4716)).floor() + (30.6001 * (m + 1)).floor() + d + b - 1524.5;
  }
}
