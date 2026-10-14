import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../auth/presentation/profile_dialog.dart';
import '../../domain/altar_theme.dart';
import '../../domain/tarot_deck_theme.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../screens/readings_history_screen.dart';
import '../screens/tarot_codex_screen.dart';
import 'ambient_audio_button.dart';
import 'glass_container.dart';
import 'streak_badge.dart';

/// Top sacred header bar displaying Seeker astrological badge, Pro indicator,
/// theme picker menu, streak counter, soundscape button, Codex, and Journal access.
class TarotHeaderBar extends ConsumerWidget {
  final ReadingState state;
  final bool isPro;

  const TarotHeaderBar({
    super.key,
    required this.state,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProfile = ref.watch(authNotifierProvider).profile;
    final notifier = ref.read(readingNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => ProfileDialog.show(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [AppColors.goldBright, AppColors.cosmicSurface],
                    ),
                    border: Border.all(color: AppColors.goldBright, width: 1.2),
                  ),
                  child: Center(
                    child: Text(
                      authProfile?.zodiacSign?.substring(0, 2).toUpperCase() ?? '★',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundDeep,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ORACULUM',
                        style: GoogleFonts.cinzel(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 2.2,
                        ),
                      ),
                      if (isPro) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.goldBright,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PRO',
                            style: GoogleFonts.cinzel(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: AppColors.backgroundDeep,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    authProfile?.zodiacSign != null
                        ? 'ALIGNED WITH ${authProfile!.zodiacSign!.toUpperCase()}'
                        : 'AI TAROT SANCTUARY',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.etherealLavender,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Action Toolbar: Themes, Pro, Journal
          Row(
            children: [
              // Theme Switcher Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.palette_outlined, color: AppColors.goldBright, size: 20),
                color: AppColors.backgroundMidnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                onSelected: (value) {
                  if (value.startsWith('deck:')) {
                    final themeId = value.replaceFirst('deck:', '');
                    final theme = TarotDeckTheme.values.firstWhere((t) => t.id == themeId);
                    notifier.setDeckTheme(theme);
                  } else if (value.startsWith('altar:')) {
                    final themeId = value.replaceFirst('altar:', '');
                    final theme = AltarTheme.values.firstWhere((t) => t.id == themeId);
                    notifier.setAltarTheme(theme);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'CARD DECKS',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                  ...TarotDeckTheme.values.map((t) => PopupMenuItem(
                        value: 'deck:${t.id}',
                        child: Text(
                          t.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: state.deckTheme == t
                                ? AppColors.goldBright
                                : AppColors.textPrimary,
                          ),
                        ),
                      )),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'ALTAR THEMES',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                      ),
                    ),
                  ),
                  ...AltarTheme.values.map((a) => PopupMenuItem(
                        value: 'altar:${a.id}',
                        child: Text(
                          a.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: state.altarTheme == a
                                ? AppColors.goldBright
                                : AppColors.textPrimary,
                          ),
                        ),
                      )),
                ],
              ),

              // Daily Habit Streak Badge
              const StreakBadge(),
              const SizedBox(width: 6),

              // Ambient Meditative Soundscape Button
              const AmbientAudioButton(),
              const SizedBox(width: 6),

              // Sacred Tarot Codex Action Button
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                borderRadius: 14,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TarotCodexScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.style_outlined,
                      size: 15,
                      color: AppColors.goldBright,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'CODEX',
                      style: GoogleFonts.cinzel(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Sacred Journal Action Button
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                borderRadius: 14,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ReadingsHistoryScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_stories,
                      size: 15,
                      color: AppColors.goldBright,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'JOURNAL',
                      style: GoogleFonts.cinzel(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
