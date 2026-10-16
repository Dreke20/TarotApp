import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/external_launch_service.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../auth/presentation/profile_dialog.dart';
import '../../domain/altar_theme.dart';
import '../../domain/tarot_deck_theme.dart';
import '../notifiers/reading_notifier.dart';
import '../notifiers/reading_state.dart';
import '../screens/readings_history_screen.dart';
import '../screens/tarot_codex_screen.dart';
import '../../../divination/presentation/screens/rune_casting_screen.dart';
import '../../../divination/presentation/screens/iching_screen.dart';
import '../../../dream/presentation/screens/dream_journal_screen.dart';
import '../screens/custom_spread_builder_screen.dart';
import '../../../astrology/presentation/screens/natal_chart_screen.dart';
import '../../../astrology/presentation/screens/lunar_almanac_screen.dart';
import '../../../collective/presentation/screens/collective_sanctuary_screen.dart';
import '../../../lens/presentation/screens/tarot_lens_screen.dart';
import '../screens/seekers_chronicle_screen.dart';
import '../../../altar/presentation/widgets/crystal_grid_sheet.dart';
import '../../../altar/presentation/widgets/smoke_purification_modal.dart';
import '../../../altar/presentation/widgets/sacred_breathing_modal.dart';
import '../../../altar/presentation/widgets/altar_cloth_selector_modal.dart';
import 'card_back_selector_modal.dart';
import '../../../meditation/presentation/screens/pathworking_sanctuary_screen.dart';
import '../../../notifications/presentation/widgets/cosmic_notification_modal.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import 'ambient_audio_button.dart';
import 'glass_container.dart';
import 'oracle_persona_selector_modal.dart';
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
            mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ASTRAL GUIDANCE',
                            style: GoogleFonts.cinzel(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 2.0,
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
                ],
              ),
          const SizedBox(width: 8),

          // Action Toolbar: Live Reader, Codex, Journal, Themes, Soundscape, Streaks, Sanctuaries
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Oracle Pro Action Button (Direct Paywall Access)
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      OracleProModal.show(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                      decoration: BoxDecoration(
                        color: isPro
                            ? AppColors.goldBright.withValues(alpha: 0.22)
                            : AppColors.goldBright.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: isPro ? 0.9 : 0.6),
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
                          const SizedBox(width: 4),
                          Text(
                            isPro ? 'ORACLE PRO' : 'GO PRO',
                            style: GoogleFonts.cinzel(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.goldBright,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Sacred Tarot Codex Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TarotCodexScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.style_outlined,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'CODEX',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Lunar Almanac & Sabbat Calendar Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LunarAlmanacScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.brightness_3,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'ALMANAC',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Sacred Journal Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ReadingsHistoryScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_stories,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'JOURNAL',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Oracle Persona Switcher Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      OraclePersonaSelectorModal.show(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.face_retouching_natural,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'ORACLE',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // The Seeker's Chronicle Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SeekersChronicleScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.menu_book,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'CHRONICLE',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Altar Purification & Smudge Rite Action Button
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    borderRadius: 12,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      SmokePurificationModal.show(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.flare,
                          size: 14,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'PURIFY',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldBright,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Talk to a Live Person (whispers26.com) Button
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      ExternalLaunchService.openLiveReader(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.45),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.record_voice_over_outlined,
                            color: AppColors.goldBright,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'LIVE READER',
                            style: GoogleFonts.cinzel(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
              // Theme Switcher Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.palette_outlined, color: AppColors.goldBright, size: 20),
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

              // Daily Habit Streak Badge
              const StreakBadge(),
              const SizedBox(width: 6),

              // Ambient Meditative Soundscape Button
              const AmbientAudioButton(),
              const SizedBox(width: 6),

              // Divination Sanctuary Switcher (Runes & I Ching)
              PopupMenuButton<String>(
                icon: const Icon(Icons.explore_outlined, color: AppColors.goldBright, size: 20),
                tooltip: 'Sacred Divination Systems',
                color: AppColors.backgroundMidnight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.glassBorder),
                ),
                onSelected: (val) {
                  switch (val) {
                    case 'runes':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RuneCastingScreen()),
                      );
                      break;
                    case 'iching':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const IChingScreen()),
                      );
                      break;
                    case 'dreams':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DreamJournalScreen()),
                      );
                      break;
                    case 'spreads':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CustomSpreadBuilderScreen()),
                      );
                      break;
                    case 'astrology':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const NatalChartScreen()),
                      );
                      break;
                    case 'collective':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CollectiveSanctuaryScreen()),
                      );
                      break;
                    case 'lens':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TarotLensScreen()),
                      );
                      break;
                    case 'chronicle':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SeekersChronicleScreen()),
                      );
                      break;
                    case 'persona':
                      OraclePersonaSelectorModal.show(context);
                      break;
                    case 'smudge':
                      SmokePurificationModal.show(context);
                      break;
                    case 'crystals':
                      CrystalGridSheet.show(context);
                      break;
                    case 'breathe':
                      SacredBreathingModal.show(context);
                      break;
                    case 'pathworking':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PathworkingSanctuaryScreen(
                            onIntentionAnchored: (intention) {
                              notifier.setQuestion(intention);
                            },
                          ),
                        ),
                      );
                      break;
                    case 'notifications':
                      CosmicNotificationModal.show(context);
                      break;
                    case 'live_reader':
                      ExternalLaunchService.openLiveReader(context);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'SACRED SANCTUARIES',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'runes',
                    child: Row(
                      children: [
                        const Text('ᚦ', style: TextStyle(fontSize: 16, color: AppColors.goldBright)),
                        const SizedBox(width: 8),
                        Text('Elder Futhark Runes', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'iching',
                    child: Row(
                      children: [
                        const Text('☯', style: TextStyle(fontSize: 16, color: AppColors.goldBright)),
                        const SizedBox(width: 8),
                        Text('I Ching Book of Changes', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'dreams',
                    child: Row(
                      children: [
                        const Text('🌙', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Astral Dream Journal', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'spreads',
                    child: Row(
                      children: [
                        const Text('📜', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text("Seeker's Grimoire (Spreads)", style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'astrology',
                    child: Row(
                      children: [
                        const Text('🪐', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Natal Ephemeris & Chart', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'collective',
                    child: Row(
                      children: [
                        const Text('✨', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Collective Consciousness', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'lens',
                    child: Row(
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Real-World Tarot Lens', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'chronicle',
                    child: Row(
                      children: [
                        const Text('📜', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text("The Seeker's Chronicle", style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'persona',
                    child: Row(
                      children: [
                        const Text('👁️', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Archetypal Oracle Personas', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'smudge',
                    child: Row(
                      children: [
                        const Text('🪵', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Altar Smudge & Purification', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'crystals',
                    child: Row(
                      children: [
                        const Text('🔮', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Sacred Crystal Grid', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'breathe',
                    child: Row(
                      children: [
                        const Text('🫁', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('4-7-8 Breath Centering', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'pathworking',
                    child: Row(
                      children: [
                        const Text('🧘', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Archetypal Pathworkings', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'notifications',
                    child: Row(
                      children: [
                        const Text('🔔', style: TextStyle(fontSize: 15)),
                        const SizedBox(width: 8),
                        Text('Cosmic Horary Reminders', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'live_reader',
                    child: Row(
                      children: [
                        const Icon(Icons.record_voice_over_outlined, color: AppColors.goldBright, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Talk to a Live Person',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.open_in_new, size: 12, color: AppColors.goldBright),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
  }
}
