import 'package:flutter/material.dart';

enum AltarTheme {
  midnightNebula(
    id: 'midnight_nebula',
    title: 'Midnight Nebula',
    primaryColor: Color(0xFF160D3D),
    secondaryColor: Color(0xFFBCA7F8),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF060314), Color(0xFF0D0729), Color(0xFF170D42), Color(0xFF09041A)],
    ),
  ),
  celestialVoid(
    id: 'celestial_void',
    title: 'Obsidian Void',
    primaryColor: Color(0xFF151522),
    secondaryColor: Color(0xFF8E9AAF),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF040406), Color(0xFF0B0B11), Color(0xFF11111B), Color(0xFF050508)],
    ),
  ),
  emeraldSanctuary(
    id: 'emerald_sanctuary',
    title: 'Emerald Grove',
    primaryColor: Color(0xFF0D2818),
    secondaryColor: Color(0xFF52B788),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF041009), Color(0xFF082013), Color(0xFF0E331F), Color(0xFF05140C)],
    ),
  ),
  amethystTemple(
    id: 'amethyst_temple',
    title: 'Amethyst Shrine',
    primaryColor: Color(0xFF2C0E37),
    secondaryColor: Color(0xFFE07A5F),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF120317), Color(0xFF21072B), Color(0xFF330B42), Color(0xFF120317)],
    ),
  );

  const AltarTheme({
    required this.id,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundGradient,
  });

  final String id;
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final LinearGradient backgroundGradient;
}
