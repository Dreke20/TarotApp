import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/lunar_calculator.dart';
import '../data/tarot_card_data.dart';
import '../domain/tarot_card.dart';

part 'tarot_widget_service.g.dart';

/// Preference mode controlling how the Home Screen Widget chooses its active card.
enum WidgetSyncMode {
  dailySeed,
  activeReading;

  String get displayName {
    switch (this) {
      case WidgetSyncMode.dailySeed:
        return 'Daily Celestial Seed';
      case WidgetSyncMode.activeReading:
        return 'Active Reading Mirror';
    }
  }

  String get description {
    switch (this) {
      case WidgetSyncMode.dailySeed:
        return 'Automatically updates every midnight based on planetary transits';
      case WidgetSyncMode.activeReading:
        return 'Mirrors the most recent card drawn from your altar table';
    }
  }
}

/// Structured data container for the native Home Screen Widget.
class TarotWidgetData {
  final String cardTitle;
  final String cardSubtitle;
  final String cardMeaning;
  final String moonPhase;
  final String moonZodiac;
  final String transitGuidance;
  final String dailyDate;
  final String? cardImagePath;

  const TarotWidgetData({
    required this.cardTitle,
    required this.cardSubtitle,
    required this.cardMeaning,
    required this.moonPhase,
    required this.moonZodiac,
    required this.transitGuidance,
    required this.dailyDate,
    this.cardImagePath,
  });

  @override
  String toString() =>
      'TarotWidgetData(cardTitle: $cardTitle, moonPhase: $moonPhase, moonZodiac: $moonZodiac)';
}

/// Service that coordinates synchronization between the Flutter Tarot Engine
/// and native Android AppWidget / iOS Home Screen widgets.
class TarotWidgetService {
  static const String androidWidgetProvider = 'OraculumWidgetProvider';
  static const String _prefSyncModeKey = 'widget_sync_mode';
  static const String _prefLastCardIdKey = 'widget_last_card_id';
  static const String _prefLastCardReversedKey = 'widget_last_card_reversed';

  /// Deterministically derives a daily tarot card from the calendar date seed
  /// when the seeker hasn't yet drawn a manual daily card.
  TarotCard getDeterministicDailyCard([DateTime? date]) {
    final now = date ?? DateTime.now();
    // Unique deterministic seed per calendar day: YYYYMMDD
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final allCards = TarotCardData.allCards;
    return allCards[seed.abs() % allCards.length];
  }

  /// Copies a card webp asset into the app's local cache directory
  /// so native RemoteViews can decode the bitmap from file path.
  Future<String?> cacheCardAsset(String cardId) async {
    try {
      final assetPath = 'assets/cards/$cardId.webp';
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/widget_$cardId.webp');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      return file.path;
    } catch (e) {
      debugPrint('[TarotWidgetService] Error caching card asset: $e');
      return null;
    }
  }

