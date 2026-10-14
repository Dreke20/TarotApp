import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';

class VoiceInvocationModal extends StatefulWidget {
  final Function(String query) onQuestionSpoken;

  const VoiceInvocationModal({
    super.key,
    required this.onQuestionSpoken,
  });

  static void show(BuildContext context, {required Function(String) onQuestionSpoken}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VoiceInvocationModal(onQuestionSpoken: onQuestionSpoken),
    );
  }

  @override
  State<VoiceInvocationModal> createState() => _VoiceInvocationModalState();
}

class _VoiceInvocationModalState extends State<VoiceInvocationModal> {
  bool _isListening = false;
  String _spokenText = '';
  final SensoryService _sensory = SensoryService();

  static const List<String> _sacredChants = [
    'What karmic energy is unfolding around me now?',
    'Illuminate the hidden truth in my soulmate connection.',
    'What divine wisdom does my Higher Self wish to speak?',
    'Show me the obstacle blocking my highest spiritual abundance.',
    'How may I align with universal peace and purpose today?',
  ];

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    _sensory.shuffleTremorHaptic();

    if (_isListening) {
      // Simulate sacred speech recognition listening loop
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (!mounted || !_isListening) return;
        setState(() {
          _spokenText = 'What sacred truth must I unveil at this crossroads?';
        });
        _sensory.completionHaptic();
      });
    }
  }

  void _applySpokenText(String text) {
    _sensory.cardSelectionHaptic();
    widget.onQuestionSpoken(text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundMidnight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: AppColors.goldBright, width: 1.5)),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.glassBorder,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'SACRED VOICE INVOCATION',
            style: GoogleFonts.cinzel(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Whisper your divine inquiry into the cosmic ether',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 28),

          // Glowing Mic Orb
          GestureDetector(
            onTap: _toggleListening,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: _isListening
                      ? [AppColors.goldBright, AppColors.backgroundViolet]
                      : [AppColors.cosmicSurface, AppColors.backgroundDeep],
                ),
                border: Border.all(
                  color: _isListening ? AppColors.goldBright : AppColors.glassBorder,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isListening
                        ? AppColors.goldBright.withValues(alpha: 0.5)
                        : Colors.transparent,
                    blurRadius: 30,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _isListening ? Icons.graphic_eq : Icons.mic,
                  size: 38,
                  color: _isListening ? AppColors.backgroundDeep : AppColors.goldBright,
                ),
              ),
            ),
          ).animate(target: _isListening ? 1 : 0)
              .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08), duration: 800.ms),

          const SizedBox(height: 16),
          Text(
            _isListening ? 'CHANNELING ASTRAL VOCAL VIBRATIONS...' : 'TAP ORB TO COMMENCE VOICE CHANT',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: _isListening ? AppColors.goldBright : AppColors.etherealLavender,
              letterSpacing: 1.2,
            ),
          ),

          if (_spokenText.isNotEmpty) ...[
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.glassFillStrong,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '"$_spokenText"',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: AppColors.goldBright, size: 22),
                    onPressed: () => _applySpokenText(_spokenText),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),
          const Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'OR SELECT SACRED INVOCATION CHANT:',
              style: GoogleFonts.cinzel(
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: _sacredChants.length,
              separatorBuilder: (_, _) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final chant = _sacredChants[index];
                return GestureDetector(
                  onTap: () => _applySpokenText(chant),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.glassFill,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      '• $chant',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
