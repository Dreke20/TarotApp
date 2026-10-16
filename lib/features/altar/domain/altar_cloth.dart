import 'package:flutter/material.dart';

/// Represents a sacred consecrated cloth draped across the divination altar.
enum AltarCloth {
  midnightObsidian(
    id: 'midnight_obsidian',
    title: 'Midnight Obsidian Velvet',
    subtitle: 'Classic 24k Gold Zodiac Wheel',
    description:
        'Heavy crushed obsidian velvet, deeply absorbing ambient shadows and embroidered with an antique 24k gold celestial wheel.',
    primaryColor: Color(0xFF09080E),
    secondaryColor: Color(0xFF14121E),
    accentColor: Color(0xFFD4AF37),
    trimColor: Color(0xFFFFDF73),
    glyph: '♈',
    isPro: false,
  ),
  amethystSilk(
    id: 'amethyst_silk',
    title: 'Amethyst Sacred Silk',
    subtitle: 'Sri Yantra Geometric Weave',
    description:
        'Luminous cosmic violet raw silk consecrated with the sacred Sri Yantra matrix, amplifying third-eye intuition and dream scrying.',
    primaryColor: Color(0xFF120826),
    secondaryColor: Color(0xFF231046),
    accentColor: Color(0xFFC084FC),
    trimColor: Color(0xFFE9D5FF),
    glyph: '☸',
    isPro: true,
  ),
  emeraldHermetic(
    id: 'emerald_hermetic',
    title: 'Emerald Hermetic Velvet',
    subtitle: 'Alchemical Seal of Hermes',
    description:
        'Rich forest emerald velvet woven with the sacred emerald tablet seals and the golden serpent caduceus of ancient Alexandria.',
    primaryColor: Color(0xFF061A12),
    secondaryColor: Color(0xFF0D3325),
    accentColor: Color(0xFF34D399),
    trimColor: Color(0xFFFBBF24),
    glyph: '⚕',
    isPro: true,
  ),
  celestialStarlight(
    id: 'celestial_starlight',
    title: 'Celestial Starlight Satin',
    subtitle: 'Silver Constellation Map',
    description:
        'Deep midnight indigo satin hand-stitched with silver astral cartography, mapping the northern star circumpolar heavens.',
    primaryColor: Color(0xFF060B1C),
    secondaryColor: Color(0xFF0F1B3B),
    accentColor: Color(0xFF38BDF8),
    trimColor: Color(0xFFE0F2FE),
    glyph: '✧',
    isPro: false,
  );

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color trimColor;
  final String glyph;
  final bool isPro;

  const AltarCloth({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.trimColor,
    required this.glyph,
    required this.isPro,
  });

  static AltarCloth fromId(String? id) {
    return AltarCloth.values.firstWhere(
      (cloth) => cloth.id == id,
      orElse: () => AltarCloth.midnightObsidian,
    );
  }
}
