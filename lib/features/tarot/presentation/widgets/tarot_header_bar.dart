import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_modal.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../auth/presentation/profile_dialog.dart';
import '../../domain/altar_theme.dart';
import '../../domain/tarot_deck_theme.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../../../altar/presentation/widgets/altar_cloth_selector_modal.dart';
import 'card_back_selector_modal.dart';
import 'deck_switcher_modal.dart';
import '../../../wallpaper/presentation/screens/wallpaper_studio_screen.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import 'ambient_audio_button.dart';
import 'streak_badge.dart';
import 'mystic_widget_hub_modal.dart';
import '../../../sanctuary/presentation/screens/mystic_sanctum_hub_modal.dart';

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
    final authState = ref.watch(authNotifierProvider);
    final authProfile = authState.profile;
    final isGuest = authState.isGuest;
    final notifier = ref.read(readingNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'ASTRAL GUIDANCE',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cinzel(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.8,
                              ),
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
                      if (isGuest)
                        GestureDetector(
                          onTap: () => AuthModal.show(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  'GUEST • SIGN IN / JOIN',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cinzel(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                    letterSpacing: 0.9,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(Icons.arrow_forward_ios, size: 8, color: AppColors.goldBright),
                            ],
                          ),
                        )
                      else
                        Text(
                          authProfile?.zodiacSign != null
                              ? 'ALIGNED WITH ${authProfile!.zodiacSign!.toUpperCase()}'
                              : 'SACRED ORACULUM',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cinzel(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldMuted,
                            letterSpacing: 1.2,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),

          // Header Action Controls: Pro Badge, Soundscape, Streak, Theme, Grimoire Hub
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Oracle Pro Action Button (Direct Paywall Access)
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  OracleProModal.show(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                    color: isPro
                        ? AppColors.goldBright.withValues(alpha: 0.22)
                        : AppColors.goldBright.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.goldBright.withValues(alpha: isPro ? 0.9 : 0.65),
                      width: 1.1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPro ? Icons.workspace_premium : Icons.stars,
                        size: 13,
                        color: AppColors.goldBright,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        isPro ? 'PRO' : 'GO PRO',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.goldBright,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 2),

              // Ambient Meditative Soundscape Button
              const AmbientAudioButton(),
              const SizedBox(width: 1),

              // Daily Habit Streak Badge
              const StreakBadge(),
              const SizedBox(width: 1),

              // Theme Switcher Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.palette_outlined, color: AppColors.goldBright, size: 20),
                tooltip: 'Altar & Card Art Themes',
                color: AppColors.backgroundMidnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                onSelected: (value) {
                  if (value == 'card_backs') {
                    CardBackSelectorModal.show(context);
                  } else if (value == 'altar_cloths') {
                    AltarClothSelectorModal.show(context);
                  } else if (value == 'home_widget') {
                    MysticWidgetHubModal.show(context);
                  } else if (value == 'deck_styles') {
                    DeckSwitcherModal.show(context);
                  } else if (value == 'wallpaper_studio') {
                    WallpaperStudioScreen.show(context);
                  } else if (value.startsWith('deck:')) {
                    final themeId = value.replaceFirst('deck:', '');
                    final theme = TarotDeckTheme.values.firstWhere((t) => t.id == themeId);
                    if (theme.isPremium && !isPro) {
                      HapticFeedback.lightImpact();
                      OracleProModal.show(context);
                      return;
                    }
                    notifier.setDeckTheme(theme);
                  } else if (value.startsWith('altar:')) {
                    final themeId = value.replaceFirst('altar:', '');
                    final theme = AltarTheme.values.firstWhere((t) => t.id == themeId);
                    notifier.setAltarTheme(theme);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'deck_styles',
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 16, color: AppColors.goldBright),
                        const SizedBox(width: 8),
                        Text(
                          'Deck Sanctuary & Styles',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'wallpaper_studio',
                    child: Row(
                      children: [
                        const Icon(Icons.wallpaper, size: 16, color: AppColors.goldBright),
                        const SizedBox(width: 8),
                        Text(
                          'Sacred Wallpaper Studio',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'card_backs',
                    child: Row(
                      children: [
                        const Icon(Icons.style, size: 16, color: AppColors.goldBright),
                        const SizedBox(width: 8),
                        Text(
                          'Card Back Geometry',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'altar_cloths',
                    child: Row(
                      children: [
                        const Icon(Icons.table_restaurant, size: 16, color: AppColors.goldBright),
                        const SizedBox(width: 8),
                        Text(
                          'Consecrated Altar Cloths',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'home_widget',
                    child: Row(
                      children: [
                        const Icon(Icons.widgets, size: 16, color: AppColors.goldBright),
                        const SizedBox(width: 8),
                        Text(
                          'Daily Mystic Widget',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                t.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: state.deckTheme == t
                                      ? AppColors.goldBright
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (t.isPremium) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: AppColors.goldBright.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.goldBright, width: 0.8),
                                ),
                                child: Text(
                                  'PRO',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                  ),
                                ),
                              ),
                            ],
                          ],
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
              const SizedBox(width: 2),

              // Unified Mystic Sanctum Hub & Omni-Portal Trigger
              IconButton(
                icon: const Icon(Icons.auto_stories, color: AppColors.goldBright, size: 20),
                tooltip: 'Sacred Grimoire & Mystic Sanctum',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  MysticSanctumHubModal.show(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
