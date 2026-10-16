import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';

/// Immutable seeker preferences for scheduled sanctuary notifications.
@freezed
abstract class NotificationSettings with _$NotificationSettings {
  const NotificationSettings._();

  const factory NotificationSettings({
    @Default(true) bool dailyEnabled,
    @Default(8) int hour,
    @Default(0) int minute,
    @Default(true) bool lunarTransits,
    @Default(true) bool sabbatAlerts,
  }) = _NotificationSettings;

  /// Whether any notification category is active.
  bool get anyEnabled => dailyEnabled || lunarTransits || sabbatAlerts;

  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
