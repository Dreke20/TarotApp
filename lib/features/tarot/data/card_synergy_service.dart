import '../domain/card_pair_synergy.dart';
import '../domain/tarot_card.dart';

/// Service responsible for calculating the alchemical resonance, elemental
/// reactions, and archetypal synthesis between tarot card pairs.
class CardSynergyService {
  const CardSynergyService();

  /// Determines the primary elemental alignment of a card.
  static String getElement(TarotCard card) {
    if (card.element != null && card.element!.isNotEmpty) {
      return card.element!;
    }
    final suit = card.suit?.toLowerCase() ?? '';
    final name = card.name.toLowerCase();

    if (suit == 'wands' || name.contains('wands')) return 'Fire';
    if (suit == 'cups' || name.contains('cups')) return 'Water';
    if (suit == 'swords' || name.contains('swords')) return 'Air';
    if (suit == 'pentacles' || name.contains('pentacles')) return 'Earth';

    // Major Arcana elemental alignments
    if (name.contains('fool') ||
        name.contains('magician') ||
        name.contains('lovers') ||
        name.contains('justice') ||
        name.contains('star')) {
      return 'Air';
    }
    if (name.contains('priestess') ||
        name.contains('chariot') ||
        name.contains('hanged') ||
        name.contains('death') ||
        name.contains('moon')) {
      return 'Water';
    }
    if (name.contains('emperor') ||
        name.contains('strength') ||
        name.contains('wheel') ||
        name.contains('temperance') ||
        name.contains('tower') ||
        name.contains('sun') ||
        name.contains('judgement')) {
      return 'Fire';
    }
    return 'Earth';
  }

  /// Calculates the bespoke alchemical synergy between two specific cards.
  static CardPairSynergy synthesize(TarotCard card1, TarotCard card2) {
    final e1 = getElement(card1);
    final e2 = getElement(card2);

    final elementalData = _computeElementalReaction(e1, e2);
    final alchemicalPhase = _determineAlchemicalPhase(card1, card2);
    final title = _generateAlchemicalTitle(card1, card2);
    final insight = _generateSynthesisInsight(card1, card2, e1, e2, elementalData);
    final formula = _generateActionableFormula(card1, card2, e1, e2);

    return CardPairSynergy(
      firstCard: card1,
      secondCard: card2,
      alchemicalTitle: title,
      alchemicalPhase: alchemicalPhase,
      element1: e1,
      element2: e2,
      elementalReaction: elementalData.reaction,
      harmonyScore: elementalData.harmonyScore,
      tensionType: elementalData.tensionType,
      synthesisInsight: insight,
      actionableFormula: formula,
    );
  }

  /// Generates all unique dual-card synergy threads from a list of drawn cards.
  static List<CardPairSynergy> generateAllPairs(List<TarotCard> cards) {
    if (cards.length < 2) {
      if (cards.length == 1) {
        // Synthesize single card with its shadow mirror
        final c = cards.first;
        final mirror = c.copyWith(
          name: '${c.name} (Shadow Mirror)',
          isReversed: !c.isReversed,
        );
        return [synthesize(c, mirror)];
      }
      return const [];
    }

    final pairs = <CardPairSynergy>[];
    for (int i = 0; i < cards.length; i++) {
      for (int j = i + 1; j < cards.length; j++) {
        pairs.add(synthesize(cards[i], cards[j]));
      }
    }
    return pairs;
  }

  static _ElementalMeta _computeElementalReaction(String e1, String e2) {
    final set = {e1.toLowerCase(), e2.toLowerCase()};

    if (set.contains('fire') && set.contains('water')) {
      return const _ElementalMeta(
        reaction: 'Fire & Water: Volatile Steam & Sacred Dissolution',
        harmonyScore: 2,
        tensionType: 'Catalytic Friction',
      );
    } else if (set.contains('fire') && set.contains('air')) {
      return const _ElementalMeta(
        reaction: 'Fire & Air: Celestial Conflagration & Swift Ignition',
        harmonyScore: 5,
        tensionType: 'Harmonious Convergence',
      );
    } else if (set.contains('fire') && set.contains('earth')) {
      return const _ElementalMeta(
        reaction: 'Fire & Earth: Volcanic Crucible & Grounded Will',
        harmonyScore: 4,
        tensionType: 'Complementary Polarities',
      );
    } else if (set.contains('water') && set.contains('earth')) {
      return const _ElementalMeta(
        reaction: 'Water & Earth: Fertile Riverbank & Manifested Intuition',
        harmonyScore: 5,
        tensionType: 'Harmonious Convergence',
      );
    } else if (set.contains('water') && set.contains('air')) {
      return const _ElementalMeta(
        reaction: 'Water & Air: Shimmering Mist & Lucid Emotion',
        harmonyScore: 4,
        tensionType: 'Complementary Polarities',
      );
    } else if (set.contains('air') && set.contains('earth')) {
      return const _ElementalMeta(
        reaction: 'Air & Earth: Sacred Architecture & Structured Truth',
        harmonyScore: 4,
        tensionType: 'Complementary Polarities',
      );
    } else if (set.contains('fire')) {
      return const _ElementalMeta(
        reaction: 'Double Fire: Solar Flare & Unchecked Combustion',
        harmonyScore: 3,
        tensionType: 'Amplified Intensity',
      );
    } else if (set.contains('water')) {
      return const _ElementalMeta(
        reaction: 'Double Water: Oceanic Abyss & Profound Surrender',
        harmonyScore: 4,
        tensionType: 'Emotional Submersion',
      );
    } else if (set.contains('air')) {
      return const _ElementalMeta(
        reaction: 'Double Air: Astral Hurricane & Hyper-Rational Clarity',
        harmonyScore: 3,
        tensionType: 'Intellectual Cyclone',
      );
    } else {
      return const _ElementalMeta(
        reaction: 'Double Earth: Adamantine Bedrock & Sovereign Stability',
        harmonyScore: 5,
        tensionType: 'Unshakable Foundation',
      );
    }
  }

