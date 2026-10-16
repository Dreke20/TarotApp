import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/lunar_calculator.dart';
import '../data/tarot_card_data.dart';
import '../domain/tarot_card.dart';

part 'tarot_widget_service.g.dart';

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
/// and native Android AppWidget / Home Screen widgets.
class TarotWidgetService {
  static const String androidWidgetProvider = 'OraculumWidgetProvider';

  /// Deterministically derives a daily tarot card from the calendar date seed
  /// when the seeker hasn't yet drawn a manual daily card.
  TarotCard getDeterministicDailyCard([DateTime? date]) {
    final now = date ?? DateTime.now();
    // Unique deterministic seed per calendar day: YYYYMMDD
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final allCards = TarotCardData.allCards;
    return allCards[seed.abs() % allCards.length];
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
  ///
  /// Resilient against desktop, web, and unit testing environments.
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
      final widgetData = generateDailyData(
        card: card,
        isReversed: isReversed,
        date: date,
        cardImagePath: cardImagePath,
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
}

@riverpod
TarotWidgetService tarotWidgetService(Ref ref) {
  return TarotWidgetService();
}
