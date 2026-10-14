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
