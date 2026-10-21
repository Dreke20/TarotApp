import 'package:flutter/material.dart';

enum WallpaperAspectRatio {
  standard(id: '9_16', label: '9:16 Classic', ratio: 9 / 16, width: 1080, height: 1920),
  modern(id: '9_19_5', label: '9:19.5 Modern', ratio: 9 / 19.5, width: 1170, height: 2535),
  tall(id: '9_20', label: '9:20 Tall', ratio: 9 / 20, width: 1080, height: 2400);

  final String id;
  final String label;
  final double ratio;
  final double width;
  final double height;

  const WallpaperAspectRatio({
    required this.id,
    required this.label,
    required this.ratio,
    required this.width,
    required this.height,
  });
}

enum WallpaperTheme {
  imperialGold(
    id: 'imperial_gold',
    name: 'Imperial 24k Gold',
    gradientColors: [Color(0xFF141219), Color(0xFF09080D), Color(0xFF040306)],
    accentColor: Color(0xFFD4AF37),
    secondaryAccent: Color(0xFFFFF0A5),
  ),
  midnightCosmos(
    id: 'midnight_cosmos',
    name: 'Midnight Cosmos',
    gradientColors: [Color(0xFF0B1224), Color(0xFF060914), Color(0xFF02040A)],
    accentColor: Color(0xFF7BA0BD),
    secondaryAccent: Color(0xFFC0D8E8),
  ),
  alchemicalParchment(
    id: 'alchemical_parchment',
    name: 'Vintage Alchemical',
    gradientColors: [Color(0xFF221A13), Color(0xFF140F0A), Color(0xFF0A0704)],
    accentColor: Color(0xFFD89F61),
    secondaryAccent: Color(0xFFFBE4C8),
  ),
  amethystVeil(
    id: 'amethyst_veil',
    name: 'Amethyst Veil',
    gradientColors: [Color(0xFF1D0E29), Color(0xFF110719), Color(0xFF06020A)],
    accentColor: Color(0xFFC084FC),
    secondaryAccent: Color(0xFFF3E8FF),
  );

  final String id;
  final String name;
  final List<Color> gradientColors;
  final Color accentColor;
  final Color secondaryAccent;

  const WallpaperTheme({
    required this.id,
    required this.name,
    required this.gradientColors,
    required this.accentColor,
    required this.secondaryAccent,
  });
}
