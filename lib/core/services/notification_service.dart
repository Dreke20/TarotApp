import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service.g.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      tz.initializeTimeZones();

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notificationsPlugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (response) {
          debugPrint('Notification clicked: ${response.payload}');
        },
      );

      _initialized = true;
    } catch (e) {
      debugPrint('Notification initialization warning: $e');
    }
  }

  /// Request permissions for iOS and Android 13+
  Future<bool> requestPermissions() async {
    try {
      final android = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        final granted = await android.requestNotificationsPermission();
        return granted ?? true;
      }

      final ios = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        final granted = await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? true;
      }
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
    }
    return true;
  }

  /// Schedules daily cosmic notification at specified hour and minute
  Future<void> scheduleDailyMorningReminder({
    int hour = 8,
    int minute = 0,
    bool enabled = true,
  }) async {
    if (!enabled) {
      await cancelDailyReminder();
      return;
    }

    try {
      await initialize();
      await requestPermissions();

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'oraculum_daily_guidance',
        'Daily Cosmic Guidance',
        channelDescription:
            'Morning celestial reminders to unveil your daily tarot card',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _notificationsPlugin.zonedSchedule(
        id: 101,
        title: '✨ The Veil is Thinning Today',
        body: 'Your Daily Guidance card is waiting on the sacred altar. Unveil your path.',
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      debugPrint('Daily reminder scheduled for $hour:$minute');
    } catch (e) {
      debugPrint('Error scheduling daily reminder: $e');
    }
  }

  /// Cancel daily scheduled notification
  Future<void> cancelDailyReminder() async {
    try {
      await _notificationsPlugin.cancel(id: 101);
    } catch (e) {
      debugPrint('Error canceling reminder: $e');
    }
  }

  /// Send immediate test or instant affirmation notification
  Future<void> showTestAffirmation({
    required String title,
    required String body,
  }) async {
    try {
      await initialize();
      const NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
          'oraculum_affirmations',
          'Cosmic Affirmations',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      );

      await _notificationsPlugin.show(
        id: 102,
        title: title,
        body: body,
        notificationDetails: details,
      );
    } catch (e) {
      debugPrint('Error showing affirmation: $e');
    }
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();
