import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/astral_circle_session.dart';
import '../notifiers/astral_circle_notifier.dart';
import 'astral_circle_hub_modal.dart';

/// Altar top banner displaying active multiplayer circle connection and turn status.
class AstralCircleBanner extends ConsumerWidget {
  const AstralCircleBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circleAsync = ref.watch(astralCircleNotifierProvider);
    final session = circleAsync.value;

    if (session == null) return const SizedBox.shrink();

    final notifier = ref.read(astralCircleNotifierProvider.notifier);
    final myRole = notifier.myRole;
    final isMyTurn = session.activeTurn == myRole;
    final isWaiting = session.status == AstralCircleStatus.waiting;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        AstralCircleHubModal.show(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cosmicSurface.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isMyTurn ? AppColors.goldBright : AppColors.glassBorder,
            width: isMyTurn ? 1.4 : 1.0,
          ),
          boxShadow: isMyTurn
              ? [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.25),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isMyTurn ? AppColors.goldBright : AppColors.cosmicSurface,
              ),
              child: Icon(
                Icons.all_inclusive,
                size: 14,
                color: isMyTurn ? AppColors.backgroundDeep : AppColors.goldBright,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'ASTRAL CIRCLE',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.goldBright.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          session.roomCode,
                          style: GoogleFonts.cinzel(
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isWaiting
                        ? 'Waiting for partner to enter...'
                        : (isMyTurn
                            ? '✨ Your sacred turn: Choose a card from deck'
                            : 'Waiting for partner to draw...'),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      fontWeight: isMyTurn ? FontWeight.bold : FontWeight.w500,
                      color: isMyTurn ? const Color(0xFF8BFFB8) : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.tune, size: 16, color: AppColors.goldBright),
              tooltip: 'Circle Settings',
              onPressed: () {
                HapticFeedback.lightImpact();
                AstralCircleHubModal.show(context);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