  static String _determineAlchemicalPhase(TarotCard c1, TarotCard c2) {
    final n1 = c1.name.toLowerCase();
    final n2 = c2.name.toLowerCase();

    // Nigredo: Shadow, breakdown, release, reversal
    if (c1.isReversed ||
        c2.isReversed ||
        n1.contains('tower') ||
        n2.contains('tower') ||
        n1.contains('death') ||
        n2.contains('death') ||
        n1.contains('devil') ||
        n2.contains('devil') ||
        n1.contains('three of swords') ||
        n2.contains('three of swords') ||
        n1.contains('ten of swords') ||
        n2.contains('ten of swords')) {
      return 'Nigredo (The Sacred Dissolution)';
    }

    // Albedo: Purification, subconscious healing, lunar illumination
    if (n1.contains('star') ||
        n2.contains('star') ||
        n1.contains('moon') ||
        n2.contains('moon') ||
        n1.contains('priestess') ||
        n2.contains('priestess') ||
        n1.contains('temperance') ||
        n2.contains('temperance') ||
        n1.contains('hermit') ||
        n2.contains('hermit')) {
      return 'Albedo (The Lunar Purification)';
    }

    // Citrinitas: Intellectual awakening, solar solar dawn, visionary strategy
    if (n1.contains('magician') ||
        n2.contains('magician') ||
        n1.contains('hierophant') ||
        n2.contains('hierophant') ||
        n1.contains('judgement') ||
        n2.contains('judgement') ||
        n1.contains('swords') ||
        n2.contains('swords')) {
      return 'Citrinitas (The Solar Awakening)';
    }

    // Rubedo: Wholeness, sovereign triumph, divine fruition
    return 'Rubedo (The Sovereign Transmutation)';
  }

  static String _generateAlchemicalTitle(TarotCard c1, TarotCard c2) {
    final n1 = c1.name.toLowerCase();
    final n2 = c2.name.toLowerCase();

    // Famous archetypal combinations
    if ((n1.contains('tower') && n2.contains('three of swords')) ||
        (n2.contains('tower') && n1.contains('three of swords'))) {
      return 'The Shattering of Outdated Mental Constructs';
    }
    if ((n1.contains('magician') && n2.contains('priestess')) ||
        (n2.contains('magician') && n1.contains('priestess'))) {
      return 'The Hermetic Conjunction of Will & Mystery';
    }
    if ((n1.contains('emperor') && n2.contains('empress')) ||
        (n2.contains('emperor') && n1.contains('empress'))) {
      return 'The Sovereign Union of Structure & Abundant Grace';
    }
    if ((n1.contains('death') && n2.contains('fool')) ||
        (n2.contains('death') && n1.contains('fool'))) {
      return 'The Zero-Point Vortex of Radical Rebirth';
    }
    if ((n1.contains('sun') && n2.contains('star')) ||
        (n2.contains('sun') && n1.contains('star'))) {
      return 'The Radiant Nexus of Celestial Illumination';
    }
    if ((n1.contains('chariot') && n2.contains('strength')) ||
        (n2.contains('chariot') && n1.contains('strength'))) {
      return 'The Mastered Momentum of Savage Grace';
    }
    if ((n1.contains('lovers') && n2.contains('two of cups')) ||
        (n2.contains('lovers') && n1.contains('two of cups'))) {
      return 'The Sacred Mirror of Transcendent Union';
    }

    // Dynamic title generator
    final firstDescriptor = _cardAlchemicalDescriptor(c1);
    final secondDescriptor = _cardAlchemicalDescriptor(c2);
    return 'The $firstDescriptor meets The $secondDescriptor';
  }

