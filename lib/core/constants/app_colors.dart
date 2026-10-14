import 'package:flutter/material.dart';

/// Mystic glassmorphic color palette designed for high aesthetic fidelity.
class AppColors {
  // Midnight and Violet Backdrops
  static const Color backgroundDeep = Color(0xFF070414);
  static const Color backgroundMidnight = Color(0xFF0D0826);
  static const Color backgroundViolet = Color(0xFF160D3D);
  static const Color cosmicSurface = Color(0xFF1E114D);

  // Glassmorphic Accents & Overlays
  static const Color glassFill = Color(0x1AFFFFFF); // 10% white
  static const Color glassFillStrong = Color(0x2EFFFFFF); // 18% white
  static const Color glassBorder = Color(0x33B8A1FF); // Subtle luminous lilac border
  static const Color glassBorderGlow = Color(0x80ECC572); // Golden shimmer border

  // Celestial Golds & Starlight
  static const Color goldBright = Color(0xFFFFD56B);
  static const Color goldMuted = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFF8C7126);
  static const Color starlightCyan = Color(0xFF6DECFE);
  static const Color etherealLavender = Color(0xFFBCA7F8);

  // Card & Element Accents
  static const Color fireAccent = Color(0xFFFF6B6B);
  static const Color waterAccent = Color(0xFF4DABF7);
  static const Color airAccent = Color(0xFFF093FB);
  static const Color earthAccent = Color(0xFF69DB7C);

  // Text Colors
  static const Color textPrimary = Color(0xFFF7F5FC);
  static const Color textSecondary = Color(0xFFB6AFD1);
  static const Color textMuted = Color(0xFF7E75A0);
  static const Color textGold = Color(0xFFFFE082);

  // Gradients
  static const LinearGradient cosmicBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF060314),
      Color(0xFF0D0729),
      Color(0xFF170D42),
      Color(0xFF09041A),
    ],
  );

  static const LinearGradient cardBackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF261458),
      Color(0xFF150A36),
      Color(0xFF0C0521),
    ],
  );

  static const LinearGradient cardFaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1D1245),
      Color(0xFF140B33),
      Color(0xFF0F0724),
    ],
  );

  static const LinearGradient goldTextGradient = LinearGradient(
    colors: [
      Color(0xFFFFF0A5),
      Color(0xFFFFD56B),
      Color(0xFFE2A83B),
    ],
  );
}
