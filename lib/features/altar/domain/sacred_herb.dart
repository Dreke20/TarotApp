import 'package:flutter/material.dart';

/// The 5 sacred smudge incenses and botanicals for altar purification.
enum SacredHerb {
  paloSanto(
    id: 'palo_santo',
    name: 'Palo Santo',
    botanicalTitle: 'Bursera Graveolens',
    subtitle: 'Holy Wood of Uplifting Grace',
    description: 'Ancient Andean holy wood that clears lingering heaviness, raises spiritual vibration, and invites divine blessings.',
    mantra: 'Transmute shadow into golden starlight; let this sacred altar be holy ground.',
    smokeColor: Color(0xFFFFE082), // Golden warm amber
    glowColor: Color(0xFFFFD54F),
    element: 'Fire & Air',
    iconText: '🪵',
  ),
  whiteSage(
    id: 'white_sage',
    name: 'White Sage',
    botanicalTitle: 'Salvia Apiana',
    subtitle: 'Sacred Smoke of the Ancestors',
    description: 'Potent energetic cleanser that releases stagnant attachments, dissolves negative fields, and resets psychic boundaries.',
    mantra: 'Release what has passed; seal the sacred perimeter; only highest truth may enter.',
    smokeColor: Color(0xFFEDE7F6), // Silvery ethereal white
    glowColor: Color(0xFFD1C4E9),
    element: 'Earth & Water',
    iconText: '🌿',
  ),
  copalResin(
    id: 'copal_resin',
    name: 'Golden Copal',
    botanicalTitle: 'Protium Copal',
    subtitle: 'Solar Catalyst of Manifestation',
    description: 'Sacred Mesoamerican tree resin associated with the golden sun, bridging earthly seekers with the celestial deities.',
    mantra: 'Kindle the solar flame within; awaken divine willpower and golden abundance.',
    smokeColor: Color(0xFFFFB300), // Vibrant solar gold
    glowColor: Color(0xFFFFA000),
    element: 'Fire & Sun',
    iconText: '✨',
  ),
  lavenderMugwort(
    id: 'lavender_mugwort',
    name: 'Lavender & Mugwort',
    botanicalTitle: 'Lavandula & Artemisia',
    subtitle: 'Third-Eye Awakening & Serenity',
    description: 'Calms psychic overstimulation, deepens subconscious receptivity, and opens the visionary eye for lucid prophecy.',
    mantra: 'Calm the restless waters; awaken the inner vision; unveil what is unseen.',
    smokeColor: Color(0xFFCE93D8), // Ethereal amethyst lilac
    glowColor: Color(0xFFBA68C8),
    element: 'Water & Air',
    iconText: '🪻',
  ),
  atlasCedar(
    id: 'atlas_cedar',
    name: 'Atlas Cedarwood',
    botanicalTitle: 'Cedrus Atlantica',
    subtitle: 'Ancient Sentinel of Protection',
    description: 'Sacred wood of ancient temple pillars, providing deep roots, spiritual fortitude, and unshakeable psychic anchoring.',
    mantra: 'Stand rooted as the mountain cedar; let no illusion sway your centered spirit.',
    smokeColor: Color(0xFFBCAAA4), // Warm earthy cedar smoke
    glowColor: Color(0xFFA1887F),
    element: 'Earth & Wood',
    iconText: '🌲',
  );

  final String id;
  final String name;
  final String botanicalTitle;
  final String subtitle;
  final String description;
  final String mantra;
  final Color smokeColor;
  final Color glowColor;
  final String element;
  final String iconText;

  const SacredHerb({
    required this.id,
    required this.name,
    required this.botanicalTitle,
    required this.subtitle,
    required this.description,
    required this.mantra,
    required this.smokeColor,
    required this.glowColor,
    required this.element,
    required this.iconText,
  });

  static SacredHerb fromId(String id) {
    return SacredHerb.values.firstWhere(
      (h) => h.id == id,
      orElse: () => SacredHerb.paloSanto,
    );
  }
}
