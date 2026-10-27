import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../tarot/presentation/widgets/tarot_card_widget.dart';
import '../../domain/ar_altar_card.dart';
import '../notifiers/ar_altar_notifier.dart';
import '../notifiers/ar_altar_state.dart';
import 'ar_mandala_painter.dart';

/// Slot centres as fractions of the plane size, relative to its centre.
List<Offset> arSlotOffsets(ArSpread spread) => switch (spread) {
      ArSpread.single => const <Offset>[Offset.zero],
      ArSpread.threeCard => const <Offset>[Offset(-0.3, 0), Offset.zero, Offset(0.3, 0)],
      ArSpread.cross => const <Offset>[
          Offset.zero,
          Offset(0, -0.34),
          Offset(0, 0.34),
          Offset(-0.32, 0),
          Offset(0.32, 0),
        ],
    };

/// The mandala and cards projected onto a perspective plane that counter-moves
/// with device rotation, so it appears to rest on the floor or table.
class ArProjectedAltar extends ConsumerStatefulWidget {
  const ArProjectedAltar({super.key});

  @override
  ConsumerState<ArProjectedAltar> createState() => _ArProjectedAltarState();
}

class _ArProjectedAltarState extends ConsumerState<ArProjectedAltar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: const Duration(seconds: 60))..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ArPose pose = ref.watch(arPoseProvider);
    final ArAltarState altar = ref.watch(arAltarProvider);
    final ArAltarNotifier notifier = ref.read(arAltarProvider.notifier);

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      final double plane = min(box.maxWidth * 0.98, 560);
      // Rotating the phone left/right/up/down moves the world the opposite way.
      final double dx = pose.yaw * box.maxWidth * 0.95;
      final double dy = pose.pitch * box.maxHeight * 0.85;
      final double tilt = (0.92 + pose.pitch * 0.35).clamp(0.55, 1.2);

      final Matrix4 m = Matrix4.identity()
        ..setEntry(3, 2, 0.0011)
        ..translateByDouble(dx, dy + box.maxHeight * 0.08, 0, 1)
        ..rotateX(tilt);

      final List<Offset> slots = arSlotOffsets(altar.spread);
      final double cardW = plane * 0.17;
      final double cardH = cardW * 1.62;

      return Center(
        child: Transform(
          alignment: Alignment.center,
          transform: m,
          child: SizedBox(
            width: plane,
            height: plane,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned.fill(
                  child: GestureDetector(
                    key: const Key('ar_mandala_surface'),
                    behavior: HitTestBehavior.opaque,
                    onTap: altar.cards.isEmpty ? notifier.dealSpread : notifier.clearSelection,
                    child: AnimatedBuilder(
                      animation: _spin,
                      builder: (BuildContext context, Widget? _) => CustomPaint(
                        painter: ArMandalaPainter(
                          rotation: _spin.value,
                          glow: altar.isDealing ? 1.0 : (altar.isMandalaAnchored ? 0.6 : 0.25),
                        ),
                      ),
                    ),
                  ),
                ),
                if (altar.cards.isEmpty && !altar.isDealing)
                  Center(
                    child: Text(
                      'TAP TO DEAL',
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: AppColors.goldBright,
                        shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 12)],
                      ),
                    )
                        .animate(onPlay: (AnimationController c) => c.repeat(reverse: true))
                        .fade(begin: 0.45, end: 1.0, duration: 1400.ms),
                  ),
                for (final ArAltarCard c in altar.cards)
                  Positioned(
                    left: plane / 2 + slots[c.slotIndex].dx * plane - cardW / 2,
                    top: plane / 2 + slots[c.slotIndex].dy * plane - cardH / 2,
                    child: _ArCardSlot(
                      key: ValueKey<String>(c.id),
                      altarCard: c,
                      width: cardW,
                      height: cardH,
                      isSelected: c.id == altar.selectedCardId,
                      onTap: () => notifier.tapCard(c.id),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ArCardSlot extends StatelessWidget {
  const _ArCardSlot({
    super.key,
    required this.altarCard,
    required this.width,
    required this.height,
    required this.isSelected,
    required this.onTap,
  });

  final ArAltarCard altarCard;
  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (isSelected ? AppColors.goldBright : Colors.black).withValues(alpha: isSelected ? 0.7 : 0.55),
            blurRadius: isSelected ? 22 : 14,
            spreadRadius: isSelected ? 2 : 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TarotCardWidget(
        key: Key('ar_card_${altarCard.slotIndex}'),
        card: altarCard.card,
        isFaceUp: altarCard.isRevealed,
        isSelected: isSelected,
        width: width,
        height: height,
        index: altarCard.slotIndex,
        onTap: onTap,
      ),
    )
        .animate()
        .fadeIn(duration: 320.ms)
        .moveY(begin: -height * 0.9, end: 0, duration: 520.ms, curve: Curves.easeOutBack)
        .scale(begin: const Offset(1.25, 1.25), end: const Offset(1, 1), duration: 520.ms);
  }
}
