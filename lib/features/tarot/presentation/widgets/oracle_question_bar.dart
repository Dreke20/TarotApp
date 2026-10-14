import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../notifiers/reading_notifier.dart';
import 'glass_container.dart';
import 'voice_invocation_modal.dart';

/// Cosmic inquiry search bar with curated prompt suggestion chips.
class OracleQuestionBar extends StatelessWidget {
  final TextEditingController controller;
  final ReadingNotifier notifier;
  final List<String> quickPrompts;

  const OracleQuestionBar({
    super.key,
    required this.controller,
    required this.notifier,
    required this.quickPrompts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          borderRadius: 18,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              const Icon(
                Icons.psychology,
                color: AppColors.etherealLavender,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (val) => notifier.setQuestion(val),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What guidance do you seek from the cosmos?',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, size: 16, color: AppColors.textMuted),
                  onPressed: () {
                    controller.clear();
                    notifier.setQuestion('');
                  },
                ),
              IconButton(
                icon: const Icon(Icons.mic_none, size: 20, color: AppColors.goldBright),
                tooltip: 'Sacred Voice Invocation',
                onPressed: () {
                  VoiceInvocationModal.show(
                    context,
                    onQuestionSpoken: (spoken) {
                      controller.text = spoken;
                      notifier.setQuestion(spoken);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Quick prompt suggestions
        SizedBox(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: quickPrompts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final prompt = quickPrompts[index];
              return GestureDetector(
                onTap: () {
                  controller.text = prompt;
                  notifier.setQuestion(prompt);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.glassFill,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.glassBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    prompt,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
