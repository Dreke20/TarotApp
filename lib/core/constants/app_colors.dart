import 'package:flutter/material.dart';

/// Whispers & Warnings (whispers26.com) Luxury Occult Color Palette.
/// Deep velvet obsidian black canvas, radiant imperial gold foils,
/// warm candlelight embers, and sacred champagne highlights.
class AppColors {
  // Pure Obsidian Noir & Velvet Black Backdrops (Whispers & Warnings signature)
  static const Color backgroundDeep = Color(0xFF030304); // Deepest pitch obsidian
  static const Color backgroundMidnight = Color(0xFF09080C); // Obsidian velvet
  static const Color backgroundViolet = Color(0xFF131118); // Deep smoky warm onyx
  static const Color cosmicSurface = Color(0xFF17151D); // Rich charcoal obsidian card surface

  // Glassmorphic Accents & Overlays with Imperial Gold Tint
  static const Color glassFill = Color(0x18C59E53); // Translucent obsidian gold
  static const Color glassFillStrong = Color(0x28C59E53); // Rich dark glass
  static const Color glassBorder = Color(0x40D4AF37); // Fine 1px metallic gold hairline
  static const Color glassBorderGlow = Color(0x8CF3DEAB); // Luminous champagne shimmer border

  // Whispers & Warnings Metallic Golds & Candle Embers
  static const Color goldBright = Color(0xFFF3DEAB); // Radiant Champagne Gold
  static const Color goldMetallic = Color(0xFFD4AF37); // True Imperial Metallic Gold
  static const Color goldAccent = Color(0xFFD4AF37); // Imperial Gold Accent
  static const Color goldMuted = Color(0xFFC5A059); // Warm Antique Foil Gold
  static const Color goldDark = Color(0xFF7A5C28); // Deep Bronze Shadow
  static const Color goldCandle = Color(0xFFFFAE42); // Warm Candlelight Amber Glow
  static const Color starlightCyan = Color(0xFFF6E8C3); // Soft Celestial Starlight Ivory
  static const Color etherealLavender = Color(0xFFC5A059); // Harmonized to Antique Gold
  static const Color backgroundDark = Color(0xFF030304);
  static const Color cardSurface = Color(0xFF17151D);

  // Card & Element Accents (Enriched to fit the dark luxury occult palette)
  static const Color fireAccent = Color(0xFFFF7A59); // Candle flame crimson
  static const Color waterAccent = Color(0xFF5AB4E5); // Deep celestial ocean
  static const Color airAccent = Color(0xFFE5C583); // Golden ether
  static const Color earthAccent = Color(0xFF8BB381); // Sacred moss / emerald

  // Text Colors (Warm Parchment & Antique Ivory)
  static const Color textPrimary = Color(0xFFFDFBF7); // Pure warm ivory parchment
  static const Color textSecondary = Color(0xFFC9BFAC); // Soft antique warm beige
  static const Color textMuted = Color(0xFF7E776C); // Smoky bronze charcoal
  static const Color textGold = Color(0xFFF3DEAB); // Champagne gold text

  // Gradients
  static const LinearGradient cosmicBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF020203),
      Color(0xFF08070A),
      Color(0xFF110F15),
      Color(0xFF040405),
    ],
  );

  static const LinearGradient cardBackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E1A25),
      Color(0xFF110F16),
      Color(0xFF070609),
    ],
  );

  static const LinearGradient cardFaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1C1923),
      Color(0xFF100E14),
      Color(0xFF070609),
    ],
  );

  static const LinearGradient goldTextGradient = LinearGradient(
    colors: [
      Color(0xFFFFF4D4),
      Color(0xFFF3DEAB),
      Color(0xFFD4AF37),
      Color(0xFF9E782F),
    ],
  );

  static const LinearGradient goldButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF6E3B4),
      Color(0xFFD4AF37),
      Color(0xFFA27B2C),
    ],
  );
}
