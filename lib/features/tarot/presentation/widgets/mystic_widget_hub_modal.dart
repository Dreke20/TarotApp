import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/tarot_card.dart';
import '../../services/tarot_widget_service.dart';
import 'glass_container.dart';

/// Interactive modal allowing seekers to preview their Daily Mystic Home Screen Widget,
/// configure sync modes (Celestial Seed vs Reading Mirror), and trigger manual syncs.
class MysticWidgetHubModal extends ConsumerStatefulWidget {
  const MysticWidgetHubModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MysticWidgetHubModal(),
    );
  }

  @override
  ConsumerState<MysticWidgetHubModal> createState() => _MysticWidgetHubModalState();
}

class _MysticWidgetHubModalState extends ConsumerState<MysticWidgetHubModal> {
  WidgetSyncMode _currentMode = WidgetSyncMode.dailySeed;
  TarotWidgetData? _previewData;
  TarotCard? _activeCard;
  bool _isLoading = true;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadWidgetState();
  }

  Future<void> _loadWidgetState() async {
    final service = ref.read(tarotWidgetServiceProvider);
    final mode = await service.getSyncMode();
    final active = await service.resolveActiveCard();
    final data = service.generateDailyData(
      card: active.card,
      isReversed: active.isReversed,
    );

    if (mounted) {
      setState(() {
        _currentMode = mode;
        _activeCard = active.card;
        _previewData = data;
        _isLoading = false;
      });
    }
  }

  Future<void> _onModeChanged(WidgetSyncMode newMode) async {
    final service = ref.read(tarotWidgetServiceProvider);
    await service.setSyncMode(newMode);
    setState(() => _currentMode = newMode);
    HapticFeedback.selectionClick();
    await _loadWidgetState();
    await service.syncFromPreferences();
  }

  Future<void> _triggerManualSync() async {
    setState(() => _isSyncing = true);
    HapticFeedback.mediumImpact();
    final service = ref.read(tarotWidgetServiceProvider);
    final success = await service.syncFromPreferences();

    if (mounted) {
      setState(() => _isSyncing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? '✦ Home Screen Widget synchronised with celestial coordinates!'
                : '✦ Widget data cached. Pin the widget to your home screen to view.',
            style: GoogleFonts.plusJakartaSans(color: AppColors.goldBright),
          ),
          backgroundColor: AppColors.backgroundMidnight,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _requestPinWidget() async {
    HapticFeedback.lightImpact();
    final service = ref.read(tarotWidgetServiceProvider);
    if (!kIsWeb && Platform.isAndroid) {
      final requested = await service.requestPinWidget();
      if (!requested && mounted) {
        _showManualAddInstructions();
      }
    } else {
      _showManualAddInstructions();
    }
  }

  void _showManualAddInstructions() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundMidnight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.goldBright.withValues(alpha: 0.5)),
        ),
        title: Row(
          children: [
            const Icon(Icons.widgets, color: AppColors.goldBright, size: 20),
            const SizedBox(width: 8),
            Text(
              'HOW TO ADD WIDGET',
              style: GoogleFonts.cinzel(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepRow('1', 'Return to your phone\'s Home Screen.'),
            const SizedBox(height: 10),
            _buildStepRow('2', 'Touch and hold an empty space until the menu appears.'),
            const SizedBox(height: 10),
            _buildStepRow('3', 'Tap Widgets and scroll to find Oraculum.'),
            const SizedBox(height: 10),
            _buildStepRow('4', 'Touch and drag the Daily Mystic widget onto your screen.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'UNDERSTOOD',
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.bold,
                color: AppColors.goldBright,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(String number, String instruction) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.goldBright,
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.cinzel(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundMidnight,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            instruction,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.90,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 24,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.96),
        borderColor: AppColors.goldBright.withValues(alpha: 0.4),
        borderWidth: 1.5,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Modal Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.widgets, color: AppColors.goldBright, size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'DAILY MYSTIC WIDGET',
                          style: GoogleFonts.cinzel(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'LIVE CARD OF THE DAY & LUNAR EPHEMERIS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.etherealLavender,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(color: AppColors.glassBorder, height: 20),

            // Scrollable Content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.goldBright),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Widget Live Simulator
                          _buildWidgetSimulator(),
                          const SizedBox(height: 20),

                          // Sync Mode Configuration Section
                          Text(
                            'WIDGET SYNCHRONIZATION MODE',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildModeTile(WidgetSyncMode.dailySeed),
                          const SizedBox(height: 8),
                          _buildModeTile(WidgetSyncMode.activeReading),
                          const SizedBox(height: 20),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _isSyncing ? null : _triggerManualSync,
                                  icon: _isSyncing
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                                AppColors.backgroundMidnight),
                                          ),
                                        )
                                      : const Icon(Icons.sync, size: 16),
                                  label: Text(
                                    _isSyncing ? 'SYNCING...' : 'FORCE SYNC NOW',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.goldBright,
                                    foregroundColor: AppColors.backgroundMidnight,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _requestPinWidget,
                                  icon: const Icon(Icons.add_to_home_screen,
                                      size: 16, color: AppColors.goldBright),
                                  label: Text(
                                    'ADD TO HOME',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.goldBright,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.goldBright.withValues(alpha: 0.4)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Deep link guidance banner
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.glassFill,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.glassBorder),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.touch_app, size: 16, color: AppColors.etherealLavender),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Tapping the widget on your Home Screen instantly launches into the Daily Guidance altar table.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSimulator() {
    final data = _previewData;
    if (data == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LIVE WIDGET PREVIEW (4×2)',
              style: GoogleFonts.cinzel(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.goldBright.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
              ),
              child: Text(
                'ANDROID & IOS',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Simulated Phone Widget Box
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF140D22),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: AppColors.goldBright.withValues(alpha: 0.45),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.purpleDeep.withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header: Brand & Live Moon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '✦ ORACULUM',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1C44),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.4), width: 0.8),
                    ),
                    child: Text(
                      data.moonPhase,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEAD9AB),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Card Art & Typography
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Thumbnail
                  Container(
                    width: 48,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.goldBright, width: 1.2),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _activeCard != null
                        ? Image.asset(
                            'assets/cards/${_activeCard!.id}.webp',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppColors.cosmicSurface,
                              child: const Icon(Icons.auto_awesome,
                                  color: AppColors.goldBright, size: 20),
                            ),
                          )
                        : Container(
                            color: AppColors.cosmicSurface,
                            child: const Icon(Icons.style, color: AppColors.goldBright),
                          ),
                  ),
                  const SizedBox(width: 12),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.cardTitle,
                          style: GoogleFonts.cinzel(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          data.cardSubtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldBright,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.cardMeaning,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: const Color(0xFFB3A9C9),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Button: Consult Daily Oracle
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF7A5813),
                      const Color(0xFFB8861B),
                      const Color(0xFF7A5813),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.7)),
                ),
                child: Center(
                  child: Text(
                    '✦ CONSULT DAILY ORACLE ✦',
                    style: GoogleFonts.cinzel(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF3E5AB),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeTile(WidgetSyncMode mode) {
    final isSelected = _currentMode == mode;

    return GestureDetector(
      onTap: () => _onModeChanged(mode),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.goldBright.withValues(alpha: 0.15)
              : AppColors.glassFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.displayName,
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mode.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
