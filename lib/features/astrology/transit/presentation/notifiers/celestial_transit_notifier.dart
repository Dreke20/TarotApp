import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tarot_app/features/auth/presentation/auth_notifier.dart';
import 'package:tarot_app/features/astrology/data/ephemeris_calculator.dart';
import 'package:tarot_app/features/astrology/domain/natal_chart.dart';
import 'package:tarot_app/features/astrology/transit/data/celestial_transit_calculator.dart';
import 'package:tarot_app/features/astrology/transit/domain/celestial_transit.dart';

part 'celestial_transit_notifier.g.dart';

@Riverpod(keepAlive: true)
class CelestialTransitNotifier extends _$CelestialTransitNotifier {
  @override
  CelestialTransitSnapshot build() {
    final profile = ref.watch(authProvider).profile;
    NatalChart? chart;
    if (profile?.zodiacSign != null) {
      chart = EphemerisCalculator.calculateChart(
        sunSign: profile!.zodiacSign!,
        moonSign: profile.moonSign,
        risingSign: profile.risingSign,
      );
    } else {
      chart = EphemerisCalculator.calculateChart(
        sunSign: 'Scorpio',
      );
    }

    return CelestialTransitCalculator.calculateSnapshot(
      date: DateTime.now(),
      seekerNatalChart: chart,
    );
  }

  /// Refreshes the celestial transit snapshot with the latest astronomical moment.
  void refreshTransit() {
    final profile = ref.read(authProvider).profile;
    final chart = EphemerisCalculator.calculateChart(
      sunSign: profile?.zodiacSign ?? 'Scorpio',
      moonSign: profile?.moonSign,
      risingSign: profile?.risingSign,
    );

    state = CelestialTransitCalculator.calculateSnapshot(
      date: DateTime.now(),
      seekerNatalChart: chart,
    );
  }
}
