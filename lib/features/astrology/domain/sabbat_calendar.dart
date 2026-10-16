import '../../tarot/domain/spread_type.dart';

/// A fixed-date festival on the Wheel of the Year.
class SabbatEvent {
  final String name;
  final String dateDescription;
  final int month;
  final int day;
  final String seasonalTheme;
  final String recommendedSpreadTitle;
  final SpreadType spreadType;
  final String ritualFocus;

  const SabbatEvent({
    required this.name,
    required this.dateDescription,
    required this.month,
    required this.day,
    required this.seasonalTheme,
    required this.recommendedSpreadTitle,
    required this.spreadType,
    required this.ritualFocus,
  });
}

/// A concrete calendar occurrence of a [SabbatEvent].
class SabbatOccurrence {
  final SabbatEvent event;
  final DateTime date;

  const SabbatOccurrence({required this.event, required this.date});

  /// Whole calendar days from [from] (date-only) until this occurrence.
  int daysFrom(DateTime from) {
    final start = DateTime(from.year, from.month, from.day);
    return date.difference(start).inDays;
  }
}

/// Pure domain calendar for the eight Sabbats, with correct year rollover.
class SabbatCalendar {
  const SabbatCalendar._();

  static const List<SabbatEvent> sabbats = [
    SabbatEvent(
      name: 'Samhain',
      dateDescription: 'October 31',
      month: 10,
      day: 31,
      seasonalTheme: 'Thinning Veil & Ancestral Communion',
      recommendedSpreadTitle: 'Shadow Mirror (5 Cards)',
      spreadType: SpreadType.shadowMirror,
      ritualFocus: 'Deep shadow integration, releasing past cycle karma, and ancestral wisdom.',
    ),
    SabbatEvent(
      name: 'Yule',
      dateDescription: 'December 21',
      month: 12,
      day: 21,
      seasonalTheme: 'Winter Solstice & Rebirth of the Light',
      recommendedSpreadTitle: 'Three Fates (3 Cards)',
      spreadType: SpreadType.threeFates,
      ritualFocus: 'Solitary stillness, seed setting in the dark, and honoring the reborn sun.',
    ),
    SabbatEvent(
      name: 'Imbolc',
      dateDescription: 'February 1 - 2',
      month: 2,
      day: 1,
      seasonalTheme: 'Awakening Hearth & Sacred Purification',
      recommendedSpreadTitle: 'Daily Guidance (1 Card)',
      spreadType: SpreadType.dailyGuidance,
      ritualFocus: 'Purification of the spiritual altar, clarifying intentions for the coming spring.',
    ),
    SabbatEvent(
      name: 'Ostara',
      dateDescription: 'March 20 - 21',
      month: 3,
      day: 20,
      seasonalTheme: 'Spring Equinox & Elemental Equilibrium',
      recommendedSpreadTitle: 'Celtic Cross (10 Cards)',
      spreadType: SpreadType.celticCross,
      ritualFocus: 'Equal light and dark, blooming potential, and broad strategic life navigation.',
    ),
    SabbatEvent(
      name: 'Beltane',
      dateDescription: 'May 1',
      month: 5,
      day: 1,
      seasonalTheme: 'Sacred Fire & Passionate Union',
      recommendedSpreadTitle: 'Heart of Two (5 Cards)',
      spreadType: SpreadType.heartOfTwo,
      ritualFocus: 'Fertility of heart, divine partner synastry, and creative fire manifestation.',
    ),
    SabbatEvent(
      name: 'Litha',
      dateDescription: 'June 20 - 21',
      month: 6,
      day: 21,
      seasonalTheme: 'Summer Solstice & Zenith of Radiance',
      recommendedSpreadTitle: 'Wheel of the Year (12 Houses)',
      spreadType: SpreadType.wheelOfTheYear,
      ritualFocus: 'Peak personal power, celebrating abundance, and mapping the 12 cosmic houses.',
    ),
    SabbatEvent(
      name: 'Lughnasadh',
      dateDescription: 'August 1',
      month: 8,
      day: 1,
      seasonalTheme: 'First Grain Harvest & Gratitude',
      recommendedSpreadTitle: 'Career Crossroads (5 Cards)',
      spreadType: SpreadType.careerCrossroads,
      ritualFocus: 'Reaping initial rewards of dedicated labor, skill mastery, and generosity.',
    ),
    SabbatEvent(
      name: 'Mabon',
      dateDescription: 'September 21 - 22',
      month: 9,
      day: 21,
      seasonalTheme: 'Autumn Equinox & Second Harvest',
      recommendedSpreadTitle: 'Three Fates (3 Cards)',
      spreadType: SpreadType.threeFates,
      ritualFocus: 'Restoring cosmic equilibrium, preserving wisdom for the darker half of the year.',
    ),
  ];

  /// Returns upcoming occurrences on or after [from] (date-only), sorted
  /// chronologically. Each Sabbat appears exactly once.
  static List<SabbatOccurrence> upcoming(DateTime from) {
    final today = DateTime(from.year, from.month, from.day);
    final occurrences = sabbats.map((s) {
      var date = DateTime(today.year, s.month, s.day);
      if (date.isBefore(today)) {
        date = DateTime(today.year + 1, s.month, s.day);
      }
      return SabbatOccurrence(event: s, date: date);
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return occurrences;
  }

  /// The next Sabbat on or after [from]; today counts as "next".
  static SabbatOccurrence next(DateTime from) => upcoming(from).first;
}
