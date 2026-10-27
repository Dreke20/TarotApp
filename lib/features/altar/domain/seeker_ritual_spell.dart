import 'package:freezed_annotation/freezed_annotation.dart';

part 'seeker_ritual_spell.freezed.dart';
part 'seeker_ritual_spell.g.dart';

/// The seven elemental actions available when forging custom altar rituals.
enum RitualActionType {
  riffleShuffle(glyph: '🎴', title: '3D Riffle & Bridge'),
  celticScatter(glyph: '🌀', title: 'Celtic Chaos Wash'),
  threePilesCut(glyph: '⚖️', title: 'Three Fates Cut'),
  herbSmoke(glyph: '🌿', title: 'Sacred Smoke Smudge'),
  crystalGrid(glyph: '💎', title: 'Crystal Grid Consecration'),
  sacredBreath(glyph: '🫁', title: 'Sacred Pranic Breath'),
  intentionAnchor(glyph: '✨', title: 'Intention & Mantra');

  final String glyph;
  final String title;
  const RitualActionType({required this.glyph, required this.title});
}

/// An individual atomic step within a seeker's ritual spell.
@freezed
abstract class RitualSpellStep with _$RitualSpellStep {
  const factory RitualSpellStep({
    required String id,
    required RitualActionType actionType,
    required String title,
    required String subtitle,
    required String glyph,
    @Default('') String parameter,
    @Default(3) int durationSeconds,
  }) = _RitualSpellStep;

  factory RitualSpellStep.fromJson(Map<String, dynamic> json) =>
      _$RitualSpellStepFromJson(json);
}

/// A complete customized or curated altar ritual spell sequence.
@freezed
abstract class SeekerRitualSpell with _$SeekerRitualSpell {
  const factory SeekerRitualSpell({
    required String id,
    required String name,
    required String description,
    required String glyph,
    @Default('#D4AF37') String accentColorHex,
    required List<RitualSpellStep> steps,
    @Default(false) bool isCurated,
    required DateTime createdAt,
  }) = _SeekerRitualSpell;

  const SeekerRitualSpell._();

  factory SeekerRitualSpell.fromJson(Map<String, dynamic> json) =>
      _$SeekerRitualSpellFromJson(json);

  int get totalDurationSeconds =>
      steps.fold(0, (sum, step) => sum + step.durationSeconds);

