import 'package:flutter/material.dart';

enum TarotDeckTheme {
  classic(
    id: 'classic',
    title: 'Astral Guidance',
    subtitle: 'Obsidian velvet with imperial metallic gold foil',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1E1A25), Color(0xFF110F16), Color(0xFF070609)],
    ),
    accentColor: Color(0xFFD4AF37),
    isPremium: false,
  ),
  luminary(
    id: 'luminary',
    title: 'The Alignment Gold',
    subtitle: 'Warm champagne starlight and candlelight amber',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF282330), Color(0xFF17141C), Color(0xFF0B090F)],
    ),
    accentColor: Color(0xFFF3DEAB),
    isPremium: true,
  ),
  obsidian(
    id: 'obsidian',
    title: 'Obsidian Mystery',
    subtitle: 'Deep volcanic obsidian stone with antique brass runes',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF16141B), Color(0xFF0E0C12), Color(0xFF050507)],
    ),
    accentColor: Color(0xFFC5A059),
    isPremium: true,
  );

  const TarotDeckTheme({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.backGradient,
    required this.accentColor,
    required this.isPremium,
  });

  final String id;
  final String title;
  final String subtitle;
  final LinearGradient backGradient;
  final Color accentColor;
  final bool isPremium;
}
