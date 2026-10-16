import 'package:flutter/material.dart';

/// Represents a sacred collectible card back geometry design.
enum CardBackDesign {
  eyeOfProvidence(
    id: 'eye_of_providence',
    title: 'The Eye of Providence',
    subtitle: 'All-Seeing Sacred Solar Rays',
    description:
        'The radiant cosmic eye surrounded by sixteen solar rays and antique 24k gold corner filigree. Channels divine illumination and divine truth.',
    primaryFoilColor: Color(0xFFD4AF37),
    secondaryFoilColor: Color(0xFFFFE082),
    backgroundColor: Color(0xFF0F0E17),
    glyph: '👁',
    isPro: false,
  ),
  metatronsCube(
    id: 'metatrons_cube',
    title: "Metatron's Cube",
    subtitle: 'Thirteen Astral Spheres & Platonic Solids',
    description:
        'Thirteen sacred circles woven by liquid silver and ethereal violet vectors, enclosing the blueprints of the five Platonic dimensional solids.',
    primaryFoilColor: Color(0xFFC084FC),
    secondaryFoilColor: Color(0xFFE2E8F0),
    backgroundColor: Color(0xFF130924),
    glyph: '✡',
    isPro: true,
  ),
  ouroborosMoon(
    id: 'ouroboros_moon',
    title: 'Ouroboros & Crescent Moon',
    subtitle: 'Eternal Rebirth & Rose Gold Filigree',
    description:
        'The serpent of infinite renewal holding its tail, cradling a waxing crescent moon rendered in brushed alchemical rose gold.',
    primaryFoilColor: Color(0xFFF472B6),
    secondaryFoilColor: Color(0xFFFDE047),
    backgroundColor: Color(0xFF1A0A16),
    glyph: '♾',
    isPro: true,
  ),
  celestialAstrolabe(
    id: 'celestial_astrolabe',
    title: 'Celestial Astrolabe',
    subtitle: 'Antique Brass Astronomical Dials',
    description:
        'Precision concentric brass astrolabe rings, stereographic horizon projections, and star sight pointers used by ancient Babylonian magi.',
    primaryFoilColor: Color(0xFF38BDF8),
    secondaryFoilColor: Color(0xFF34D399),
    backgroundColor: Color(0xFF071426),
    glyph: '🧭',
    isPro: false,
  );

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final Color primaryFoilColor;
  final Color secondaryFoilColor;
  final Color backgroundColor;
  final String glyph;
  final bool isPro;

  const CardBackDesign({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.primaryFoilColor,
    required this.secondaryFoilColor,
    required this.backgroundColor,
    required this.glyph,
    required this.isPro,
  });

  static CardBackDesign fromId(String? id) {
    return CardBackDesign.values.firstWhere(
      (design) => design.id == id,
      orElse: () => CardBackDesign.eyeOfProvidence,
    );
  }
}
