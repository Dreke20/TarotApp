import 'dart:io';
import 'dart:ui' show Color;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../../core/utils/lunar_calculator.dart';
import '../domain/notification_planner.dart';
import '../domain/notification_settings.dart';

/// Platform adapter that schedules the [NotificationPlanner] output.
///
/// All notifications are one-shot at absolute instants (converted from local
/// wall-clock time), so no IANA timezone lookup is required and DST is
/// handled by the device clock. The window is refreshed on every app launch
/// and whenever settings change.
class SanctuaryNotificationService {
  static final SanctuaryNotificationService instance =
      SanctuaryNotificationService._internal();

  SanctuaryNotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Legacy repeating reminder ID from the old `NotificationService`.
  static const int _legacyDailyId = 101;
  static const int _sampleId = 9999;
  static const Color _gold = Color(0xFFD4AF37);

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized || kIsWeb) return;

    try {
      tz.initializeTimeZones();

      const darwinSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: darwinSettings,
          macOS: darwinSettings,
        ),
        onDidReceiveNotificationResponse: (response) {
          debugPrint('[SanctuaryNotification] Tapped: ${response.payload}');
        },
      );

      if (Platform.isAndroid) {
        await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('[SanctuaryNotification] Init safe fallback error: $e');
    }
  }

  /// Cancels all sanctuary notifications and schedules a fresh plan.
  Future<void> syncSchedule(NotificationSettings settings) async {
    if (kIsWeb) return;
    if (!_isInitialized) await initialize();
    if (!_isInitialized) return;
    if (!settings.anyEnabled) {
      await cancelAll();
      return;
    }

    try {
      await cancelAll();
      final plan = NotificationPlanner.plan(settings, now: DateTime.now());
      for (final n in plan) {
        await _plugin.zonedSchedule(
          id: n.id,
          title: n.title,
          body: n.body,
          scheduledDate: tz.TZDateTime.from(n.when, tz.UTC),
          notificationDetails: _detailsFor(n.kind),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          payload: 'oraculum://daily',
        );
      }
      debugPrint('[SanctuaryNotification] Scheduled ${plan.length} alerts.');
    } catch (e) {
      debugPrint('[SanctuaryNotification] Failed to sync schedule: $e');
    }
  }

  /// Cancels every sanctuary-managed notification ID (including legacy).
  Future<void> cancelAll() async {
    if (kIsWeb || !_isInitialized) return;
    try {
      await _plugin.cancel(id: _legacyDailyId);
      for (final base in const [
        NotificationPlanner.dailyBaseId,
        NotificationPlanner.lunarBaseId,
        NotificationPlanner.sabbatBaseId,
      ]) {
        for (var i = 0; i < NotificationPlanner.rangeSize; i++) {
          await _plugin.cancel(id: base + i);
        }
      }
    } catch (e) {
      debugPrint('[SanctuaryNotification] Error cancelling: $e');
    }
  }

  /// Sends an immediate sample notification for testing.
  Future<void> sendSampleCelestialAlert() async {
    if (kIsWeb) return;
    if (!_isInitialized) await initialize();
    if (!_isInitialized) return;

    try {
      final lunar = LunarCalculator.getTodayLunarInfo();
      await _plugin.show(
        id: _sampleId,
        title: '✦ The Sanctuary Beckons ✦',
        body: 'The ${lunar.phase.title} in ${lunar.moonZodiac} '
            '(${lunar.illuminationPercent.round()}% illuminated) radiates over '
            'your altar. The veil is thin.',
        notificationDetails: _detailsFor(NotificationKind.daily),
        payload: 'oraculum://daily',
      );
    } catch (e) {
      debugPrint('[SanctuaryNotification] Sample alert error: $e');
    }
  }

  NotificationDetails _detailsFor(NotificationKind kind) {
    final (String channelId, String channelName, String description) =
        switch (kind) {
      NotificationKind.daily => (
          'oraculum_daily_guidance',
          'Daily Astral Guidance',
          'Morning cosmic horary and Card of the Day reminders',
        ),
      NotificationKind.lunar => (
          'oraculum_lunar_transits',
          'Lunar Transit Alerts',
          'New Moon and Full Moon peak alerts',
        ),
      NotificationKind.sabbat => (
          'oraculum_sabbat_alerts',
          'Wheel of the Year Sabbats',
          'Reminders on the eve of each Sabbat',
        ),
    };

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: description,
        importance: Importance.high,
        priority: Priority.high,
        color: _gold,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }
}
