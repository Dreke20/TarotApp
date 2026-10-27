enum SpreadType {
  dailyGuidance(
    id: 'daily_guidance',
    title: 'Daily Guidance',
    subtitle: 'One card to illuminate the path and energies of today',
    cardCount: 1,
    positionTitles: ['Today\'s Guidance'],
  ),
  threeFates(
    id: 'three_fates',
    title: 'The Three Fates',
    subtitle: 'Past roots, present crossroads, and unfolding future potential',
    cardCount: 3,
    positionTitles: [
      'The Past (Roots & Foundation)',
      'The Present (Current Energy & Challenges)',
      'The Future (Unfolding Trajectory)',
    ],
  ),
  celticCross(
    id: 'celtic_cross',
    title: 'The Celtic Cross',
    subtitle: 'The timeless 10-card matrix illuminating your complete life path',
    cardCount: 10,
    positionTitles: [
      'I. Present (Heart of the Matter)',
      'II. The Crossing (Immediate Challenge)',
      'III. The Root (Subconscious Foundation)',
      'IV. The Past (Passing Influences)',
      'V. The Crown (Higher Potential & Aims)',
      'VI. Near Future (Upcoming Trajectory)',
      'VII. The Self (Inner Attitude & Beliefs)',
      'VIII. Environment (Surrounding Forces)',
      'IX. Hopes & Fears (Inner Desires)',
      'X. Culmination (Final Outcome)',
    ],
  ),
  heartOfTwo(
    id: 'heart_of_two',
    title: 'Heart & Soulmate',
    subtitle: '5 cards revealing emotional resonance, soulmate bonds, and relational truth',
    cardCount: 5,
    positionTitles: [
      'I. Your Emotional Core',
      'II. Their Energetic Presence',
      'III. The Relational Nexus',
      'IV. The Sacred Lesson / Tension',
      'V. Highest Harmonious Horizon',
    ],
  ),
  careerCrossroads(
    id: 'career_crossroads',
    title: 'Career Crossroads',
    subtitle: '5 cards charting professional momentum, hidden leverage, and destiny',
    cardCount: 5,
    positionTitles: [
      'I. Current Professional Station',
      'II. Hidden Genius & Leverage',
      'III. The True Impediment',
      'IV. Decisive Tactical Step',
      'V. Peak Career Manifestation',
    ],
  ),
  shadowMirror(
    id: 'shadow_mirror',
    title: 'Shadow Work',
    subtitle: '4 cards peering behind the ego persona to illuminate hidden unconscious truths',
    cardCount: 4,
    positionTitles: [
      'I. The Persona (The Mask)',
      'II. The Shadow (The Repressed)',
      'III. The Karmic Wound',
      'IV. Gateway to Integration',
    ],
  ),
  wheelOfTheYear(
    id: 'wheel_of_the_year',
    title: 'Wheel of the Year',
    subtitle: '12 cards corresponding to the 12 Astrological Houses and seasonal cosmic sabbats',
    cardCount: 12,
    positionTitles: [
      '1st House: Aries • The Self & Vitality',
      '2nd House: Taurus • Wealth & Grounding',
      '3rd House: Gemini • Communication & Mind',
      '4th House: Cancer • Ancestry & Sanctuary',
      '5th House: Leo • Passion, Joy & Creation',
      '6th House: Virgo • Sacred Service & Health',
      '7th House: Libra • Partnerships & Mirrors',
      '8th House: Scorpio • Metamorphosis & Rebirth',
      '9th House: Sagittarius • Philosophy & Horizon',
      '10th House: Capricorn • Legacy & Ambition',
      '11th House: Aquarius • Community & Hopes',
      '12th House: Pisces • Transcendent Unconscious',
    ],
  ),
  solAndLuna(
    id: 'sol_and_luna',
    title: 'Sol & Luna Synastry',
    subtitle: '3 cards mapping Partner A (Solar), Partner B (Lunar), and their Conjunction Bridge',
    cardCount: 3,
    positionTitles: [
      'Partner A (Solar Essence & Conscious Will)',
      'Partner B (Lunar Reflection & Emotional Core)',
      'The Conjunction (Alchemical Nexus & Shared Destiny)',
    ],
  );

  const SpreadType({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cardCount,
    required this.positionTitles,
  });

  final String id;
  final String title;
  final String subtitle;
  final int cardCount;
  final List<String> positionTitles;

  static SpreadType fromId(String id) {
    return SpreadType.values.firstWhere(
      (s) => s.id == id,
      orElse: () => SpreadType.dailyGuidance,
    );
  }
}
