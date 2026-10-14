import 'dart:math';

enum MoonPhaseType {
  newMoon('New Moon', '🌑', 'Time for planting seeds and setting fresh intentions.'),
  waxingCrescent('Waxing Crescent', '🌒', 'Energy is building. Clarify your desires and take initial steps.'),
  firstQuarter('First Quarter', '🌓', 'Overcoming challenges, decision-making, and decisive action.'),
  waxingGibbous('Waxing Gibbous', '🌔', 'Refinement, patient momentum, and preparing for revelation.'),
  fullMoon('Full Moon', '🌕', 'Peak spiritual illumination, cosmic fruition, and breakthrough insights.'),
  waningGibbous('Waning Gibbous', '🌖', 'Gratitude, sharing wisdom, and deep spiritual reflection.'),
  lastQuarter('Last Quarter', '🌗', 'Forgiveness, releasing outdated baggage, and cord-cutting.'),
  waningCrescent('Waning Crescent', '🌘', 'Rest, surrender, and deep psychic replenishment.');

  final String title;
  final String symbol;
  final String guidance;
  const MoonPhaseType(this.title, this.symbol, this.guidance);
}

class LunarInfo {
  final MoonPhaseType phase;
  final double illuminationPercent;
  final String moonZodiac;
  final String transitGuidance;

  const LunarInfo({
    required this.phase,
    required this.illuminationPercent,
    required this.moonZodiac,
    required this.transitGuidance,
  });
}

class LunarCalculator {
  static const List<String> _zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  static LunarInfo getTodayLunarInfo([DateTime? date]) {
    final now = (date ?? DateTime.now()).toUtc();
    
    // Julian Date calculation
    int y = now.year;
    int m = now.month;
    final d = now.day + (now.hour + now.minute / 60.0) / 24.0;
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    final jd = (365.25 * (y + 4716)).floor() + (30.6001 * (m + 1)).floor() + d + b - 1524.5;

    // Days since Jan 11, 2024 New Moon (JD 2460320.5)
    final daysSinceNew = jd - 2460320.5;
    final synodicMonth = 29.53058867;
    final phaseIndex = (daysSinceNew % synodicMonth) / synodicMonth;
    final illumination = (0.5 * (1 - cos(phaseIndex * 2 * pi)) * 100).clamp(0.0, 100.0);

    // Approximate Moon zodiac sign (moon completes 360 deg every ~27.32 days)
    final tropicalLunarAge = (daysSinceNew % 27.321582) / 27.321582;
    final zodiacIndex = (tropicalLunarAge * 12).floor() % 12;
    final zodiac = _zodiacSigns[zodiacIndex];

    MoonPhaseType phase;
    if (phaseIndex < 0.03 || phaseIndex >= 0.97) {
      phase = MoonPhaseType.newMoon;
    } else if (phaseIndex < 0.22) {
      phase = MoonPhaseType.waxingCrescent;
    } else if (phaseIndex < 0.28) {
      phase = MoonPhaseType.firstQuarter;
    } else if (phaseIndex < 0.47) {
      phase = MoonPhaseType.waxingGibbous;
    } else if (phaseIndex < 0.53) {
      phase = MoonPhaseType.fullMoon;
    } else if (phaseIndex < 0.72) {
      phase = MoonPhaseType.waningGibbous;
    } else if (phaseIndex < 0.78) {
      phase = MoonPhaseType.lastQuarter;
    } else {
      phase = MoonPhaseType.waningCrescent;
    }

    final transit = 'Moon in $zodiac: ${phase.guidance}';

    return LunarInfo(
      phase: phase,
      illuminationPercent: illumination,
      moonZodiac: zodiac,
      transitGuidance: transit,
    );
  }
}
