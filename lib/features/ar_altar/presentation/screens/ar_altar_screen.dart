import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../oracle_dialogue/presentation/screens/conversational_oracle_screen.dart';
import '../../domain/ar_altar_card.dart';
import '../notifiers/ar_altar_notifier.dart';
import '../notifiers/ar_altar_state.dart';
import '../widgets/ar_camera_backdrop.dart';
import '../widgets/ar_card_insight_panel.dart';
import '../widgets/ar_projected_altar.dart';

/// Tier 2 • Augmented Reality Altar.
///
/// Projects a sacred mandala over the live camera feed, anchored by device
/// orientation, and lets the seeker deal and flip a spread in their own room.
class ArAltarScreen extends ConsumerStatefulWidget {
  const ArAltarScreen({super.key});

  @override
  ConsumerState<ArAltarScreen> createState() => _ArAltarScreenState();
}

class _ArAltarScreenState extends ConsumerState<ArAltarScreen> with WidgetsBindingObserver {
  final GlobalKey _snapshotKey = GlobalKey();
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(arAltarProvider.notifier).startCamera();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    final ArAltarNotifier notifier = ref.read(arAltarProvider.notifier);
    if (lifecycle == AppLifecycleState.inactive || lifecycle == AppLifecycleState.paused) {
      notifier.pauseCamera();
    } else if (lifecycle == AppLifecycleState.resumed) {
      notifier.resumeCamera();
    }
  }

  Future<void> _shareSnapshot() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final RenderRepaintBoundary? boundary =
          _snapshotKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final ui.Image image = await boundary.toImage(pixelRatio: 2.5);
      final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytes == null) return;
      await SharePlus.instance.share(ShareParams(
        files: <XFile>[
          XFile.fromData(bytes.buffer.asUint8List(), mimeType: 'image/png', name: 'oraculum_ar_altar.png'),
        ],
        text: 'My spread on the Oraculum AR Altar ✨',
      ));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not capture the altar. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  void _consultOracle(ArAltarState altar) {
    final String prompt = ref.read(arAltarProvider.notifier).consultationPrompt();
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ConversationalOracleScreen(openingPrompt: prompt),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ArAltarState altar = ref.watch(arAltarProvider);
    final ArAltarNotifier notifier = ref.read(arAltarProvider.notifier);
    final controller = altar.isCameraReady ? ref.read(arCameraServiceProvider).controller : null;
    final ArAltarCard? selected = altar.selectedCard;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          RepaintBoundary(
            key: _snapshotKey,
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: ArCameraBackdrop(controller: controller)),
                // Gentle vignette so gold reads well over bright rooms.
                const Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[Colors.transparent, Color(0xAA000000)],
                          radius: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(child: ArProjectedAltar()),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                _ArTopBar(
                  isSharing: _isSharing,
                  onBack: () => Navigator.of(context).maybePop(),
                  onRecenter: () {
                    notifier.anchorMandala();
                  },
                  onSnapshot: altar.cards.isEmpty ? null : _shareSnapshot,
                ),
                if (altar.cameraError != null) _ArNotice(text: altar.cameraError!),
                if (!altar.isMandalaAnchored && altar.cameraError == null)
                  const _ArNotice(
                    text: 'Point your camera at a table or the floor, then tap the mandala to deal.',
                  ),
                const Spacer(),
                if (selected != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ArCardInsightPanel(
                      altarCard: selected,
                      onClose: notifier.clearSelection,
                    ),
                  ),
                const SizedBox(height: 10),
                _ArControlDock(
                  altar: altar,
                  onSpread: notifier.setSpread,
                  onDeal: notifier.dealSpread,
                  onRevealAll: notifier.revealAll,
                  onClear: notifier.clearAltar,
                  onConsult: () => _consultOracle(altar),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArTopBar extends StatelessWidget {
  const _ArTopBar({
    required this.isSharing,
    required this.onBack,
    required this.onRecenter,
    required this.onSnapshot,
  });

  final bool isSharing;
  final VoidCallback onBack;
  final VoidCallback onRecenter;
  final VoidCallback? onSnapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        children: <Widget>[
          _RoundIcon(key: const Key('ar_back_button'), icon: Icons.arrow_back_ios_new, tooltip: 'Back', onTap: onBack),
          Expanded(
            child: Text(
              'AR ALTAR',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: AppColors.goldBright,
                shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 10)],
              ),
            ),
          ),
          _RoundIcon(
            key: const Key('ar_recenter_button'),
            icon: Icons.center_focus_strong,
            tooltip: 'Re-anchor altar here',
            onTap: onRecenter,
          ),
          const SizedBox(width: 6),
          _RoundIcon(
            key: const Key('ar_snapshot_button'),
            icon: isSharing ? Icons.hourglass_top : Icons.camera_alt_outlined,
            tooltip: 'Share snapshot',
            onTap: onSnapshot,
          ),
        ],
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({super.key, required this.icon, required this.tooltip, required this.onTap});

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: 0.45),
        side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.4)),
      ),
      icon: Icon(icon, size: 19, color: onTap == null ? AppColors.textMuted : AppColors.goldBright),
    );
  }
}

