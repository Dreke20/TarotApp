import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/sacred_herb.dart';
import '../../domain/seeker_ritual_spell.dart';
import '../notifiers/altar_consecration_notifier.dart';
import '../notifiers/custom_ritual_notifier.dart';
import '../notifiers/custom_ritual_state.dart';

/// Modal enabling seekers to browse curated ritual presets, forge custom multi-step
/// altar consecration and shuffle spells, and execute them with sensory feedback.
class CustomRitualForgeModal extends ConsumerStatefulWidget {
  const CustomRitualForgeModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomRitualForgeModal(),
    );
  }

  @override
  ConsumerState<CustomRitualForgeModal> createState() => _CustomRitualForgeModalState();
}

class _CustomRitualForgeModalState extends ConsumerState<CustomRitualForgeModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedGlyph = '🔮';
  final List<RitualSpellStep> _builderSteps = [];

  static const List<String> _availableGlyphs = [
    '🔮', '⚡', '🌿', '🕯️', '✨', '☀️', '🌙', '🎴', '💎', '⚖️', '🪵',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Initialize default builder steps
    _builderSteps.addAll([
      const RitualSpellStep(
        id: 'init_1',
        actionType: RitualActionType.herbSmoke,
        title: 'Palo Santo Purifying Smudge',
        subtitle: 'Consecrate space with sacred holy wood',
        glyph: '🪵',
        parameter: 'palo_santo',
        durationSeconds: 3,
      ),
      const RitualSpellStep(
        id: 'init_2',
        actionType: RitualActionType.riffleShuffle,
        title: '3-Pass Sacred 3D Riffle',
        subtitle: 'Physical GSR card interlacing',
        glyph: '🎴',
        parameter: '3_passes',
        durationSeconds: 3,
      ),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ritualState = ref.watch(customRitualProvider);
    final notifier = ref.read(customRitualProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0C1B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x66D4AF37),
            blurRadius: 24,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ritualState.isRunning
          ? _buildActiveRunnerView(ritualState, notifier)
          : Column(
              children: [
                // Modal Handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 6),
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SACRED RITUAL SPELL FORGE',
                              style: GoogleFonts.cinzel(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Multi-step physical shuffle & altar consecration sequences',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                // Tab Switcher
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1736),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.goldBright.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.goldBright, width: 1.2),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.goldBright,
                    unselectedLabelColor: Colors.white54,
                    labelStyle: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'RITUAL SPELLS'),
                      Tab(text: 'FORGE NEW SPELL'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSpellsListView(ritualState, notifier),
                      _buildForgeBuilderView(notifier),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSpellsListView(CustomRitualState state, CustomRitualNotifier notifier) {
    final spells = state.allSpells;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: spells.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final spell = spells[index];
        return _buildSpellCard(spell, notifier);
      },
    );
  }

  Widget _buildSpellCard(SeekerRitualSpell spell, CustomRitualNotifier notifier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18132A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: spell.isCurated
              ? const Color(0xFFD4AF37).withValues(alpha: 0.5)
              : const Color(0xFF9D4EDD).withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2C2145),
                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
                ),
                child: Center(
                  child: Text(spell.glyph, style: const TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            spell.name,
                            style: GoogleFonts.cinzel(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (spell.isCurated)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                            ),
                            child: const Text(
                              'CURATED PRESET',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 8.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spell.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Steps Horizontal Timeline
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: spell.steps.asMap().entries.map((entry) {
                final i = entry.key;
                final step = entry.value;
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF261C3D),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(step.glyph, style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 4),
                          Text(
                            step.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i < spell.steps.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.arrow_forward_ios, size: 8, color: Colors.white30),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    notifier.startSpellExecution(spell);
                  },
                  icon: const Icon(Icons.auto_awesome, size: 15),
                  label: const Text(
                    '✦ CONSECRATE & RUN SPELL ✦',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: const Color(0xFF0F0C1B),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              if (!spell.isCurated) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white38, size: 18),
                  onPressed: () => notifier.deleteCustomSpell(spell.id),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForgeBuilderView(CustomRitualNotifier notifier) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spell Name Input
          Text(
            'SPELL TITLE',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'e.g. Celestial Golden Dawn Consecration',
              hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
              filled: true,
              fillColor: const Color(0xFF1E1736),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF382B57)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF382B57)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4AF37)),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Glyph Selector
          Text(
            'SACRED TALISMAN GLYPH',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _availableGlyphs.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final glyph = _availableGlyphs[index];
                final isSelected = _selectedGlyph == glyph;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedGlyph = glyph);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.goldBright.withValues(alpha: 0.25)
                          : const Color(0xFF1E1736),
                      border: Border.all(
                        color: isSelected ? AppColors.goldBright : Colors.white12,
                        width: isSelected ? 1.6 : 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(glyph, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Spell Steps Sequence
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RITUAL STEPS SEQUENCE (${_builderSteps.length})',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Current Steps List
          ..._builderSteps.asMap().entries.map((entry) {
            final idx = entry.key;
            final step = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1B152F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                    child: Text(
                      '${idx + 1}',
                      style: const TextStyle(color: Color(0xFFFFD700), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(step.glyph, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          step.subtitle,
                          style: const TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white38, size: 18),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      setState(() => _builderSteps.removeAt(idx));
                    },
                  ),
                ],
              ),
            );
          }),

          // Step Insertion Buttons
          const SizedBox(height: 10),
          Text(
            '+ INSERT RITUAL ACTION',
            style: GoogleFonts.cinzel(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildAddActionButton(
                label: '3D Riffle',
                glyph: '🎴',
                onTap: () => _addStep(
                  RitualActionType.riffleShuffle,
                  '3-Pass GSR 3D Riffle',
                  'Physical card interlacing and bridge snap',
                  '🎴',
                  '3_passes',
                ),
              ),
              _buildAddActionButton(
                label: 'Chaos Wash',
                glyph: '🌀',
                onTap: () => _addStep(
                  RitualActionType.celticScatter,
                  'Celtic Chaos Wash',
                  'Elemental card scatter on consecrated cloth',
                  '🌀',
                  '1_wash',
                ),
              ),
              _buildAddActionButton(
                label: 'Three Fates Cut',
                glyph: '⚖️',
                onTap: () => _addStep(
                  RitualActionType.threePilesCut,
                  'Three Fates Tri-Fold Cut',
                  'Intuitive Past, Present & Future restack',
                  '⚖️',
                  '3_piles',
                ),
              ),
              _buildAddActionButton(
                label: 'Herb Smoke',
                glyph: '🌿',
                onTap: () => _addStep(
                  RitualActionType.herbSmoke,
                  'White Sage Ancestral Smudge',
                  'Release stagnant fields and seal boundary',
                  '🌿',
                  'white_sage',
                ),
              ),
              _buildAddActionButton(
                label: 'Crystal Ward',
                glyph: '💎',
                onTap: () => _addStep(
                  RitualActionType.crystalGrid,
                  'Amethyst Intuition Ward',
                  'Chakra alignment and psychic protection',
                  '💎',
                  'amethyst',
                ),
              ),
              _buildAddActionButton(
                label: 'Pranic Breath',
                glyph: '🫁',
                onTap: () => _addStep(
                  RitualActionType.sacredBreath,
                  'Sacred 4-7-8 Breathwork',
                  '4 pranic breath cycles',
                  '🫁',
                  '4_cycles',
                ),
              ),
              _buildAddActionButton(
                label: 'Intention Mantra',
                glyph: '✨',
                onTap: () => _addStep(
                  RitualActionType.intentionAnchor,
                  'Sacred Intention Consecration',
                  'Anchor personal sovereign willpower',
                  '✨',
                  'Truth & clarity anchor',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Forge Spell Button
          ElevatedButton(
            onPressed: _builderSteps.isEmpty
                ? null
                : () async {
                    HapticFeedback.mediumImpact();
                    final title = _nameController.text.trim().isEmpty
                        ? 'Custom Seeker Consecration'
                        : _nameController.text.trim();

                    final newSpell = SeekerRitualSpell(
                      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                      name: title,
                      description: 'Custom forged seeker spell with ${_builderSteps.length} ritual actions.',
                      glyph: _selectedGlyph,
                      steps: List.from(_builderSteps),
                      isCurated: false,
                      createdAt: DateTime.now(),
                    );

                    await notifier.saveCustomSpell(newSpell);
                    _tabController.animateTo(0);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0F0C1B),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.auto_fix_high, size: 18),
                SizedBox(width: 8),
                Text(
                  '✦ FORGE & BIND RITUAL SPELL ✦',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddActionButton({
    required String label,
    required String glyph,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF261C3D),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF382B57)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(glyph, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  void _addStep(
    RitualActionType type,
    String title,
    String subtitle,
    String glyph,
    String param,
  ) {
    setState(() {
      _builderSteps.add(
        RitualSpellStep(
          id: 'step_${DateTime.now().microsecondsSinceEpoch}',
          actionType: type,
          title: title,
          subtitle: subtitle,
          glyph: glyph,
          parameter: param,
          durationSeconds: 3,
        ),
      );
    });
  }

  Widget _buildActiveRunnerView(CustomRitualState state, CustomRitualNotifier notifier) {
    final spell = state.activeRunningSpell!;
    final step = state.currentStep;
    final totalSteps = spell.steps.length;
    final currentIdx = state.activeStepIndex;
    final progress = totalSteps > 0 ? (currentIdx + 1) / totalSteps : 1.0;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EXECUTING ${spell.name.toUpperCase()}',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.1,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white60),
                onPressed: () => notifier.cancelExecution(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Linear Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD700)),
            ),
          ),
          const SizedBox(height: 30),

          // Central Animated Step Orb
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFD4AF37).withValues(alpha: 0.35),
                  const Color(0xFF9D4EDD).withValues(alpha: 0.1),
                ],
              ),
              border: Border.all(color: const Color(0xFFFFD700), width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Text(
                step?.glyph ?? spell.glyph,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Step Number & Title
          Text(
            'STEP ${currentIdx + 1} OF $totalSteps',
            style: GoogleFonts.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.etherealLavender,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step?.title ?? 'Consecrating Altar...',
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              step?.subtitle ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ),
          const Spacer(),

          // Advance / Complete Button
          ElevatedButton(
            onPressed: () {
              HapticFeedback.heavyImpact();

              // Synchronize with Altar Consecration if it was a smudge or crystal step
              if (step != null && step.actionType == RitualActionType.herbSmoke) {
                final herb = SacredHerb.fromId(step.parameter);
                ref.read(altarConsecrationNotifierProvider.notifier).selectHerb(herb);
                ref.read(altarConsecrationNotifierProvider.notifier).completePurification();
              }

              if (currentIdx + 1 >= totalSteps) {
                notifier.advanceStep();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF1F1735),
                    content: Row(
                      children: [
                        Text(spell.glyph, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${spell.name} successfully consecrated on Altar!',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                notifier.advanceStep();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0F0C1B),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(
              currentIdx + 1 >= totalSteps
                  ? '✦ COMPLETE CONSECRATION ✦'
                  : 'PROCEED TO NEXT STEP ➔',
              style: const TextStyle(
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
