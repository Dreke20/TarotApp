import 'package:flutter/material.dart';

/// The 5 sacred divination archetypal personas for the AI Oracle.
enum OraclePersona {
  highPriestess(
    id: 'high_priestess',
    title: 'THE HIGH PRIESTESS',
    subtitle: 'Intuitive & Mystical',
    description: 'Speaks with ethereal mystery and poetic cadence, revealing the subconscious currents beneath the veil.',
    sampleQuote: '“What is hidden in the dark water already longs for the light of your remembrance.”',
    accentColor: Color(0xFF9D4EDD),
    icon: Icons.brightness_2_outlined,
    pitch: 1.08,
    speechRate: 0.38,
    timbreTitle: 'Ethereal Mystic Whisper',
    timbreDescription: 'High-vibrational, soft cadence with lingering spaces between words',
    solfeggioFrequency: '741 Hz Intuition',
  ),
  hermit(
    id: 'hermit',
    title: 'THE HERMIT',
    subtitle: 'Philosophical & Stoic',
    description: 'Offers quiet gravitas, patient introspection, and timeless philosophical counsel for solitary souls.',
    sampleQuote: '“Silence is not an absence of answers, but the only sanctuary deep enough to hear them.”',
    accentColor: Color(0xFF64DFDF),
    icon: Icons.nightlight_round,
    pitch: 0.76,
    speechRate: 0.35,
    timbreTitle: 'Deep Stoic Gravitas',
    timbreDescription: 'Resonant baritone, contemplative and measured solitary pacing',
    solfeggioFrequency: '108 Hz Sacred Chime',
  ),
  empress(
    id: 'empress',
    title: 'THE EMPRESS',
    subtitle: 'Nurturing & Abundant',
    description: 'Radiates warm maternal compassion, unconditional self-worth, and lush sensory healing metaphors.',
    sampleQuote: '“You do not need to fight to bloom; allow yourself to be nourished by the soil of your truth.”',
    accentColor: Color(0xFFFFB703),
    icon: Icons.spa_outlined,
    pitch: 1.00,
    speechRate: 0.44,
    timbreTitle: 'Warm Maternal Resonance',
    timbreDescription: 'Gentle melodic cadence, compassionate and nurturing cadence',
    solfeggioFrequency: '528 Hz Heart',
  ),
  magician(
    id: 'magician',
    title: 'THE MAGICIAN',
    subtitle: 'Empowering & Alchemical',
    description: 'Delivers sharp, incisive focus and tactical manifestation steps to forge your reality by will.',
    sampleQuote: '“The elements already sit upon your altar. What will you command them to become?”',
    accentColor: Color(0xFFE63946),
    icon: Icons.auto_awesome,
    pitch: 1.04,
    speechRate: 0.48,
    timbreTitle: 'Crisp Alchemical Focus',
    timbreDescription: 'Incisive articulation, decisive tempo and catalytic clarity',
    solfeggioFrequency: '432 Hz Manifestation',
  ),
  shadowMirror(
    id: 'shadow_mirror',
    title: 'THE SHADOW MIRROR',
    subtitle: 'Raw & Uncompromising',
    description: 'Confronts psychological blind spots, projections, and comfortable illusions with loving, radical honesty.',
    sampleQuote: '“Do not look away from what burns. That is where you have imprisoned your greatest power.”',
    accentColor: Color(0xFFE0AAFF),
    icon: Icons.visibility_outlined,
    pitch: 0.86,
    speechRate: 0.41,
    timbreTitle: 'Penetrating Obsidian Tone',
    timbreDescription: 'Low, steady, uncompromising depth that pierces illusions',
    solfeggioFrequency: 'Celestial Drone',
  );

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String sampleQuote;
  final Color accentColor;
  final IconData icon;
  final double pitch;
  final double speechRate;
  final String timbreTitle;
  final String timbreDescription;
  final String solfeggioFrequency;

  const OraclePersona({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.sampleQuote,
    required this.accentColor,
    required this.icon,
    required this.pitch,
    required this.speechRate,
    required this.timbreTitle,
    required this.timbreDescription,
    required this.solfeggioFrequency,
  });

  String get name => title;
  String get voiceStyle => subtitle;

  static List<OraclePersona> get all => values;

  static OraclePersona fromId(String? id) {
    return OraclePersona.values.firstWhere(
      (p) => p.id == id,
      orElse: () => OraclePersona.highPriestess,
    );
  }
}