  /// Retrieves the seeker's configured widget sync mode from preferences.
  Future<WidgetSyncMode> getSyncMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modeStr = prefs.getString(_prefSyncModeKey);
      if (modeStr == WidgetSyncMode.activeReading.name) {
        return WidgetSyncMode.activeReading;
      }
    } catch (e) {
      debugPrint('[TarotWidgetService] Error getting sync mode: $e');
    }
    return WidgetSyncMode.dailySeed;
  }

  /// Saves the seeker's widget sync mode preference.
  Future<void> setSyncMode(WidgetSyncMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefSyncModeKey, mode.name);
    } catch (e) {
      debugPrint('[TarotWidgetService] Error setting sync mode: $e');
    }
  }

  /// Saves the most recently drawn card for the widget mirror mode.
  Future<void> recordDrawnCard(TarotCard card, {bool isReversed = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefLastCardIdKey, card.id);
      await prefs.setBool(_prefLastCardReversedKey, isReversed);
    } catch (e) {
      debugPrint('[TarotWidgetService] Error recording drawn card: $e');
    }
  }

  /// Resolves the active card according to user sync mode preferences.
  Future<({TarotCard card, bool isReversed})> resolveActiveCard([DateTime? date]) async {
    final mode = await getSyncMode();
    if (mode == WidgetSyncMode.activeReading) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final lastId = prefs.getString(_prefLastCardIdKey);
        final isRev = prefs.getBool(_prefLastCardReversedKey) ?? false;
        if (lastId != null) {
          final found = TarotCardData.allCards.where((c) => c.id == lastId);
          if (found.isNotEmpty) {
            return (card: found.first, isReversed: isRev);
          }
        }
      } catch (e) {
        debugPrint('[TarotWidgetService] Error resolving active card from prefs: $e');
      }
    }
    return (card: getDeterministicDailyCard(date), isReversed: false);
  }

  /// Generates the complete [TarotWidgetData] model combining the active tarot card
  /// and the live ephemeris astronomical moon phase.
  TarotWidgetData generateDailyData({
    TarotCard? card,
    bool isReversed = false,
    DateTime? date,
    String? cardImagePath,
  }) {
    final now = date ?? DateTime.now();
    final effectiveCard = card ?? getDeterministicDailyCard(now);
    final lunarInfo = LunarCalculator.getTodayLunarInfo(now);

    final cardTitle = isReversed ? '${effectiveCard.name} (Reversed)' : effectiveCard.name;
    final arcanaUpper = effectiveCard.arcana.toUpperCase();
    final numberText = effectiveCard.number != null ? ' ${effectiveCard.number}' : '';
    final elementText = effectiveCard.element != null ? ' • ${effectiveCard.element}' : '';
    final cardSubtitle = '$arcanaUpper$numberText$elementText';

    final meaning = isReversed ? effectiveCard.meaningReversed : effectiveCard.meaningUpright;
    final moonPhaseText =
        '${lunarInfo.phase.symbol} ${lunarInfo.phase.title} (${lunarInfo.illuminationPercent.toInt()}%)';
    final moonZodiacText = 'Moon in ${lunarInfo.moonZodiac}';
    final formattedDate = DateFormat('EEEE, MMM d').format(now);

    return TarotWidgetData(
      cardTitle: cardTitle,
      cardSubtitle: cardSubtitle,
      cardMeaning: meaning,
      moonPhase: moonPhaseText,
      moonZodiac: moonZodiacText,
      transitGuidance: lunarInfo.transitGuidance,
      dailyDate: formattedDate,
      cardImagePath: cardImagePath,
    );
  }

  /// Synchronizes today's card and live moon phase to the native Android widget.
  Future<bool> updateHomeScreenWidget({
    TarotCard? card,
    bool isReversed = false,
    DateTime? date,
    String? cardImagePath,
  }) async {
    // Only attempt native home widget calls on mobile platforms
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      debugPrint('[TarotWidgetService] Skipping widget sync on non-mobile platform.');
      return false;
    }

    try {
      final effectiveCard = card ?? getDeterministicDailyCard(date);
      final effectiveImagePath = cardImagePath ?? await cacheCardAsset(effectiveCard.id);

      final widgetData = generateDailyData(
        card: effectiveCard,
        isReversed: isReversed,
        date: date,
        cardImagePath: effectiveImagePath,
      );

      await HomeWidget.saveWidgetData<String>('card_title', widgetData.cardTitle);
      await HomeWidget.saveWidgetData<String>('card_subtitle', widgetData.cardSubtitle);
      await HomeWidget.saveWidgetData<String>('card_meaning', widgetData.cardMeaning);
      await HomeWidget.saveWidgetData<String>('moon_phase', widgetData.moonPhase);
      await HomeWidget.saveWidgetData<String>('moon_zodiac', widgetData.moonZodiac);
      await HomeWidget.saveWidgetData<String>('daily_date', widgetData.dailyDate);
      if (widgetData.cardImagePath != null) {
        await HomeWidget.saveWidgetData<String>('card_image_path', widgetData.cardImagePath);
      }

      await HomeWidget.updateWidget(
        name: androidWidgetProvider,
        androidName: androidWidgetProvider,
      );

      debugPrint('[TarotWidgetService] Widget synced successfully: ${widgetData.cardTitle} | ${widgetData.moonPhase}');
      return true;
    } catch (e, stack) {
      debugPrint('[TarotWidgetService] Error updating home screen widget: $e\n$stack');
      return false;
    }
  }

  /// Convenience method that automatically syncs according to user preferences.
  Future<bool> syncFromPreferences() async {
    final active = await resolveActiveCard();
    return updateHomeScreenWidget(
      card: active.card,
      isReversed: active.isReversed,
    );
  }

  /// Requests the OS to pin the widget to the home screen (Android 8.0+).
  Future<bool> requestPinWidget() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      await HomeWidget.requestPinWidget(
        androidName: androidWidgetProvider,
      );
      return true;
    } catch (e) {
      debugPrint('[TarotWidgetService] Error requesting pin widget: $e');
      return false;
    }
  }
}

@riverpod
TarotWidgetService tarotWidgetService(Ref ref) {
  return TarotWidgetService();
}
