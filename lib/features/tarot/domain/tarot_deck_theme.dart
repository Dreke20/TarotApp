import 'package:flutter/material.dart';

enum TarotDeckTheme {
  classic(
    id: 'classic',
    title: 'Celestial Classic',
    subtitle: 'Midnight violet with sacred gold foil filigree',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF261458), Color(0xFF150A36), Color(0xFF0C0521)],
    ),
    accentColor: Color(0xFFFFD56B),
    isPremium: false,
  ),
  luminary(
    id: 'luminary',
    title: 'Ethereal Luminary',
    subtitle: 'Pure celestial starlight and radiant platinum-gold',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF382375), Color(0xFF20134F), Color(0xFF110730)],
    ),
    accentColor: Color(0xFF6DECFE),
    isPremium: true,
  ),
  obsidian(
    id: 'obsidian',
    title: 'Obsidian Mystery',
    subtitle: 'Deep volcanic obsidian stone with crimson astral runes',
    backGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF21152B), Color(0xFF140D1C), Color(0xFF0A040F)],
    ),
    accentColor: Color(0xFFFF5252),
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
