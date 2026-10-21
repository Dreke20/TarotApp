import 'dart:ui';
import 'package:flutter/material.dart';

/// Available aesthetic visual styles for rendering tarot cards throughout the app.
enum CardDeckStyle {
  whispersAndWarnings(
    id: 'whispers_and_warnings',
    name: 'Whispers & Warnings',
    tagline: 'Imperial 24k Gold & Obsidian Gothic',
    description: 'The master bespoke deck. Deep obsidian black framing with 24k gold leaf filigree and rich oil-painted illumination.',
    primaryAccent: Color(0xFFD4AF37),
    foilColors: [Color(0xFFD4AF37), Color(0xFFFFF0A5), Color(0xFFAA8010)],
    isPremium: false,
    colorFilter: null,
  ),
  astralSilver(
    id: 'astral_silver',
    name: 'Astral Silver & Sapphire',
    tagline: 'Iridescent Starlight & Deep Cosmos',
    description: 'Cooled celestial starlight with sterling silver filigree, deep space sapphire vignettes, and icy moonlit highlights.',
    primaryAccent: Color(0xFFC0D8E8),
    foilColors: [Color(0xFFC0D8E8), Color(0xFFFFFFFF), Color(0xFF7BA0BD)],
    isPremium: false,
    colorFilter: ColorFilter.matrix(<double>[
      0.85, 0.05, 0.20, 0, -10,
      0.05, 0.90, 0.15, 0, -5,
      0.10, 0.20, 1.15, 0, 15,
      0,    0,    0,    1, 0,
    ]),
  ),
  vintageAlchemical(
    id: 'vintage_alchemical',
    name: 'Vintage Alchemical 1909',
    tagline: 'Warm Sepia & Antique Copper Patina',
    description: 'Aged parchment aesthetic inspired by the original 1909 London hermetic printings with warm sepia grain and antique bronze edges.',
    primaryAccent: Color(0xFFD89F61),
    foilColors: [Color(0xFFD89F61), Color(0xFFFBE4C8), Color(0xFF8F5826)],
    isPremium: false,
    colorFilter: ColorFilter.matrix(<double>[
      1.05, 0.10, 0.00, 0, 15,
      0.05, 0.95, 0.00, 0, 8,
      0.00, 0.05, 0.75, 0, -15,
      0,    0,    0,    1, 0,
    ]),
  ),
  amethystStarlight(
    id: 'amethyst_starlight',
    name: 'Amethyst Starlight',
    tagline: 'Mystic Lavender Aura & Deep Purple Shadows',
    description: 'Enigmatic esoteric violet palette with shimmering lilac foil and psychic third-eye radiance.',
    primaryAccent: Color(0xFFC084FC),
    foilColors: [Color(0xFFC084FC), Color(0xFFF3E8FF), Color(0xFF7E22CE)],
    isPremium: true,
    colorFilter: ColorFilter.matrix(<double>[
      0.95, 0.05, 0.20, 0, 10,
      0.05, 0.80, 0.10, 0, -10,
      0.25, 0.10, 1.20, 0, 20,
      0,    0,    0,    1, 0,
    ]),
  ),
  solarLuminary(
    id: 'solar_luminary',
    name: 'Solar Luminary',
    tagline: 'Golden Hour Dawn & Solar Flare Radiance',
    description: 'Warm solar-charged aura with radiant sunburst gold accents and brilliant illuminated ivory borders.',
    primaryAccent: Color(0xFFFFD700),
    foilColors: [Color(0xFFFFD700), Color(0xFFFFF8DC), Color(0xFFDDAA00)],
    isPremium: true,
    colorFilter: ColorFilter.matrix(<double>[
      1.15, 0.10, 0.00, 0, 20,
      0.10, 1.05, 0.00, 0, 12,
      0.00, 0.05, 0.85, 0, -10,
      0,    0,    0,    1, 0,
    ]),
  );

  final String id;
  final String name;
  final String tagline;
  final String description;
  final Color primaryAccent;
  final List<Color> foilColors;
  final bool isPremium;
  final ColorFilter? colorFilter;

  const CardDeckStyle({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.primaryAccent,
    required this.foilColors,
    required this.isPremium,
    this.colorFilter,
  });

  static CardDeckStyle fromId(String? id) {
    return CardDeckStyle.values.firstWhere(
      (style) => style.id == id,
      orElse: () => CardDeckStyle.whispersAndWarnings,
    );
  }
}
