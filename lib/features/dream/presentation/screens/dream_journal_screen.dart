import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../data/jungian_symbol_data.dart';
import '../../domain/dream_entry.dart';
import '../notifiers/dream_notifier.dart';

class DreamJournalScreen extends ConsumerStatefulWidget {
  const DreamJournalScreen({super.key});

  @override
  ConsumerState<DreamJournalScreen> createState() => _DreamJournalScreenState();
}

class _DreamJournalScreenState extends ConsumerState<DreamJournalScreen> {
  @override
  Widget build(BuildContext context) {
    final dreams = ref.watch(dreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ASTRAL DREAM JOURNAL',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.goldBright,
        foregroundColor: AppColors.backgroundDeep,
        icon: const Icon(Icons.nightlight_round, size: 20),
        label: Text(
          'RECORD DREAM',
          style: GoogleFonts.cinzel(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        onPressed: () => _openRecordDreamSheet(context),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.3,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.5),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: dreams.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cosmicSurface.withValues(alpha: 0.4),
                          border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldBright.withValues(alpha: 0.2),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text('🌙', style: TextStyle(fontSize: 42)),
                        ),
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(begin: const Offset(0.96, 0.96), end: const Offset(1.04, 1.04), duration: 2.seconds),
                      const SizedBox(height: 24),
                      Text(
                        'THE VEIL OF HYPNOS IS QUIET',
                        style: GoogleFonts.cinzel(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Log your nighttime visions to unearth subconscious archetypes and reveal the Tarot cards whispering to your soul.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.goldBright,
                          foregroundColor: AppColors.backgroundDeep,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => _openRecordDreamSheet(context),
                        icon: const Icon(Icons.auto_awesome, size: 16),
                        label: Text(
                          'LOG YOUR FIRST DREAM',
                          style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
                physics: const BouncingScrollPhysics(),
                itemCount: dreams.length,
                itemBuilder: (context, index) {
                  final dream = dreams[index];
                  return _buildDreamCard(context, dream, index);
                },
              ),
      ),
    );
  }

  Widget _buildDreamCard(BuildContext context, DreamEntry dream, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.all(16),
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.8),
        borderColor: AppColors.goldBright.withValues(alpha: 0.35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        dream.mood.toUpperCase(),
                        style: GoogleFonts.cinzel(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${dream.recordedAt.month}/${dream.recordedAt.day}/${dream.recordedAt.year}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.textMuted),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _confirmDelete(context, dream.id),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              dream.title,
              style: GoogleFonts.cinzel(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              dream.narrative,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: AppColors.textPrimary,
                height: 1.45,
              ),
            ),
            if (dream.symbols.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: dream.symbols.map((k) {
                  final sym = JungianArchetypes.findByKey(k);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Text(
                      '${sym.icon} ${sym.name.split("/").first.trim()}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: AppColors.etherealLavender,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            if (dream.correlatedTarotCardName != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.goldBright.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 15, color: AppColors.goldBright),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Jungian Oracle Link: ${dream.correlatedTarotCardName} (${dream.archetypalMessage ?? "Archetype"})',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (dream.jungianAnalysis != null) ...[
              const SizedBox(height: 10),
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(top: 6),
                  title: Text(
                    'JUNGIAN PSYCHE DECODER',
                    style: GoogleFonts.cinzel(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.etherealLavender,
                      letterSpacing: 1.2,
                    ),
                  ),
                  children: [
                    Text(
                      dream.jungianAnalysis!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        color: AppColors.textPrimary.withValues(alpha: 0.9),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 350.ms, delay: (index * 60).ms).slideY(begin: 0.08, end: 0);
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundMidnight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.glassBorder),
        ),
        title: Text(
          'RELEASE MEMORY?',
          style: GoogleFonts.cinzel(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.goldBright),
        ),
        content: Text(
          'Are you sure you wish to banish this dream memory from your astral grimoire?',
          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('KEEP', style: GoogleFonts.cinzel(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withValues(alpha: 0.8)),
            onPressed: () {
              ref.read(dreamProvider.notifier).deleteDream(id);
              Navigator.of(ctx).pop();
            },
            child: Text('RELEASE', style: GoogleFonts.cinzel(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _openRecordDreamSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _RecordDreamModal(),
    );
  }
}

class _RecordDreamModal extends ConsumerStatefulWidget {
  const _RecordDreamModal();

  @override
  ConsumerState<_RecordDreamModal> createState() => _RecordDreamModalState();
}

class _RecordDreamModalState extends ConsumerState<_RecordDreamModal> {
  final _titleController = TextEditingController();
  final _narrativeController = TextEditingController();
  String _selectedMood = 'Mystical';
  final List<String> _selectedSymbols = [];

  static const List<String> _moods = [
    'Mystical',
    'Lucid',
    'Prophetic',
    'Serene',
    'Turbulent',
    'Chaotic',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _narrativeController.dispose();
    super.dispose();
  }

  void _saveDream() {
    if (_narrativeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please recount at least a whisper of your dream narrative.',
            style: GoogleFonts.plusJakartaSans(),
          ),
          backgroundColor: AppColors.backgroundMidnight,
        ),
      );
      return;
    }

    ref.read(dreamProvider.notifier).addDream(
      title: _titleController.text,
      narrative: _narrativeController.text,
      mood: _selectedMood,
      symbolKeys: _selectedSymbols,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.backgroundMidnight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: AppColors.goldBright, width: 1.5)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 8),
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.glassBorder,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CONSECRATE DREAM VISION',
                  style: GoogleFonts.cinzel(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 1.5,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textMuted, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.glassBorder, height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DREAM TITLE',
                    style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _titleController,
                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'e.g. Flight Above the Glass Tower',
                      hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                      filled: true,
                      fillColor: AppColors.glassFillStrong,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.glassBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.goldBright),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'NARRATIVE OF THE UNCONSCIOUS',
                    style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _narrativeController,
                    maxLines: 5,
                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, height: 1.4),
                    decoration: InputDecoration(
                      hintText: 'Record the visions, sounds, sensations, and emotional atmosphere of the dream realm...',
                      hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                      filled: true,
                      fillColor: AppColors.glassFillStrong,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.glassBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.goldBright),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'DREAM MOOD',
                    style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _moods.map((mood) {
                      final isSelected = _selectedMood == mood;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMood = mood),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.goldBright : AppColors.glassFillStrong,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                            ),
                          ),
                          child: Text(
                            mood.toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.backgroundDeep : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'JUNGIAN ARCHETYPES PRESENT',
                    style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select all symbols manifested in your dream for immediate oracle decoding:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: JungianArchetypes.allSymbols.map((sym) {
                      final isSelected = _selectedSymbols.contains(sym.key);
                      return FilterChip(
                        selected: isSelected,
                        label: Text('${sym.icon} ${sym.name.split("/").first.trim()}'),
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: isSelected ? AppColors.backgroundDeep : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        selectedColor: AppColors.goldBright,
                        backgroundColor: AppColors.glassFillStrong,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                          ),
                        ),
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedSymbols.add(sym.key);
                            } else {
                              _selectedSymbols.remove(sym.key);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldBright,
                        foregroundColor: AppColors.backgroundDeep,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                      ),
                      onPressed: _saveDream,
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: Text(
                        'SEAL DREAM INTO THE GRIMOIRE',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
