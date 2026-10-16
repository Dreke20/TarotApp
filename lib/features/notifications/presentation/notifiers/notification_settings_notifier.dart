import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/notification_settings_store.dart';
import '../../data/sanctuary_notification_service.dart';
import '../../domain/notification_settings.dart';

part 'notification_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  @override
  NotificationSettings build() {
    _loadAndSync();
    return const NotificationSettings();
  }

  Future<void> _loadAndSync() async {
    try {
      final loaded = await NotificationSettingsStore.load();
      state = loaded;
      // Opening the reminders sanctuary counts as opting in: persist and
      // schedule so launches keep the rolling window fresh from now on.
      await _persistAndSync();
    } catch (_) {
      // Keep defaults if storage is unavailable.
    }
  }

  Future<void> _update(NotificationSettings next) async {
    state = next;
    await _persistAndSync();
  }

  Future<void> _persistAndSync() async {
    try {
      await NotificationSettingsStore.save(state);
      await SanctuaryNotificationService.instance.syncSchedule(state);
    } catch (_) {
      // Scheduling failures are non-fatal; the UI state remains accurate.
    }
  }

  Future<void> toggleDaily(bool enabled) =>
      _update(state.copyWith(dailyEnabled: enabled));

  Future<void> setTime(int hour, int minute) =>
      _update(state.copyWith(hour: hour, minute: minute));

  Future<void> toggleLunar(bool enabled) =>
      _update(state.copyWith(lunarTransits: enabled));

  Future<void> toggleSabbat(bool enabled) =>
      _update(state.copyWith(sabbatAlerts: enabled));
}
