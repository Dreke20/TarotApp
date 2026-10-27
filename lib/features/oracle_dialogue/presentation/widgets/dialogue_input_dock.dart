import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

/// Bottom dock: typed fallback input plus hands-free and voice toggles.
class DialogueInputDock extends StatefulWidget {
  const DialogueInputDock({
    super.key,
    required this.onSend,
    required this.isHandsFree,
    required this.isVoiceMuted,
    required this.onToggleHandsFree,
    required this.onToggleVoice,
    required this.isBusy,
  });

  final ValueChanged<String> onSend;
  final bool isHandsFree;
  final bool isVoiceMuted;
  final VoidCallback onToggleHandsFree;
  final VoidCallback onToggleVoice;
  final bool isBusy;

  @override
  State<DialogueInputDock> createState() => _DialogueInputDockState();
}

class _DialogueInputDockState extends State<DialogueInputDock> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final String text = _controller.text.trim();
    if (text.isEmpty || widget.isBusy) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                _ToggleChip(
                  key: const Key('hands_free_toggle'),
                  icon: Icons.all_inclusive,
                  label: 'HANDS-FREE',
                  isOn: widget.isHandsFree,
                  onTap: widget.onToggleHandsFree,
                ),
                const SizedBox(width: 8),
                _ToggleChip(
                  key: const Key('oracle_voice_toggle'),
                  icon: widget.isVoiceMuted ? Icons.volume_off : Icons.record_voice_over,
                  label: widget.isVoiceMuted ? 'VOICE OFF' : 'VOICE ON',
                  isOn: !widget.isVoiceMuted,
                  onTap: widget.onToggleVoice,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    key: const Key('dialogue_text_input'),
                    controller: _controller,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 400,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _submit(),
                    style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Or type to the Oracle…',
                      hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
                      filled: true,
                      fillColor: AppColors.cosmicSurface,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: AppColors.glassBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: AppColors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: const BorderSide(color: AppColors.goldBright),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  key: const Key('dialogue_send_button'),
                  onPressed: widget.isBusy ? null : _submit,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.goldMetallic,
                    foregroundColor: AppColors.backgroundDeep,
                    disabledBackgroundColor: AppColors.goldDark,
                  ),
                  icon: const Icon(Icons.send_rounded),
                  tooltip: 'Send',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    super.key,
    required this.icon,
    required this.label,
    required this.isOn,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isOn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isOn ? AppColors.goldBright.withValues(alpha: 0.18) : Colors.transparent,
          border: Border.all(
            color: isOn ? AppColors.goldBright : AppColors.glassBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: isOn ? AppColors.goldBright : AppColors.textMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.cinzel(
                fontSize: 10,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
                color: isOn ? AppColors.goldBright : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
