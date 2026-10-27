import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../notifiers/hands_free_voice_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../../monetization/presentation/notifiers/bazaar_notifier.dart';
import '../../../monetization/presentation/widgets/mystic_bazaar_modal.dart';

/// Interactive modal sheet for hands-free voice communion with the Oracle.
class HandsFreeCommunionModal extends ConsumerWidget {
  final ValueChanged<String>? onQuestionCommitted;

  const HandsFreeCommunionModal({super.key, this.onQuestionCommitted});

  static Future<void> show(BuildContext context, {ValueChanged<String>? onQuestionCommitted}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HandsFreeCommunionModal(onQuestionCommitted: onQuestionCommitted),
    );
  }

  static const List<String> _sacredInquiries = [
    'What energy surrounds my path today?',
    'What hidden truth is seeking to emerge?',
    'How do I align with my highest soul calling?',
    'What lesson is this challenge offering me?',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceState = ref.watch(handsFreeVoiceNotifierProvider);
    final voiceNotifier = ref.read(handsFreeVoiceNotifierProvider.notifier);

    final isListening = voiceState.isListening;
    final transcript = voiceState.currentTranscript;
    final soundLevel = voiceState.soundLevel.clamp(0.0, 10.0);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.backgroundMidnight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: AppColors.goldBright, width: 1.5),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.goldMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        border: Border.all(color: AppColors.goldBright, width: 1.2),
                      ),
                      child: const Icon(Icons.mic, color: AppColors.goldBright, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VOICE ORACLE',
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'Hands-Free Atmospheric Communion',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => MysticBazaarModal.show(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.goldBright.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.goldBright, width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('✦', style: TextStyle(color: AppColors.goldBright, fontSize: 12)),
                            const SizedBox(width: 4),
                            Consumer(
                              builder: (context, ref, _) {
                                final shards = ref.watch(bazaarProvider).shards;
                                return Text(
                                  '$shards',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                      onPressed: () {
                        voiceNotifier.stopListening();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Glowing Concentric Sound Wave Orb
                  Center(
                    child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                if (isListening) {
                  voiceNotifier.stopListening();
                } else {
                  voiceNotifier.startListening();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Wave Ring
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 130.0 + (soundLevel * 6.0),
                    height: 130.0 + (soundLevel * 6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isListening
                          ? AppColors.goldBright.withValues(alpha: (0.08 + (soundLevel * 0.02)).clamp(0.0, 1.0))
                          : Colors.transparent,
                      border: Border.all(
                        color: isListening
                            ? AppColors.goldBright.withValues(alpha: 0.3)
                            : AppColors.glassBorder,
                        width: 1.2,
                      ),
                    ),
                  ),
                  // Middle Ring
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 100.0 + (soundLevel * 4.0),
                    height: 100.0 + (soundLevel * 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isListening
                          ? AppColors.goldBright.withValues(alpha: 0.18)
                          : AppColors.cosmicSurface,
                      border: Border.all(
                        color: isListening ? AppColors.goldBright : AppColors.glassBorder,
                        width: 1.4,
                      ),
                    ),
                  ),
                  // Center Mic Core
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isListening
                          ? const RadialGradient(colors: [AppColors.goldBright, AppColors.goldDark])
                          : const RadialGradient(colors: [AppColors.cosmicSurface, AppColors.backgroundMidnight]),
                      boxShadow: isListening
                          ? [
                              BoxShadow(
                                color: AppColors.goldBright.withValues(alpha: 0.5),
                                blurRadius: 20,
                                spreadRadius: 3,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                      color: isListening ? AppColors.backgroundDeep : AppColors.goldBright,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Listening Status & VAD Info
          Text(
            isListening ? 'COMMUNING WITH ORACLE...' : 'TAP TO BEGIN SACRED COMMUNION',
            style: GoogleFonts.cinzel(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: isListening ? AppColors.goldBright : AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Live Transcription Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GlassContainer(
              padding: const EdgeInsets.all(16),
              borderRadius: 16,
              fillColor: AppColors.cosmicSurface.withValues(alpha: 0.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 13,
                            color: isListening ? AppColors.goldBright : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'SPOKEN INTENTION',
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldMuted,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      if (transcript.isNotEmpty)
                        GestureDetector(
                          onTap: () => voiceNotifier.clearTranscript(),
                          child: Text(
                            'CLEAR',
                            style: GoogleFonts.cinzel(fontSize: 9, color: AppColors.textSecondary),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transcript.isEmpty
                        ? (isListening
                            ? 'Speak your question freely; atmospheric audio has been ducked...'
                            : 'Speak to the altar, or choose an inquiry below...')
                        : '"$transcript"',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontStyle: transcript.isEmpty ? FontStyle.italic : FontStyle.normal,
                      color: transcript.isEmpty ? AppColors.textSecondary : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Sacred Inquiry Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORACULAR INSPIRATIONS',
                  style: GoogleFonts.cinzel(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.goldMuted),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _sacredInquiries.map((inquiry) {
                    return GestureDetector(
                      onTap: () async {
                        HapticFeedback.selectionClick();
                        await voiceNotifier.commitInquiry(inquiry);
                        onQuestionCommitted?.call(inquiry);
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cosmicSurface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: Text(
                          inquiry,
                          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),

          // Commit Button
          if (transcript.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    HapticFeedback.mediumImpact();
                    await voiceNotifier.commitInquiry(transcript);
                    onQuestionCommitted?.call(transcript);
                    if (context.mounted) Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check, color: AppColors.backgroundDeep),
                  label: Text(
                    'ANCHOR INQUIRY TO SACRED ALTAR',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundDeep,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
