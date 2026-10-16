import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/lunar_calculator.dart';
import '../../../tarot/presentation/notifiers/reading_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../domain/sabbat_calendar.dart';

/// The Celestial Lunar Almanac & Astrological Sabbat Sanctuary
class LunarAlmanacScreen extends ConsumerStatefulWidget {
  const LunarAlmanacScreen({super.key});

  @override
  ConsumerState<LunarAlmanacScreen> createState() => _LunarAlmanacScreenState();
}

class _LunarAlmanacScreenState extends ConsumerState<LunarAlmanacScreen> {
  late DateTime _selectedMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);
    _selectedDay = now;
  }

  @override
  Widget build(BuildContext context) {
    final todayLunar = LunarCalculator.getTodayLunarInfo(_selectedDay);
    final now = DateTime.now();
    final nextOccurrence = SabbatCalendar.next(now);
    final nextSabbat = nextOccurrence.event;
    final daysUntilSabbat = nextOccurrence.daysFrom(now);

    return Scaffold(
      backgroundColor: AppColors.backgroundMidnight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'LUNAR ALMANAC & SABBATS',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Live Lunar Station Hero Banner
            GlassContainer(
              borderRadius: 24,
              padding: const EdgeInsets.all(20),
              fillColor: AppColors.backgroundDeep.withValues(alpha: 0.9),
              borderColor: AppColors.goldBright.withValues(alpha: 0.5),
              borderWidth: 1.4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE, MMMM d').format(_selectedDay).toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.goldMuted,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            todayLunar.phase.title.toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.brightness_2, size: 13, color: AppColors.etherealLavender),
                              const SizedBox(width: 5),
                              Text(
                                'Moon in ${todayLunar.moonZodiac}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.etherealLavender,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Moon Phase Visualizer Circle
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              AppColors.goldBright,
                              AppColors.cosmicSurface,
                            ],
                          ),
                          border: Border.all(color: AppColors.goldBright, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldBright.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            todayLunar.phase.symbol,
                            style: const TextStyle(fontSize: 34),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Illumination progress bar
                  Row(
                    children: [
                      Text(
                        'ILLUMINATION',
                        style: GoogleFonts.cinzel(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldMuted,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${todayLunar.illuminationPercent.toStringAsFixed(1)}%',
                        style: GoogleFonts.cinzel(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (todayLunar.illuminationPercent / 100).clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.goldBright),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Daily Guidance Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.glassFill,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Text(
                      todayLunar.transitGuidance,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Month Calendar Grid Navigator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LUNAR CALENDAR',
                  style: GoogleFonts.cinzel(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 1.5,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: AppColors.goldBright, size: 22),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
                        });
                      },
                    ),
                    Text(
                      DateFormat('MMM yyyy').format(_selectedMonth).toUpperCase(),
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: AppColors.goldBright, size: 22),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Calendar Grid Container
            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(14),
              fillColor: AppColors.glassFillStrong,
              borderColor: AppColors.glassBorder,
              child: _buildMonthCalendar(),
            ),
            const SizedBox(height: 28),

            // 3. Wheel of the Year: Upcoming Sabbat Spotlight
            Row(
              children: [
                const Icon(Icons.wb_sunny_outlined, size: 16, color: AppColors.goldBright),
                const SizedBox(width: 8),
                Text(
                  'WHEEL OF THE YEAR • SABBAT CYCLE',
                  style: GoogleFonts.cinzel(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GlassContainer(
              borderRadius: 20,
              padding: const EdgeInsets.all(18),
              fillColor: AppColors.backgroundDeep,
              borderColor: AppColors.goldBright.withValues(alpha: 0.6),
              borderWidth: 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.goldBright.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'NEXT SABBAT: $daysUntilSabbat DAYS AWAY',
                              style: GoogleFonts.cinzel(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            nextSabbat.name.toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            nextSabbat.dateDescription,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.all_inclusive, size: 38, color: AppColors.goldBright),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Text(
                    nextSabbat.seasonalTheme,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    nextSabbat.ritualFocus,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Consecrate Spread Button
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        ref.read(readingNotifierProvider.notifier).setSpreadType(nextSabbat.spreadType);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldBright,
                        foregroundColor: AppColors.backgroundDeep,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'CONSECRATE ${nextSabbat.recommendedSpreadTitle.toUpperCase()}',
                            style: GoogleFonts.cinzel(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildMonthCalendar() {
    final daysInMonth = DateUtils.getDaysInMonth(_selectedMonth.year, _selectedMonth.month);
    final firstDayOfWeek = DateTime(_selectedMonth.year, _selectedMonth.month, 1).weekday % 7;

    const weekdayHeaders = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      children: [
        // Weekday header letters
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdayHeaders.map((w) {
            return SizedBox(
              width: 36,
              child: Center(
                child: Text(
                  w,
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldMuted,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Grid of dates with lunar symbols
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.95,
          ),
          itemCount: daysInMonth + firstDayOfWeek,
          itemBuilder: (context, index) {
            if (index < firstDayOfWeek) {
              return const SizedBox.shrink();
            }

            final dayNumber = index - firstDayOfWeek + 1;
            final dayDate = DateTime(_selectedMonth.year, _selectedMonth.month, dayNumber);
            final dayLunar = LunarCalculator.getTodayLunarInfo(dayDate);
            final isSelected = dayDate.year == _selectedDay.year &&
                dayDate.month == _selectedDay.month &&
                dayDate.day == _selectedDay.day;

            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedDay = dayDate);
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? AppColors.goldBright.withValues(alpha: 0.22)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.goldBright : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$dayNumber',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      dayLunar.phase.symbol,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
