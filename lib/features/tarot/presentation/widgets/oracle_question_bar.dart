import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../voice_oracle/presentation/widgets/hands_free_communion_modal.dart';
import '../notifiers/reading_notifier.dart';
import 'glass_container.dart';

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
              Container(
                margin: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldBright.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.goldBright.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.mic, size: 19, color: AppColors.goldBright),
                  tooltip: 'Sacred Voice Invocation',
                  padding: const EdgeInsets.all(7),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    HandsFreeCommunionModal.show(
                      context,
                      onQuestionCommitted: (spoken) {
                        controller.text = spoken;
                        notifier.setQuestion(spoken);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Quick prompt suggestions
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: quickPrompts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final prompt = quickPrompts[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    controller.text = prompt;
                    notifier.setQuestion(prompt);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFF181522),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.goldBright.withValues(alpha: 0.35),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '✦ ',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.goldBright,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          prompt,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
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
