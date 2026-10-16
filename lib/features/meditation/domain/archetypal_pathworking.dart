import '../../../../core/services/ambient_soundscape_service.dart';

/// Represents an individual step within an archetypal meditation pathworking.
class PathworkingStep {
  final String title;
  final String guidanceText;
  final int durationSeconds;

  const PathworkingStep({
    required this.title,
    required this.guidanceText,
    required this.durationSeconds,
  });
}

/// Represents a guided Major Arcana visualization journey.
class ArchetypalPathworking {
  final String id;
  final String cardId;
  final String cardName;
  final String title;
  final String archetype;
  final String description;
  final SoundscapeTrack track;
  final List<PathworkingStep> steps;

  const ArchetypalPathworking({
    required this.id,
    required this.cardId,
    required this.cardName,
    required this.title,
    required this.archetype,
    required this.description,
    required this.track,
    required this.steps,
  });

  String get soundscapeName => track.title;

  int get totalDurationSeconds =>
      steps.fold(0, (acc, step) => acc + step.durationSeconds);

  static const List<ArchetypalPathworking> allPathworkings = [
    ArchetypalPathworking(
      id: 'the_fools_leap',
      cardId: 'major_0_the_fool',
      cardName: 'The Fool',
      title: 'The Leap into Primordial Trust',
      archetype: 'Zero Point Innocence & Fearless Wonder',
      description:
          'Stand upon the windswept precipice of potential. Dissolve the paralyzing fear of the unknown and surrender into primordial cosmic trust.',
      track: SoundscapeTrack.solfeggio432,
      steps: [
        PathworkingStep(
          title: 'The Edge of the Precipice',
          guidanceText:
              'Inhale deeply through your nostrils. Sense the cool mountain breeze upon your face. Before you lies a boundless golden sky, stretching into infinite eternity. You stand at the zero point, free of past burdens, uncluttered by expectation.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Golden Sun Above',
          guidanceText:
              'Feel the radiant white sun warming the crown of your head. Your pack carries only the bare essence of wisdom. Notice your faithful companion by your side, reminding you that joy and instinct are your greatest guides.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The White Rose of Purity',
          guidanceText:
              'In your left hand, visualize a pure white rose. Its fragrance dissolves all anxiety. What you once called uncertainty is now revealed as pure, uncarved potential. You are safe. You are held by the universe.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Sacred Leap',
          guidanceText:
              'Take one light, courageous step forward into the void. The ground does not fall away—wings of divine grace rise up beneath you. You are flying through the cosmos, renewed, brave, and alive.',
          durationSeconds: 45,
        ),
      ],
    ),
    ArchetypalPathworking(
      id: 'the_high_priestess_temple',
      cardId: 'major_2_the_high_priestess',
      cardName: 'The High Priestess',
      title: 'The Temple of the Veiled Moon',
      archetype: 'Subconscious Currents & Intuitive Gnosis',
      description:
          'Pass between the black and white pillars of polarity. Enter the quiet water sanctuary of inner revelation and awaken your direct psychic gnosis.',
      track: SoundscapeTrack.solfeggio741,
      steps: [
        PathworkingStep(
          title: 'Between the Twin Pillars',
          guidanceText:
              'Before you rise the great stone pillars: Boaz the dark obsidian, Jachin the luminous marble. You stand at the sacred center where opposites meet in silent stillness. Breathe in the equilibrium.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Pomegranate Veil',
          guidanceText:
              'Gaze upon the tapestry embroidered with ripe pomegranates and emerald palms. It conceals the great subterranean sea. As you exhale, the veil softly parts, welcoming your quiet awareness.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Scroll of Hidden Wisdom',
          guidanceText:
              'The Priestess sits in quiet grace, the crescent moon cradled at her feet. In her lap rests the sacred scroll of TORA. She extends it toward your heart. Allow her wisdom to enter not as words, but as a deep, resonant knowing.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'Drinking the Living Waters',
          guidanceText:
              'Dip your fingers into the crystal pool flowing from beneath her throne. Its coolness awakens your third eye. Your intuition is clear, untroubled, and true. Trust what you feel.',
          durationSeconds: 45,
        ),
      ],
    ),
    ArchetypalPathworking(
      id: 'the_hermit_lantern',
      cardId: 'major_9_the_hermit',
      cardName: 'The Hermit',
      title: 'The Solitary Mountain Beacon',
      archetype: 'Inner Luminescence & Self-Mastery',
      description:
          'Ascend the highest snowbound ridge above the clouds. Kindle the six-pointed star within your lantern and become the quiet beacon of your own destiny.',
      track: SoundscapeTrack.celestialDrone,
      steps: [
        PathworkingStep(
          title: 'The Ascent Above the Clouds',
          guidanceText:
              'Leave behind the chattering voices of the valley below. Step firmly onto the snowy mountain ridge. The air is crisp, pure, and quiet. Here, in solitude, your true voice can finally be heard.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Staff of Hermetic Truth',
          guidanceText:
              'Grip the golden staff in your left hand. Feel its grounding stability rooted into the stone beneath the snow. You have walked far, seeker. Every trial has refined your spirit into diamond.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Lantern of the Six-Pointed Star',
          guidanceText:
              'Raise the octagonal lantern. Inside burns the golden star of truth. Look into its flame—it does not illuminate miles into the distance; it illuminates only the single next sacred step before your feet.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'Becoming the Beacon',
          guidanceText:
              'You no longer seek the light outside yourself. You are the light. Stand upon the summit, calm, serene, and sovereign, shining your quiet beacon for those who wander in the dark.',
          durationSeconds: 45,
        ),
      ],
    ),
    ArchetypalPathworking(
      id: 'the_death_rebirth_gateway',
      cardId: 'major_13_death',
      cardName: 'Death',
      title: 'The Gateway of Sacred Surrender',
      archetype: 'Alchemical Dissolution & Dawn Rebirth',
      description:
          'Release the outworn shell of an old identity. Lay down your heavy armor and watch the golden dawn rise between the immortal towers.',
      track: SoundscapeTrack.solfeggio528,
      steps: [
        PathworkingStep(
          title: 'The Sunset on the Old World',
          guidanceText:
              'Watch the crimson sun set over the horizon of the past. A cycle has completed its purpose. Acknowledge with deep gratitude all that brought you to this threshold, and prepare to set it down.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'Laying Down the Heavy Armor',
          guidanceText:
              'Unfasten the heavy steel plates of control, grief, and defense. Let them fall to the earth with a soft sigh. As the armor releases, your chest expands, lighter and freer than you have felt in years.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Mystical White Rose',
          guidanceText:
              'A dark banner flutters in the twilight breeze, bearing the five-petaled white rose of purification. True death is not an ending; it is the seed breaking open in darkness so the blossom may emerge.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Dawn Between the Towers',
          guidanceText:
              'Look toward the distant horizon between the two sacred obelisks. A brilliant golden dawn breaks across the waters. You are stripped clean, renewed, and born anew into living light.',
          durationSeconds: 45,
        ),
      ],
    ),
    ArchetypalPathworking(
      id: 'the_star_healing_waters',
      cardId: 'major_17_the_star',
      cardName: 'The Star',
      title: 'The Waters of Celestial Hope',
      archetype: 'Boundless Renewal & Astral Alignment',
      description:
          'Rest beside the starlit spring under the great eight-pointed star of destiny. Pour your living waters back into the earth and drink from the well of eternity.',
      track: SoundscapeTrack.tibetanBowls,
      steps: [
        PathworkingStep(
          title: 'Under the Eight-Pointed Star',
          guidanceText:
              'Gaze upward into the velvet indigo sky. The great central golden star blazes above, flanked by seven brilliant companion lights. A cool celestial calm showers down upon your skin.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Two Crystal Pitchers',
          guidanceText:
              'Kneel beside the crystal clear pool. In your hands are two sacred urns. Pour one pitcher onto the fertile earth, nurturing unseen seeds; pour the other back into the stream, replenishing the collective current.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'The Song of the Sacred Ibis',
          guidanceText:
              'In the sacred tree beside the waters sits the ibis bird of Thoth. Listen to its gentle rustle. Everything you thought was lost is being restored tenfold. Hope is not an illusion; it is the truth of your soul.',
          durationSeconds: 45,
        ),
        PathworkingStep(
          title: 'Drinking from the Eternal Spring',
          guidanceText:
              'Cup your hands and drink from the starlit water. Feel pure, untainted inspiration replenishing every cell of your body. Stand renewed, in perfect harmony with the cosmic design.',
          durationSeconds: 45,
        ),
      ],
    ),
  ];
}
