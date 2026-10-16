import 'package:flutter/material.dart';

/// The 4 cardinal corners of the sacred altar grid surrounding the card spread.
enum GridCorner {
  topLeft(
    id: 'top_left',
    title: 'Northwest',
    cardinalLabel: 'NW · Spirit & Crown',
    directionGlyph: '↖',
  ),
  topRight(
    id: 'top_right',
    title: 'Northeast',
    cardinalLabel: 'NE · Air & Vision',
    directionGlyph: '↗',
  ),
  bottomLeft(
    id: 'bottom_left',
    title: 'Southwest',
    cardinalLabel: 'SW · Earth & Shield',
    directionGlyph: '↙',
  ),
  bottomRight(
    id: 'bottom_right',
    title: 'Southeast',
    cardinalLabel: 'SE · Fire & Will',
    directionGlyph: '↘',
  );

  final String id;
  final String title;
  final String cardinalLabel;
  final String directionGlyph;

  const GridCorner({
    required this.id,
    required this.title,
    required this.cardinalLabel,
    required this.directionGlyph,
  });

  static GridCorner fromId(String id) {
    return GridCorner.values.firstWhere(
      (c) => c.id == id || c.name == id,
      orElse: () => GridCorner.topLeft,
    );
  }
}

/// The 6 elemental guardian crystals that can be consecrated upon the altar grid.
enum AltarCrystal {
  clearQuartz(
    id: 'clear_quartz',
    name: 'Clear Quartz Point',
    title: 'Master Harmonic Amplifier',
    subtitle: 'Crown Chakra · Ether & Pure Light',
    chakra: 'Crown',
    element: 'Ether',
    glyph: '✧',
    primaryColor: Color(0xFFF5F5F5),
    glowColor: Color(0xFFE0F7FA),
    affirmation: 'I amplify highest spiritual alignment and clear seeing.',
  ),
  amethyst(
    id: 'amethyst',
    name: 'Amethyst Cluster',
    title: 'Psychic Intuition & Shield',
    subtitle: 'Third Eye Chakra · Water & Astral Veil',
    chakra: 'Third Eye',
    element: 'Water',
    glyph: '🔮',
    primaryColor: Color(0xFFAB47BC),
    glowColor: Color(0xFFCE93D8),
    affirmation: 'My intuition penetrates the deepest cosmic mysteries.',
  ),
  blackTourmaline(
    id: 'black_tourmaline',
    name: 'Black Tourmaline',
    title: 'Psychic Armor & Grounding',
    subtitle: 'Root Chakra · Earth & Boundary',
    chakra: 'Root',
    element: 'Earth',
    glyph: '🛡️',
    primaryColor: Color(0xFF37474F),
    glowColor: Color(0xFF78909C),
    affirmation: 'I am firmly grounded, safe, and impervious to discord.',
  ),
  roseQuartz(
    id: 'rose_quartz',
    name: 'Rose Quartz Heart',
    title: 'Heart Chakra Harmony',
    subtitle: 'Heart Chakra · Water & Compassion',
    chakra: 'Heart',
    element: 'Water',
    glyph: '💖',
    primaryColor: Color(0xFFF48FB1),
    glowColor: Color(0xFFF8BBD0),
    affirmation: 'I open my sacred heart to divine love and gentle truth.',
  ),
  citrine(
    id: 'citrine',
    name: 'Golden Citrine',
    title: 'Solar Will & Abundance',
    subtitle: 'Solar Plexus Chakra · Fire & Manifestation',
    chakra: 'Solar Plexus',
    element: 'Fire',
    glyph: '☀️',
    primaryColor: Color(0xFFFFB300),
    glowColor: Color(0xFFFFE082),
    affirmation: 'I manifest cosmic abundance and sovereign creative will.',
  ),
  lapisLazuli(
    id: 'lapis_lazuli',
    name: 'Lapis Lazuli Obelisk',
    title: 'Royal Truth & Voice',
    subtitle: 'Throat Chakra · Air & Archetypal Wisdom',
    chakra: 'Throat',
    element: 'Air',
    glyph: '🌌',
    primaryColor: Color(0xFF1976D2),
    glowColor: Color(0xFF90CAF9),
    affirmation: 'I speak and receive immutable divine truth without fear.',
  );

  final String id;
  final String name;
  final String title;
  final String subtitle;
  final String chakra;
  final String element;
  final String glyph;
  final Color primaryColor;
  final Color glowColor;
  final String affirmation;

  const AltarCrystal({
    required this.id,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.chakra,
    required this.element,
    required this.glyph,
    required this.primaryColor,
    required this.glowColor,
    required this.affirmation,
  });

  static AltarCrystal fromId(String id) {
    return AltarCrystal.values.firstWhere(
      (c) => c.id == id,
      orElse: () => AltarCrystal.clearQuartz,
    );
  }
}
