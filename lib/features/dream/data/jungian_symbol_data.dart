class JungianSymbol {
  final String key;
  final String name;
  final String icon;
  final String archetype;
  final String meaning;
  final String tarotCardId;
  final String tarotCardName;

  const JungianSymbol({
    required this.key,
    required this.name,
    required this.icon,
    required this.archetype,
    required this.meaning,
    required this.tarotCardId,
    required this.tarotCardName,
  });
}

class JungianArchetypes {
  static const List<JungianSymbol> allSymbols = [
    JungianSymbol(
      key: 'water',
      name: 'Abyssal Ocean / Water',
      icon: '🌊',
      archetype: 'The Unconscious & Anima',
      meaning: 'Deep emotional undercurrents, primal memory, and the fluid depths of the collective unconscious.',
      tarotCardId: 'the_moon',
      tarotCardName: 'The Moon',
    ),
    JungianSymbol(
      key: 'shadow',
      name: 'Dark Figure / Shadow',
      icon: '👤',
      archetype: 'The Jungian Shadow',
      meaning: 'Repressed instincts, unintegrated desires, and the gold hidden within one’s rejected traits.',
      tarotCardId: 'the_devil',
      tarotCardName: 'The Devil',
    ),
    JungianSymbol(
      key: 'flight',
      name: 'Flight / Leaping Void',
      icon: '🦅',
      archetype: 'Transcendence & Puer Aeternus',
      meaning: 'The soul longing to transcend earthly limitation, spiritual breakthroughs, or naive evasion of gravity.',
      tarotCardId: 'the_fool',
      tarotCardName: 'The Fool',
    ),
    JungianSymbol(
      key: 'serpent',
      name: 'Ouroboros / Serpent',
      icon: '🐍',
      archetype: 'Kundalini & Metamorphosis',
      meaning: 'Shedding of an outgrown identity, transmutation of primal poison into sacred elixir of renewal.',
      tarotCardId: 'death',
      tarotCardName: 'Death',
    ),
    JungianSymbol(
      key: 'tower',
      name: 'Crumbling Spire / Tower',
      icon: '⚡',
      archetype: 'The Ego Cataclysm',
      meaning: 'Shattering of rigid mental illusions to allow genuine spiritual light to pierce the sanctuary of the psyche.',
      tarotCardId: 'the_tower',
      tarotCardName: 'The Tower',
    ),
    JungianSymbol(
      key: 'mirror',
      name: 'Reflective Mirror / Crystal',
      icon: '🪞',
      archetype: 'Self-Reflection & The Wise Old Sage',
      meaning: 'Encounter with one’s authentic nature devoid of social masks or societal projections.',
      tarotCardId: 'the_hermit',
      tarotCardName: 'The Hermit',
    ),
    JungianSymbol(
      key: 'forest',
      name: 'Ancient Labyrinth / Forest',
      icon: '🌲',
      archetype: 'The Great Mother & Nature',
      meaning: 'Fecund soil of creativity, nurturing shelter, or feeling disorientation in the dense thicket of daily life.',
      tarotCardId: 'the_empress',
      tarotCardName: 'The Empress',
    ),
    JungianSymbol(
      key: 'sun',
      name: 'Golden Orb / Sun',
      icon: '☀️',
      archetype: 'The Self (Individuation)',
      meaning: 'Wholeness, solar clarity, conscious integration, and radiant spiritual vitality.',
      tarotCardId: 'the_sun',
      tarotCardName: 'The Sun',
    ),
    JungianSymbol(
      key: 'wheel',
      name: 'Cosmic Clockwork / Wheel',
      icon: '☸️',
      archetype: 'Fate & Synchronicity',
      meaning: 'Cycles of destiny beyond personal control; the unseen turning of cosmic currents.',
      tarotCardId: 'wheel_of_fortune',
      tarotCardName: 'Wheel of Fortune',
    ),
    JungianSymbol(
      key: 'temple',
      name: 'Sacred Sanctuary / Veil',
      icon: '🏛️',
      archetype: 'The High Priestess & Esoteric Mystery',
      meaning: 'Gnosis, veiled intuition, and the quiet threshold between seen and unseen realities.',
      tarotCardId: 'the_high_priestess',
      tarotCardName: 'The High Priestess',
    ),
  ];

  static JungianSymbol findByKey(String key) {
    return allSymbols.firstWhere(
      (s) => s.key == key,
      orElse: () => allSymbols.first,
    );
  }
}
