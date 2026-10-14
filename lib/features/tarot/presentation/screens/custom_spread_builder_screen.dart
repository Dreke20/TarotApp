import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../domain/custom_spread.dart';
import '../notifiers/custom_spread_notifier.dart';
import '../widgets/glass_container.dart';

class CustomSpreadBuilderScreen extends ConsumerStatefulWidget {
  const CustomSpreadBuilderScreen({super.key});

  @override
  ConsumerState<CustomSpreadBuilderScreen> createState() => _CustomSpreadBuilderScreenState();
}

class _CustomSpreadBuilderScreenState extends ConsumerState<CustomSpreadBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    final spreads = ref.watch(customSpreadProvider);

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
          "SEEKER'S GRIMOIRE",
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
        icon: const Icon(Icons.architecture, size: 20),
        label: Text(
          'FORGE SPREAD',
          style: GoogleFonts.cinzel(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        onPressed: () => _openCreateSpreadModal(context),
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
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
          physics: const BouncingScrollPhysics(),
          itemCount: spreads.length,
          itemBuilder: (context, index) {
            final spread = spreads[index];
            return _buildSpreadCard(context, spread, index);
          },
        ),
      ),
    );
  }

  Widget _buildSpreadCard(BuildContext context, CustomSpread spread, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.all(18),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '${spread.positions.length} CARDS',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (spread.isUserCreated)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.etherealLavender.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.etherealLavender.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          'CUSTOM FORGED',
                          style: GoogleFonts.cinzel(
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.etherealLavender,
                          ),
                        ),
                      ),
                  ],
                ),
                if (spread.isUserCreated)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.textMuted),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _confirmDelete(context, spread.id),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              spread.title,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              spread.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: AppColors.textPrimary.withValues(alpha: 0.9),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'SACRED POSITIONS MATRIX:',
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.etherealLavender,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            ...spread.positions.asMap().entries.map((entry) {
              final posIndex = entry.key + 1;
              final posTitle = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                      ),
                      child: Center(
                        child: Text(
                          '$posIndex',
                          style: GoogleFonts.cinzel(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        posTitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright.withValues(alpha: 0.15),
                  foregroundColor: AppColors.goldBright,
                  side: const BorderSide(color: AppColors.goldBright),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ref.read(sensoryServiceProvider).completionHaptic();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Spread "${spread.title}" selected! Return to altar to channel.',
                        style: GoogleFonts.plusJakartaSans(),
                      ),
                      backgroundColor: AppColors.backgroundMidnight,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.style, size: 16),
                label: Text(
                  'SELECT FOR ALTAR CASTING',
                  style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                ),
              ),
            ),
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
          'DISMANTLE SPREAD?',
          style: GoogleFonts.cinzel(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.goldBright),
        ),
        content: Text(
          'Are you sure you wish to banish this custom spread from your grimoire?',
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
              ref.read(customSpreadProvider.notifier).deleteCustomSpread(id);
              Navigator.of(ctx).pop();
            },
            child: Text('DISMANTLE', style: GoogleFonts.cinzel(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _openCreateSpreadModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _CreateSpreadModal(),
    );
  }
}

class _CreateSpreadModal extends ConsumerStatefulWidget {
  const _CreateSpreadModal();

  @override
  ConsumerState<_CreateSpreadModal> createState() => _CreateSpreadModalState();
}

class _CreateSpreadModalState extends ConsumerState<_CreateSpreadModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final List<TextEditingController> _positionControllers = [
    TextEditingController(text: 'Current Foundation & Root Energy'),
    TextEditingController(text: 'Hidden Unconscious Impediment'),
    TextEditingController(text: 'Oracle Cosmic Advice'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    for (final c in _positionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addPosition() {
    if (_positionControllers.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum 10 positions allowed in a single spread matrix.', style: GoogleFonts.plusJakartaSans()),
          backgroundColor: AppColors.backgroundMidnight,
        ),
      );
      return;
    }
    setState(() {
      _positionControllers.add(TextEditingController(text: 'Position ${_positionControllers.length + 1} Intention'));
    });
  }

  void _removePosition(int index) {
    if (_positionControllers.length <= 1) {
      return;
    }
    setState(() {
      final removed = _positionControllers.removeAt(index);
      removed.dispose();
    });
  }

  void _saveSpread() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please grant your sacred spread a title.', style: GoogleFonts.plusJakartaSans()),
          backgroundColor: AppColors.backgroundMidnight,
        ),
      );
      return;
    }

    final positions = _positionControllers
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    if (positions.isEmpty) return;

    ref.read(customSpreadProvider.notifier).addCustomSpread(
      title: _titleController.text,
      description: _descController.text,
      positions: positions,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
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
                  'FORGE SACRED SPREAD',
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
                  Text('SPREAD TITLE', style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _titleController,
                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'e.g. Twin Flame Mirror / Solstice Gateway',
                      hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                      filled: true,
                      fillColor: AppColors.glassFillStrong,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.goldBright)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('SPREAD INTENTION & DESCRIPTION', style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.etherealLavender)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descController,
                    maxLines: 2,
                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, height: 1.4),
                    decoration: InputDecoration(
                      hintText: 'Describe the spiritual inquiry or questions answered by this spread...',
                      hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                      filled: true,
                      fillColor: AppColors.glassFillStrong,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.glassBorder)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.goldBright)),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('POSITIONS (${_positionControllers.length}/10)', style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.etherealLavender)),
                      TextButton.icon(
                        onPressed: _addPosition,
                        icon: const Icon(Icons.add_circle_outline, size: 16, color: AppColors.goldBright),
                        label: Text('ADD POSITION', style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.goldBright)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._positionControllers.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.goldBright.withValues(alpha: 0.15),
                              border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                            ),
                            child: Center(
                              child: Text('${idx + 1}', style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.glassFillStrong,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.glassBorder)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.glassBorder)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.goldBright)),
                              ),
                            ),
                          ),
                          if (_positionControllers.length > 1)
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                              onPressed: () => _removePosition(idx),
                            ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 28),
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
                      onPressed: _saveSpread,
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: Text(
                        'ENGRAVE SPREAD TO GRIMOIRE',
                        style: GoogleFonts.cinzel(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
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
