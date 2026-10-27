/// Categories grouping sacred soundscape layers.
enum SoundLayerCategory {
  frequency('Sacred Frequencies', 'Solfeggio tones & pure planetary vibrations', '🪐'),
  instrument('Temple Instruments', 'Singing bowls, resonant chimes & monastic bells', '🔔'),
  nature('Elemental Atmospheres', 'Astral winds, cleansing rainfall & temple fire', '🌿');

  final String title;
  final String description;
  final String glyph;

  const SoundLayerCategory(this.title, this.description, this.glyph);
}

/// A specific sound track within a layer.
class SoundLayerTrack {
  final String id;
  final String title;
  final String? hz;
  final SoundLayerCategory category;
  final String assetPath;
  final String fallbackUrl;
  final String description;
  final String glyph;

  const SoundLayerTrack({
    required this.id,
    required this.title,
    this.hz,
    required this.category,
    required this.assetPath,
    required this.fallbackUrl,
    required this.description,
    required this.glyph,
  });

  // Built-in Frequency Tracks
  static const solfeggio432 = SoundLayerTrack(
    id: 'freq_432',
    title: 'Cosmic Harmony',
    hz: '432 Hz',
    category: SoundLayerCategory.frequency,
    assetPath: 'audio/solfeggio_432.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/low_frequency_hum.ogg',
    description: 'Verdi’s vibrational tuning for cellular peace and grounding',
    glyph: '🪐',
  );

  static const solfeggio528 = SoundLayerTrack(
    id: 'freq_528',
    title: 'Miracles & Heart',
    hz: '528 Hz',
    category: SoundLayerCategory.frequency,
    assetPath: 'audio/solfeggio_528.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/force_field_loop.ogg',
    description: 'The golden love frequency for energetic restoration and clarity',
    glyph: '💚',
  );

  static const solfeggio741 = SoundLayerTrack(
    id: 'freq_741',
    title: 'Intuition Awakening',
    hz: '741 Hz',
    category: SoundLayerCategory.frequency,
    assetPath: 'audio/solfeggio_741.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/alien_beacon_loop.ogg',
    description: 'Dissolves mental fog and awakens psychic perception',
    glyph: '👁️',
  );

  static const celestialDrone = SoundLayerTrack(
    id: 'freq_celestial',
    title: 'Astral Void Hum',
    hz: '963 Hz',
    category: SoundLayerCategory.frequency,
    assetPath: 'audio/celestial_drone.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/space_ambience_hum.ogg',
    description: 'Deep cosmic overtone connecting with higher consciousness',
    glyph: '🌌',
  );

  // Built-in Temple Instruments
  static const tibetanBowls = SoundLayerTrack(
    id: 'inst_bowls',
    title: 'Tibetan Singing Bowls',
    category: SoundLayerCategory.instrument,
    assetPath: 'audio/tibetan_bowls.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/ambiences/wind_chimes_breeze.ogg',
    description: 'Seven-metal alloy bowls creating concentric harmonic waves',
    glyph: '🥣',
  );

  static const crystalChimes = SoundLayerTrack(
    id: 'inst_chimes',
    title: 'Celestial Crystal Chimes',
    category: SoundLayerCategory.instrument,
    assetPath: 'audio/tibetan_bowls.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/ambiences/wind_chimes_breeze.ogg',
    description: 'High-vibrational quartz chimes that clear stagnant energy',
    glyph: '🎐',
  );

  static const monasticDrone = SoundLayerTrack(
    id: 'inst_monastic',
    title: 'Monastic Temple Resonance',
    category: SoundLayerCategory.instrument,
    assetPath: 'audio/celestial_drone.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/low_frequency_hum.ogg',
    description: 'Deep sanctuary chanting reverberating in an ancient stone temple',
    glyph: '🛕',
  );

  // Built-in Elemental Nature
  static const astralBreeze = SoundLayerTrack(
    id: 'nat_wind',
    title: 'Temple Night Wind',
    category: SoundLayerCategory.nature,
    assetPath: 'audio/astral_breeze.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/weather/wind_howl.ogg',
    description: 'Gentle night wind whispering through sacred pine and cedar groves',
    glyph: '💨',
  );

