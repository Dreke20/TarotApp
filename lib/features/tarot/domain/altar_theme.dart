import 'package:flutter/material.dart';

enum AltarTheme {
  midnightNebula(
    id: 'midnight_nebula',
    title: 'Astral Guidance',
    primaryColor: Color(0xFFD4AF37),
    secondaryColor: Color(0xFFFFAE42),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF020203), Color(0xFF08070B), Color(0xFF120F17), Color(0xFF030304)],
    ),
  ),
  celestialVoid(
    id: 'celestial_void',
    title: 'The Alignment Void',
    primaryColor: Color(0xFFF3DEAB),
    secondaryColor: Color(0xFFC5A059),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF010102), Color(0xFF060508), Color(0xFF0D0B10), Color(0xFF020202)],
    ),
  ),
  emeraldSanctuary(
    id: 'emerald_sanctuary',
    title: 'Sacred Solitary',
    primaryColor: Color(0xFF8BB381),
    secondaryColor: Color(0xFFD4AF37),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF030805), Color(0xFF07120B), Color(0xFF0B1B10), Color(0xFF020604)],
    ),
  ),
  amethystTemple(
    id: 'amethyst_temple',
    title: 'Gilded Velvet',
    primaryColor: Color(0xFFFFAE42),
    secondaryColor: Color(0xFFD4AF37),
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF07040A), Color(0xFF110A17), Color(0xFF190E22), Color(0xFF060308)],
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