class _ArNotice extends StatelessWidget {
  const _ArNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(fontSize: 12.5, color: AppColors.textSecondary),
      ),
    );
  }
}

class _ArControlDock extends StatelessWidget {
  const _ArControlDock({
    required this.altar,
    required this.onSpread,
    required this.onDeal,
    required this.onRevealAll,
    required this.onClear,
    required this.onConsult,
  });

  final ArAltarState altar;
  final ValueChanged<ArSpread> onSpread;
  final VoidCallback onDeal;
  final VoidCallback onRevealAll;
  final VoidCallback onClear;
  final VoidCallback onConsult;

  @override
  Widget build(BuildContext context) {
    final bool hasCards = altar.cards.isNotEmpty;
    final bool anyRevealed = altar.cards.any((ArAltarCard c) => c.isRevealed);
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundMidnight.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ArSpread.values
                .map((ArSpread s) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        key: Key('ar_spread_${s.name}'),
                        label: Text(s.label),
                        selected: altar.spread == s,
                        onSelected: altar.isDealing ? null : (_) => onSpread(s),
                        labelStyle: GoogleFonts.cinzel(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: altar.spread == s ? AppColors.backgroundDeep : AppColors.goldBright,
                        ),
                        selectedColor: AppColors.goldBright,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.5)),
                        showCheckmark: false,
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _DockButton(
                  key: const Key('ar_deal_button'),
                  label: hasCards ? 'RE-DEAL' : 'DEAL',
                  icon: Icons.style,
                  onTap: altar.isDealing ? null : onDeal,
                  isPrimary: !hasCards,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DockButton(
                  key: const Key('ar_reveal_all_button'),
                  label: 'REVEAL',
                  icon: Icons.flip,
                  onTap: hasCards && !altar.allRevealed && !altar.isDealing ? onRevealAll : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DockButton(
                  key: const Key('ar_consult_button'),
                  label: 'ASK ORACLE',
                  icon: Icons.record_voice_over,
                  onTap: anyRevealed && !altar.isDealing ? onConsult : null,
                  isPrimary: altar.allRevealed,
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                key: const Key('ar_clear_button'),
                onPressed: hasCards && !altar.isDealing ? onClear : null,
                tooltip: 'Clear altar',
                icon: Icon(Icons.delete_sweep_outlined,
                    color: hasCards ? AppColors.textSecondary : AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DockButton extends StatelessWidget {
  const _DockButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isPrimary && enabled ? AppColors.goldButtonGradient : null,
            border: Border.all(
              color: enabled ? AppColors.goldBright.withValues(alpha: 0.6) : AppColors.glassBorder,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon,
                  size: 18,
                  color: !enabled
                      ? AppColors.textMuted
                      : (isPrimary ? AppColors.backgroundDeep : AppColors.goldBright)),
              const SizedBox(height: 3),
              Text(
                label,
                style: GoogleFonts.cinzel(
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: !enabled
                      ? AppColors.textMuted
                      : (isPrimary ? AppColors.backgroundDeep : AppColors.goldBright),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
