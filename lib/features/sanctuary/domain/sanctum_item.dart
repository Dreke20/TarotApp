import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Categories grouping sacred sanctuaries and esoteric tools.
enum SanctumCategory {
  divination(
    id: 'divination',
    title: 'Divination Sanctuaries',
    shortTitle: 'Divination',
    subtitle: 'Tarot, Runes, I Ching, AR & Voice Oracles',
    iconGlyph: '🎴',
    accentColor: Color(0xFFD4AF37), // Antique Gold
  ),
  celestial(
    id: 'celestial',
    title: 'Celestial Ephemeris & Stars',
    shortTitle: 'Celestial',
    subtitle: 'Lunar cycles, natal astrology & cosmic timing',
    iconGlyph: '🪐',
    accentColor: Color(0xFF8AB4F8), // Celestial Cyan/Blue
  ),
  inner(
    id: 'inner',
    title: 'Inner Rites & Consecration',
    shortTitle: 'Inner Rites',
    subtitle: 'Dreams, meditations, breath & sacred altar smudging',
    iconGlyph: '🕯️',
    accentColor: Color(0xFFC5A3FF), // Ethereal Lavender
  ),
  grimoire(
    id: 'grimoire',
    title: 'Codex, Grimoire & Studio',
    shortTitle: 'Grimoire',
    subtitle: 'Deck encyclopedia, journals, chronicles & 4K wallpapers',
    iconGlyph: '📜',
    accentColor: Color(0xFF50E3C2), // Emerald Mint
  );

  final String id;
  final String title;
  final String shortTitle;
  final String subtitle;
  final String iconGlyph;
  final Color accentColor;

  const SanctumCategory({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.subtitle,
    required this.iconGlyph,
    required this.accentColor,
  });
}

/// The specific esoteric type of an indexed item in the Omni-Portal.
enum SanctumResultType {
  sanctuary,
  tarotCard,
  rune,
  hexagram,
  dreamSymbol,
  sabbat,
  pathworking,
}

/// Represents an accessible sanctuary, tool, or indexed esoteric entity.
class SanctumItem {
  final String id;
  final String title;
  final String subtitle;
  final String iconGlyph;
  final IconData? iconData;
  final Color accentColor;
  final SanctumCategory category;
  final SanctumResultType type;
  final List<String> searchKeywords;
  final String? badgeText;
  final bool isPro;
  final void Function(BuildContext context, WidgetRef ref) onOpen;

  const SanctumItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconGlyph,
    this.iconData,
    required this.accentColor,
    required this.category,
    this.type = SanctumResultType.sanctuary,
    required this.searchKeywords,
    this.badgeText,
    this.isPro = false,
    required this.onOpen,
  });

  /// Check whether this item matches a given search query against title,
  /// subtitle, badge text, and esoteric keywords with tokenized multi-word support.
  bool matches(String query) {
    final clean = query.trim().toLowerCase();
    if (clean.isEmpty) return false;
    final tokens = clean.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();
    if (tokens.isEmpty) return false;

    final combinedCorpus =
        '$title $subtitle ${badgeText ?? ""} ${searchKeywords.join(" ")}'.toLowerCase();
    return tokens.every((token) => combinedCorpus.contains(token));
  }
}
