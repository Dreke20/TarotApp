import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service managing respectful, native in-app review prompts on Google Play & App Store
/// following high-satisfaction user milestones (e.g., 3rd completed reading or 7-day streak).
class ReviewService {
  static final ReviewService instance = ReviewService._();
  ReviewService._();

  final InAppReview _inAppReview = InAppReview.instance;

  static const String _kCompletedReadingsCountKey =
      'review_completed_readings_count';
  static const String _kHasPromptedReviewKey = 'review_has_prompted_user';

  /// Records reading completion and triggers in-app review prompt on high-satisfaction milestones.
  Future<void> checkAndPromptForReview({int? streak}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasPrompted = prefs.getBool(_kHasPromptedReviewKey) ?? false;
      if (hasPrompted) return;

      final count = (prefs.getInt(_kCompletedReadingsCountKey) ?? 0) + 1;
      await prefs.setInt(_kCompletedReadingsCountKey, count);

      // Trigger condition: 3 completed readings or a 7-day streak
      final shouldPrompt = count >= 3 || (streak != null && streak >= 7);
      if (shouldPrompt) {
        if (await _inAppReview.isAvailable()) {
          await _inAppReview.requestReview();
          await prefs.setBool(_kHasPromptedReviewKey, true);
        }
      }
    } catch (e) {
      debugPrint('[ReviewService] In-app review check note: $e');
    }
  }
}
