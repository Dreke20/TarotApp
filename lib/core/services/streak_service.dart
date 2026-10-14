import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const String _keyLastDate = 'oraculum_last_reading_date';
  static const String _keyStreakCount = 'oraculum_streak_count';

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_keyLastDate);
    final count = prefs.getInt(_keyStreakCount) ?? 0;

    if (lastDateStr == null) return 0;
    final lastDate = DateTime.tryParse(lastDateStr);
    if (lastDate == null) return 0;

    final now = DateTime.now();
    final difference = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
        .inDays;

    if (difference <= 1) {
      return count;
    } else {
      // Streak broken
      return 0;
    }
  }

  static Future<int> recordReadingToday() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayStr = DateTime(now.year, now.month, now.day).toIso8601String();

    final lastDateStr = prefs.getString(_keyLastDate);
    final currentCount = prefs.getInt(_keyStreakCount) ?? 0;

    if (lastDateStr == null) {
      await prefs.setString(_keyLastDate, todayStr);
      await prefs.setInt(_keyStreakCount, 1);
      return 1;
    }

    final lastDate = DateTime.tryParse(lastDateStr) ?? now;
    final difference = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
        .inDays;

    int newStreak = currentCount;
    if (difference == 0) {
      // Already read today
      newStreak = currentCount > 0 ? currentCount : 1;
    } else if (difference == 1) {
      // Consecutive day!
      newStreak = currentCount + 1;
    } else {
      // Broken streak, restart
      newStreak = 1;
    }

    await prefs.setString(_keyLastDate, todayStr);
    await prefs.setInt(_keyStreakCount, newStreak);
    return newStreak;
  }
}

final streakProvider = FutureProvider<int>((ref) async {
  return StreakService.getStreak();
});