  static const sacredRain = SoundLayerTrack(
    id: 'nat_rain',
    title: 'Astral Downpour',
    category: SoundLayerCategory.nature,
    assetPath: 'audio/astral_breeze.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/weather/wind_howl.ogg',
    description: 'Purifying rain falling on a quiet temple courtyard',
    glyph: '🌧️',
  );

  static const templeEmbers = SoundLayerTrack(
    id: 'nat_fire',
    title: 'Sacred Altar Embers',
    category: SoundLayerCategory.nature,
    assetPath: 'audio/astral_breeze.wav',
    fallbackUrl: 'https://actions.google.com/sounds/v1/science_fiction/low_frequency_hum.ogg',
    description: 'Gentle crackle of sandalwood and frankincense on glowing coals',
    glyph: '🔥',
  );

  static const List<SoundLayerTrack> allTracks = [
    solfeggio432,
    solfeggio528,
    solfeggio741,
    celestialDrone,
    tibetanBowls,
    crystalChimes,
    monasticDrone,
    astralBreeze,
    sacredRain,
    templeEmbers,
  ];

  static List<SoundLayerTrack> forCategory(SoundLayerCategory cat) =>
      allTracks.where((t) => t.category == cat).toList();
}

/// A pre-curated or custom multi-layer soundscape mixture.
class SoundPreset {
  final String id;
  final String name;
  final String description;
  final String glyph;
  final SoundLayerTrack frequencyTrack;
  final double frequencyVolume;
  final SoundLayerTrack instrumentTrack;
  final double instrumentVolume;
  final SoundLayerTrack natureTrack;
  final double natureVolume;

  const SoundPreset({
    required this.id,
    required this.name,
    required this.description,
    required this.glyph,
    required this.frequencyTrack,
    required this.frequencyVolume,
    required this.instrumentTrack,
    required this.instrumentVolume,
    required this.natureTrack,
    required this.natureVolume,
  });

  static const astralScrying = SoundPreset(
    id: 'preset_scrying',
    name: 'Astral Scrying Portal',
    description: '432 Hz grounding coupled with crystal chimes and nocturnal wind',
    glyph: '🔮',
    frequencyTrack: SoundLayerTrack.solfeggio432,
    frequencyVolume: 0.75,
    instrumentTrack: SoundLayerTrack.crystalChimes,
    instrumentVolume: 0.45,
    natureTrack: SoundLayerTrack.astralBreeze,
    natureVolume: 0.35,
  );

  static const heartAwakening = SoundPreset(
    id: 'preset_heart',
    name: 'Heart & Miracle Grace',
    description: '528 Hz miracle frequency blended with Tibetan bowls and downpour',
    glyph: '💚',
    frequencyTrack: SoundLayerTrack.solfeggio528,
    frequencyVolume: 0.80,
    instrumentTrack: SoundLayerTrack.tibetanBowls,
    instrumentVolume: 0.50,
    natureTrack: SoundLayerTrack.sacredRain,
    natureVolume: 0.40,
  );

  static const thirdEyeClarity = SoundPreset(
    id: 'preset_thirdeye',
    name: 'Third Eye Awakening',
    description: '741 Hz psychic cleanse with monastic drone and night breeze',
    glyph: '👁️',
    frequencyTrack: SoundLayerTrack.solfeggio741,
    frequencyVolume: 0.70,
    instrumentTrack: SoundLayerTrack.monasticDrone,
    instrumentVolume: 0.55,
    natureTrack: SoundLayerTrack.astralBreeze,
    natureVolume: 0.30,
  );

  static const templeConsecration = SoundPreset(
    id: 'preset_consecration',
    name: 'Temple Altar Consecration',
    description: '432 Hz harmony with singing bowls and crackling sandalwood embers',
    glyph: '🔥',
    frequencyTrack: SoundLayerTrack.solfeggio432,
    frequencyVolume: 0.65,
    instrumentTrack: SoundLayerTrack.tibetanBowls,
    instrumentVolume: 0.60,
    natureTrack: SoundLayerTrack.templeEmbers,
    natureVolume: 0.45,
  );

  static const List<SoundPreset> allPresets = [
    astralScrying,
    heartAwakening,
    thirdEyeClarity,
    templeConsecration,
  ];
}
