import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../tarot/presentation/widgets/glass_container.dart';
import 'auth_notifier.dart';

class ProfileDialog extends ConsumerStatefulWidget {
  const ProfileDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => const ProfileDialog(),
    );
  }

  @override
  ConsumerState<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends ConsumerState<ProfileDialog> {
  static const List<String> _zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  late String _selectedSun;
  late String _selectedMoon;
  late String _selectedRising;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(authNotifierProvider).profile;
    _selectedSun = profile?.zodiacSign ?? 'Scorpio';
    _selectedMoon = profile?.moonSign ?? 'Pisces';
    _selectedRising = profile?.risingSign ?? 'Leo';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final profile = authState.profile;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: GlassContainer(
        borderRadius: 24,
        blur: 28,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.94),
        borderColor: AppColors.goldBright.withValues(alpha: 0.6),
        borderWidth: 1.5,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.stars, color: AppColors.goldBright, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'SEEKER PROFILE',
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(color: AppColors.glassBorder, height: 20),

              // Account summary
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.cosmicSurface,
                    child: Text(
                      (profile?.displayName ?? 'S').substring(0, 1).toUpperCase(),
                      style: GoogleFonts.cinzel(
                        color: AppColors.goldBright,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.displayName ?? 'Cosmic Seeker',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          profile?.email ?? 'Guest Session',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: profile?.isPro == true
                          ? AppColors.goldBright.withValues(alpha: 0.2)
                          : AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: profile?.isPro == true
                            ? AppColors.goldBright
                            : AppColors.glassBorder,
                      ),
                    ),
                    child: Text(
                      profile?.isPro == true ? 'ORACLE PRO' : 'FREE SEEKER',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: profile?.isPro == true
                            ? AppColors.goldBright
                            : AppColors.etherealLavender,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Astrological Alignment Title
              Text(
                'ASTROLOGICAL PLACEMENTS',
                style: GoogleFonts.cinzel(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.goldBright,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Used by Vertex AI to harmonize your personal tarot readings.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 14),

              // Sun Sign Selector
              _buildZodiacSelector(
                label: '☀️ Sun Sign (Core Essence)',
                selected: _selectedSun,
                onChanged: (val) => setState(() => _selectedSun = val),
              ),
              const SizedBox(height: 12),

              // Moon Sign Selector
              _buildZodiacSelector(
                label: '🌙 Moon Sign (Emotional Depth)',
                selected: _selectedMoon,
                onChanged: (val) => setState(() => _selectedMoon = val),
              ),
              const SizedBox(height: 12),

              // Rising Sign Selector
              _buildZodiacSelector(
                label: '🌅 Rising Sign (Cosmic Mask)',
                selected: _selectedRising,
                onChanged: (val) => setState(() => _selectedRising = val),
              ),
              const SizedBox(height: 22),

              const SizedBox(height: 18),

              // Daily Morning Guidance Notification section
              Text(
                'DAILY MORNING ALERTS',
                style: GoogleFonts.cinzel(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.goldBright,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.glassFillStrong,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.notifications_active,
                            color: AppColors.goldBright, size: 18),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Morning Reminder',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Daily at 8:00 AM',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                '✨ Test alert dispatched: "The Veil is Thinning Today"'),
                            backgroundColor: AppColors.cosmicSurface,
                          ),
                        );
                      },
                      child: Text(
                        'TEST ALERT',
                        style: GoogleFonts.cinzel(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Save Placements Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    foregroundColor: AppColors.backgroundDeep,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(authNotifierProvider.notifier).updateZodiacSigns(
                          sunSign: _selectedSun,
                          moonSign: _selectedMoon,
                          risingSign: _selectedRising,
                        );
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Astrological alignment saved to the cosmos!'),
                          backgroundColor: AppColors.cosmicSurface,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'ALIGN PLACEMENTS',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Account & Data Privacy (Google Play Account Deletion Policy)
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFF87171),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  icon: const Icon(Icons.delete_forever, size: 16),
                  label: Text(
                    'DELETE ACCOUNT & DATA',
                    style: GoogleFonts.cinzel(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: const Color(0xFFF87171),
                    ),
                  ),
                  onPressed: () => _confirmAccountDeletion(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmAccountDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF160E26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFF87171), width: 1.2),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFF87171), size: 22),
              const SizedBox(width: 8),
              Text(
                'PURGE ACCOUNT & DATA',
                style: GoogleFonts.cinzel(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF87171),
                ),
              ),
            ],
          ),
          content: Text(
            'This action is irreversible. All of your personal tarot readings, journal reflections, astrological birth placements, and cached preferences will be permanently erased.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: AppColors.textPrimary,
              height: 1.45,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'CANCEL',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
                try {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  await ref.read(authNotifierProvider.notifier).signOut();
                } catch (_) {}
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All personal data and account records have been purged.'),
                      backgroundColor: Color(0xFF450A0A),
                    ),
                  );
                }
              },
              child: Text(
                'DELETE EVERYTHING',
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildZodiacSelector({
    required String label,
    required String selected,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.glassFillStrong,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selected,
              isExpanded: true,
              dropdownColor: AppColors.backgroundMidnight,
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.goldBright),
              items: _zodiacSigns.map((sign) {
                return DropdownMenuItem<String>(
                  value: sign,
                  child: Text(
                    sign,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
