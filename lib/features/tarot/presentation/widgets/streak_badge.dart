import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/streak_service.dart';

class StreakBadge extends ConsumerWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakProvider);

    return streakAsync.when(
      data: (streak) {
        if (streak <= 0) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.deepOrangeAccent.withValues(alpha: 0.6),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 4),
              Text(
                '$streak ${streak == 1 ? "DAY" : "DAYS"}',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