  /// 4 Curated sacred ritual spell presets for immediate consecration.
  static final List<SeekerRitualSpell> curatedSpells = [
    SeekerRitualSpell(
      id: 'hermetic_solfeggio',
      name: 'Hermetic Solfeggio Attunement',
      description: 'Palo Santo purification, 4-7-8 pranic breath, and 3-pass Gilbert-Shannon-Reeds riffle.',
      glyph: '🎴',
      accentColorHex: '#D4AF37',
      isCurated: true,
      createdAt: DateTime(2026, 1, 1),
      steps: const [
        RitualSpellStep(
          id: 'step_1',
          actionType: RitualActionType.herbSmoke,
          title: 'Palo Santo Holy Wood Smudge',
          subtitle: 'Clear lingering mental fog and elevate vibration',
          glyph: '🪵',
          parameter: 'palo_santo',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_2',
          actionType: RitualActionType.sacredBreath,
          title: '4-7-8 Pranic Breathwork',
          subtitle: '4 breath cycles centering autonomic consciousness',
          glyph: '🫁',
          parameter: '4_cycles',
          durationSeconds: 4,
        ),
        RitualSpellStep(
          id: 'step_3',
          actionType: RitualActionType.riffleShuffle,
          title: '3-Pass GSR 3D Riffle & Cascade',
          subtitle: 'Gilbert-Shannon-Reeds physical interlacing and bridge snap',
          glyph: '🎴',
          parameter: '3_passes',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_4',
          actionType: RitualActionType.intentionAnchor,
          title: 'Hermetic Axiom Consecration',
          subtitle: 'As above, so below; truth flows unobstructed',
          glyph: '✨',
          parameter: 'As above, so below; truth flows unobstructed.',
          durationSeconds: 2,
        ),
      ],
    ),
    SeekerRitualSpell(
      id: 'twin_flame_consecration',
      name: 'Twin Flame Sol-Luna Consecration',
      description: 'White Sage smoke, Rose Quartz heart grid, and Three Fates intuitive cut for relationship readings.',
      glyph: '☀️',
      accentColorHex: '#FF80BF',
      isCurated: true,
      createdAt: DateTime(2026, 1, 1),
      steps: const [
        RitualSpellStep(
          id: 'step_1',
          actionType: RitualActionType.herbSmoke,
          title: 'White Sage Perimeter Shield',
          subtitle: 'Release past emotional residue and seal sacred space',
          glyph: '🌿',
          parameter: 'white_sage',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_2',
          actionType: RitualActionType.crystalGrid,
          title: 'Rose Quartz Heart Conjunction',
          subtitle: 'Anchor unconditional tenderness and empathic reception',
          glyph: '💎',
          parameter: 'rose_quartz',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_3',
          actionType: RitualActionType.threePilesCut,
          title: 'Three Fates Intuitive Cut',
          subtitle: 'Past, Present, and Future piles reordered by soul intuition',
          glyph: '⚖️',
          parameter: '2,0,1',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_4',
          actionType: RitualActionType.intentionAnchor,
          title: 'Soul Mirror Intention',
          subtitle: 'Two souls unite to mirror divine truth and boundless growth',
          glyph: '✨',
          parameter: 'Two souls unite to mirror divine truth and boundless growth.',
          durationSeconds: 2,
        ),
      ],
    ),
    SeekerRitualSpell(
      id: 'full_moon_shadow_dissolution',
      name: 'Full Moon Shadow Dissolution',
      description: 'Golden Copal resin, Black Tourmaline ward, and Celtic Chaos Wash to disperse negative attachments.',
      glyph: '🌀',
      accentColorHex: '#80E5FF',
      isCurated: true,
      createdAt: DateTime(2026, 1, 1),
      steps: const [
        RitualSpellStep(
          id: 'step_1',
          actionType: RitualActionType.herbSmoke,
          title: 'Golden Copal Solar Flame',
          subtitle: 'Ignite celestial awareness and burn through stagnation',
          glyph: '✨',
          parameter: 'copal_resin',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_2',
          actionType: RitualActionType.crystalGrid,
          title: 'Black Tourmaline Grounding Ward',
          subtitle: 'Absorb psychic interference into earthly silence',
          glyph: '💎',
          parameter: 'black_tourmaline',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_3',
          actionType: RitualActionType.celticScatter,
          title: 'Celtic Chaos Scatter Wash',
          subtitle: '78 cards scrambled in an altar cloth elemental vortex',
          glyph: '🌀',
          parameter: '1_wash',
          durationSeconds: 4,
        ),
        RitualSpellStep(
          id: 'step_4',
          actionType: RitualActionType.intentionAnchor,
          title: 'Shadow Release Declaration',
          subtitle: 'I release all obsolete illusions into the starlight',
          glyph: '🌑',
          parameter: 'I release all obsolete illusions into the starlight.',
          durationSeconds: 2,
        ),
      ],
    ),
    SeekerRitualSpell(
      id: 'morning_solar_ignition',
      name: 'Morning Solar Ignition Spell',
      description: 'Dawn pranic breath, 5-pass riffle cascade, and sovereign will affirmation.',
      glyph: '⚡',
      accentColorHex: '#FFA000',
      isCurated: true,
      createdAt: DateTime(2026, 1, 1),
      steps: const [
        RitualSpellStep(
          id: 'step_1',
          actionType: RitualActionType.sacredBreath,
          title: 'Morning Solar Breathwork',
          subtitle: 'Awaken the inner hearth with dynamic conscious breath',
          glyph: '🫁',
          parameter: '3_cycles',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_2',
          actionType: RitualActionType.riffleShuffle,
          title: '5-Pass Sacred Riffle & Cascade',
          subtitle: 'Maximum physical entropy permutation',
          glyph: '🎴',
          parameter: '5_passes',
          durationSeconds: 3,
        ),
        RitualSpellStep(
          id: 'step_3',
          actionType: RitualActionType.intentionAnchor,
          title: 'Sovereign Manifestation Affirmation',
          subtitle: 'I walk forward as creator and architect of my destiny',
          glyph: '👑',
          parameter: 'I walk forward as creator and architect of my destiny.',
          durationSeconds: 2,
        ),
      ],
    ),
  ];
}
