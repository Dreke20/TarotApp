import 'package:shared_preferences/shared_preferences.dart';
import '../domain/notification_settings.dart';

/// SharedPreferences persistence for [NotificationSettings].
class NotificationSettingsStore {
  const NotificationSettingsStore._();

  static const String _keyDaily = 'notif_daily_enabled';
  static const String _keyHour = 'notif_hour';
  static const String _keyMinute = 'notif_minute';
  static const String _keyLunar = 'notif_lunar';
  static const String _keySabbat = 'notif_sabbat';

  /// Set once the seeker has opened the reminders sanctuary. Until then we
  /// never schedule (or prompt for permission) at app launch.
  static const String _keyConfigured = 'notif_configured';

  static Future<NotificationSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    const defaults = NotificationSettings();
    return NotificationSettings(
      dailyEnabled: prefs.getBool(_keyDaily) ?? defaults.dailyEnabled,
      hour: prefs.getInt(_keyHour) ?? defaults.hour,
      minute: prefs.getInt(_keyMinute) ?? defaults.minute,
      lunarTransits: prefs.getBool(_keyLunar) ?? defaults.lunarTransits,
      sabbatAlerts: prefs.getBool(_keySabbat) ?? defaults.sabbatAlerts,
    );
  }

  static Future<void> save(NotificationSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDaily, settings.dailyEnabled);
    await prefs.setInt(_keyHour, settings.hour);
    await prefs.setInt(_keyMinute, settings.minute);
    await prefs.setBool(_keyLunar, settings.lunarTransits);
    await prefs.setBool(_keySabbat, settings.sabbatAlerts);
    await prefs.setBool(_keyConfigured, true);
  }

  static Future<bool> isConfigured() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyConfigured) ?? false;
  }
}
