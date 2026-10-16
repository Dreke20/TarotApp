import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/lunar_calculator.dart';
import '../../data/sanctuary_notification_service.dart';
import '../notifiers/notification_settings_notifier.dart';

/// Interactive modal allowing seekers to configure daily cosmic horary notifications,
/// lunar transit alerts, and Sabbat reminders.
class CosmicNotificationModal extends ConsumerWidget {
  const CosmicNotificationModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CosmicNotificationModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);
    final notifier = ref.read(notificationSettingsProvider.notifier);
    final lunar = LunarCalculator.getTodayLunarInfo();

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A14),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.goldMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_active, color: AppColors.goldBright, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'COSMIC HORARY REMINDERS',
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Schedule delicate, sacred notifications aligned with dawn and the changing currents of the moon.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Body
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              physics: const BouncingScrollPhysics(),
              children: [
                // Live Alert Preview Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF1E1632),
                        const Color(0xFF110C1E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.goldBright.withValues(alpha: 0.4),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'SAMPLE CELESTIAL ALERT',
                            style: GoogleFonts.cinzel(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            settings.formattedTime,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '✦ Today\'s Astral Guidance ✦',
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        settings.lunarTransits
                            ? 'The ${lunar.phase.title} illuminates ${lunar.moonZodiac} (${lunar.illuminationPercent.round()}% illuminated). Step into the sanctuary to draw your daily card.'
                            : 'Your daily Tarot card awaits on the consecrated altar.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Daily Guidance Toggle
                _buildToggleTile(
                  icon: Icons.brightness_5,
                  title: 'Daily Guidance Reminders',
                  subtitle: 'Receive a morning horary alert to draw your Card of the Day',
                  value: settings.dailyEnabled,
                  onChanged: (val) {
                    HapticFeedback.lightImpact();
                    notifier.toggleDaily(val);
                  },
                ),
                const SizedBox(height: 12),

                // Timing Presets
                if (settings.dailyEnabled) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8),
                    child: Text(
                      'CONSECRATION TIME',
                      style: GoogleFonts.cinzel(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.etherealLavender,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildTimePreset(context, label: 'Dawn', time: '06:00', hour: 6, minute: 0, currentH: settings.hour, currentM: settings.minute, notifier: notifier),
                      const SizedBox(width: 8),
                      _buildTimePreset(context, label: 'Morning', time: '08:00', hour: 8, minute: 0, currentH: settings.hour, currentM: settings.minute, notifier: notifier),
                      const SizedBox(width: 8),
                      _buildTimePreset(context, label: 'Twilight', time: '20:00', hour: 20, minute: 0, currentH: settings.hour, currentM: settings.minute, notifier: notifier),
                      const SizedBox(width: 8),
                      _buildTimePreset(context, label: 'Midnight', time: '00:00', hour: 0, minute: 0, currentH: settings.hour, currentM: settings.minute, notifier: notifier),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // Lunar Transits Toggle
                _buildToggleTile(
                  icon: Icons.nightlight_round,
                  title: 'Lunar Transit Alerts',
                  subtitle: 'Notify on New Moon intentions, Full Moon peaks, and zodiac shifts',
                  value: settings.lunarTransits,
                  onChanged: (val) {
                    HapticFeedback.lightImpact();
                    notifier.toggleLunar(val);
                  },
                ),
                const SizedBox(height: 12),

                // Sabbat Alerts Toggle
                _buildToggleTile(
                  icon: Icons.cyclone,
                  title: 'Wheel of the Year Sabbats',
                  subtitle: 'Gentle alerts on the eve of Samhain, Yule, Beltane, and solar quarter holidays',
                  value: settings.sabbatAlerts,
                  onChanged: (val) {
                    HapticFeedback.lightImpact();
                    notifier.toggleSabbat(val);
                  },
                ),
                const SizedBox(height: 24),

                // Instant Test Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.goldBright,
                    side: BorderSide(
                      color: AppColors.goldBright.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    HapticFeedback.heavyImpact();
                    await SanctuaryNotificationService.instance.sendSampleCelestialAlert();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '✦ Celestial alert dispatched to device notification tray',
                            style: GoogleFonts.cinzel(color: AppColors.goldBright),
                          ),
                          backgroundColor: const Color(0xFF130E22),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'DISPATCH SAMPLE CELESTIAL ALERT',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF141022),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.goldMuted.withValues(alpha: 0.25),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.goldBright, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColors.goldBright,
            activeTrackColor: AppColors.goldMuted.withValues(alpha: 0.4),
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: Colors.black.withValues(alpha: 0.4),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTimePreset(
    BuildContext context, {
    required String label,
    required String time,
    required int hour,
    required int minute,
    required int currentH,
    required int currentM,
    required NotificationSettingsNotifier notifier,
  }) {
    final isSelected = currentH == hour && currentM == minute;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          notifier.setTime(hour, minute);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.goldBright.withValues(alpha: 0.2) : const Color(0xFF141022),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.goldBright : AppColors.goldMuted.withValues(alpha: 0.3),
              width: isSelected ? 1.5 : 0.8,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.goldBright : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