  static String _cardAlchemicalDescriptor(TarotCard card) {
    final name = card.name.toLowerCase();
    if (name.contains('fool')) return 'Spiritual Leap';
    if (name.contains('magician')) return 'Conscious Will';
    if (name.contains('priestess')) return 'Veiled Oracle';
    if (name.contains('empress')) return 'Fertile Matrix';
    if (name.contains('emperor')) return 'Architectural Law';
    if (name.contains('hierophant')) return 'Ancestral Bridge';
    if (name.contains('lovers')) return 'Sacred Duality';
    if (name.contains('chariot')) return 'Triumphant Vector';
    if (name.contains('strength')) return 'Compassionate Lion';
    if (name.contains('hermit')) return 'Inner Lantern';
    if (name.contains('wheel')) return 'Cosmic Fulcrum';
    if (name.contains('justice')) return 'Karmic Balance';
    if (name.contains('hanged')) return 'Holy Inversion';
    if (name.contains('death')) return 'Scaffold of Rebirth';
    if (name.contains('temperance')) return 'Alchemical Blend';
    if (name.contains('devil')) return 'Chamber of Shadows';
    if (name.contains('tower')) return 'Lightning Crucible';
    if (name.contains('star')) return 'Cosmic Fountain';
    if (name.contains('moon')) return 'Abyssal Dream';
    if (name.contains('sun')) return 'Golden Dawn';
    if (name.contains('judgement')) return 'Aura Awakening';
    if (name.contains('world')) return 'Ouroboros Completion';

    final suit = card.suit?.toLowerCase() ?? '';
    if (suit == 'wands') return 'Sacred Flame';
    if (suit == 'cups') return 'Flowing Chalice';
    if (suit == 'swords') return 'Lucid Blade';
    if (suit == 'pentacles') return 'Solid Talisman';

    return card.name;
  }

  static String _generateSynthesisInsight(
    TarotCard c1,
    TarotCard c2,
    String e1,
    String e2,
    _ElementalMeta meta,
  ) {
    final pos1 = c1.positionName != null ? ' (${c1.positionName})' : '';
    final pos2 = c2.positionName != null ? ' (${c2.positionName})' : '';
    final rev1 = c1.isReversed ? ' reversed (internalized current)' : '';
    final rev2 = c2.isReversed ? ' reversed (internalized current)' : '';

    final m1 = c1.isReversed ? c1.meaningReversed : c1.meaningUpright;
    final m2 = c2.isReversed ? c2.meaningReversed : c2.meaningUpright;

    return 'When ${c1.name}$pos1$rev1 weaves with ${c2.name}$pos2$rev2, their elemental confluence creates ${meta.reaction}. '
        '${c1.name} introduces the force of "$m1", while ${c2.name} anchors the counterpart of "$m2". '
        'Under this ${meta.tensionType.toLowerCase()}, these two energies do not merely sit side-by-side; they catalyze a new vibrational state. '
        'Rather than viewing them as isolated forces, the Oracle illuminates their dialectic: the challenges of one are transmuted by the sovereign gifts of the other.';
  }

  static String _generateActionableFormula(
    TarotCard c1,
    TarotCard c2,
    String e1,
    String e2,
  ) {
    if (e1 == 'Fire' && e2 == 'Water' || e1 == 'Water' && e2 == 'Fire') {
      return 'Alchemical Vapor Practice: Engage in breathwork that cools fiery impatience while allowing deep emotional truths to be spoken without burning bridges.';
    } else if (e1 == 'Air' && e2 == 'Earth' || e1 == 'Earth' && e2 == 'Air') {
      return 'Sacred Architecture Protocol: Write down the abstract vision of ${c1.name} onto parchment, and outline 3 concrete physical milestones to ground ${c2.name} within 7 days.';
    } else if (e1 == 'Fire' && e2 == 'Air' || e1 == 'Air' && e2 == 'Fire') {
      return 'Ignition Catalyst: Channel the swift brainstorm of ideas immediately into creative expression before over-analysis dims the sacred spark.';
    } else if (e1 == 'Water' && e2 == 'Earth' || e1 == 'Earth' && e2 == 'Water') {
      return 'Fertile Manifestation Ritual: Place a glass of spring water on your altar overnight, drinking it at dawn while declaring the tangible form you are birthing.';
    } else {
      return 'Somatic Integration: Hold your hands over your heart center, breathing in the high vibration of ${c1.name} and exhaling the grounding resonance of ${c2.name}.';
    }
  }
}

class _ElementalMeta {
  final String reaction;
  final int harmonyScore;
  final String tensionType;

  const _ElementalMeta({
    required this.reaction,
    required this.harmonyScore,
    required this.tensionType,
  });
}
