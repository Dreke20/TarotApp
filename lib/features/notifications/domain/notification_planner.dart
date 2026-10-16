import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/lunar_calculator.dart';
import '../../astrology/domain/sabbat_calendar.dart';
import 'notification_settings.dart';

part 'notification_planner.freezed.dart';

/// Category of a planned notification (used for ID ranges and channels).
enum NotificationKind { daily, lunar, sabbat }

/// A single notification to be scheduled at an absolute local [when].
@freezed
abstract class PlannedNotification with _$PlannedNotification {
  const factory PlannedNotification({
    required int id,
    required NotificationKind kind,
    required String title,
    required String body,
    required DateTime when,
  }) = _PlannedNotification;
}

/// Pure planner that turns [NotificationSettings] into a concrete schedule.
///
/// Every notification is a one-shot at an absolute instant built from the
/// device's local wall clock. This keeps lunar text accurate per day and
/// avoids needing an IANA timezone name for repeating schedules.
class NotificationPlanner {
  const NotificationPlanner._();

  static const int dailyWindowDays = 7;
  static const int lunarWindowDays = 30;

  static const int dailyBaseId = 1100;
  static const int lunarBaseId = 1200;
  static const int sabbatBaseId = 1300;

  /// Max entries per range; used by the service to cancel stale IDs.
  static const int rangeSize = 40;

  static List<PlannedNotification> plan(
    NotificationSettings settings, {
    required DateTime now,
  }) {
    return [
      if (settings.dailyEnabled) ..._planDaily(settings, now),
      if (settings.lunarTransits) ..._planLunarPeaks(settings, now),
      if (settings.sabbatAlerts) ..._planSabbatEves(settings, now),
    ];
  }

  static DateTime _atTime(DateTime day, int dayOffset, NotificationSettings s) =>
      DateTime(day.year, day.month, day.day + dayOffset, s.hour, s.minute);

  static List<PlannedNotification> _planDaily(
      NotificationSettings s, DateTime now) {
    final todayAt = _atTime(now, 0, s);
    final startOffset = todayAt.isAfter(now) ? 0 : 1;

    return List.generate(dailyWindowDays, (i) {
      final when = _atTime(now, startOffset + i, s);
      final String body;
      if (s.lunarTransits) {
        final lunar = LunarCalculator.getTodayLunarInfo(when);
        body = 'The ${lunar.phase.title} illuminates ${lunar.moonZodiac}. '
            'Step into the sanctuary to draw your daily card.';
      } else {
        body = 'Your daily Tarot card awaits on the consecrated altar.';
      }
      return PlannedNotification(
        id: dailyBaseId + i,
        kind: NotificationKind.daily,
        title: '✦ Today\'s Astral Guidance ✦',
        body: body,
        when: when,
      );
    });
  }

  /// One alert on the first day of each New Moon / Full Moon window.
  static List<PlannedNotification> _planLunarPeaks(
      NotificationSettings s, DateTime now) {
    final result = <PlannedNotification>[];
    MoonPhaseType? previous;

    for (var d = 0; d <= lunarWindowDays; d++) {
      final when = _atTime(now, d, s);
      final lunar = LunarCalculator.getTodayLunarInfo(when);
      final phase = lunar.phase;
      final isPeak =
          phase == MoonPhaseType.newMoon || phase == MoonPhaseType.fullMoon;

      if (isPeak && phase != previous && when.isAfter(now)) {
        final isFull = phase == MoonPhaseType.fullMoon;
        result.add(PlannedNotification(
          id: lunarBaseId + result.length,
          kind: NotificationKind.lunar,
          title: isFull
              ? '🌕 Full Moon in ${lunar.moonZodiac}'
              : '🌑 New Moon in ${lunar.moonZodiac}',
          body: phase.guidance,
          when: when,
        ));
      }
      previous = phase;
    }
    return result;
  }

  /// Alert on the eve (day before) of each upcoming Sabbat.
  static List<PlannedNotification> _planSabbatEves(
      NotificationSettings s, DateTime now) {
    final result = <PlannedNotification>[];
    for (final occurrence in SabbatCalendar.upcoming(now)) {
      final when = _atTime(occurrence.date, -1, s);
      if (!when.isAfter(now)) continue;
      final event = occurrence.event;
      result.add(PlannedNotification(
        id: sabbatBaseId + result.length,
        kind: NotificationKind.sabbat,
        title: '✦ ${event.name} Eve ✦',
        body: '${event.seasonalTheme} begins tomorrow. '
            'Consecrate the ${event.recommendedSpreadTitle} on your altar.',
        when: when,
      ));
    }
    return result;
  }
}
