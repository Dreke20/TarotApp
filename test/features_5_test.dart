import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/core/widgets/holographic_foil_card.dart';
import 'package:tarot_app/core/widgets/stardust_particle_field.dart';
import 'package:tarot_app/features/astrology/data/ephemeris_calculator.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';
import 'package:tarot_app/features/tarot/domain/synastry_partner.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/social_story_export_modal.dart';

void main() {
  group('Category-Defining 5 Features Tests', () {
    test('EphemerisCalculator correctly calculates Zodiac signs and Soul Cards', () {
      final scorpioDate = DateTime(1998, 10, 24);
      final scorpioSign = EphemerisCalculator.getZodiacSignFromDate(scorpioDate);
      expect(scorpioSign, 'Scorpio');

      // 1+9+9+8+1+0+2+4 = 34 -> 3+4 = 7 (The Chariot)
      final soulCardNum = EphemerisCalculator.calculateSoulCardNumber(scorpioDate);
      expect(soulCardNum, 7);

      final taurusDate = DateTime(1995, 5, 12);
      final taurusSign = EphemerisCalculator.getZodiacSignFromDate(taurusDate);
      expect(taurusSign, 'Taurus');
    });

    test('SynastryPartner serializes and deserializes accurately', () {
      const partner = SynastryPartner(
        name: 'Elena',
        sunSign: 'Pisces',
        moonSign: 'Scorpio',
        risingSign: 'Cancer',
        connectionType: 'Twin Flame',
      );

      final json = partner.toJson();
      expect(json['name'], 'Elena');
      expect(json['sun_sign'], 'Pisces');
      expect(json['connection_type'], 'Twin Flame');

      final reconstructed = SynastryPartner.fromJson(json);
      expect(reconstructed.name, 'Elena');
      expect(reconstructed.sunSign, 'Pisces');
      expect(reconstructed.connectionType, 'Twin Flame');
    });

    testWidgets('StardustParticleField renders without layout overflows', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StardustParticleField(
                enableAmbientDrift: true,
                enableTouchTrails: true,
                child: Center(child: Text('Cosmic Altar')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Cosmic Altar'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets('HolographicFoilCard renders child and specular overlay safely', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 120,
                  height: 200,
                  child: HolographicFoilCard(
                    enableSensorTilt: false,
                    enableTouchTilt: false,
                    child: Text('The Magician'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('The Magician'), findsOneWidget);
    });

    testWidgets('SocialStoryExportModal mounts 9:16 story frame with card data', (tester) async {
      final sampleCard = TarotCardData.allCards.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialStoryExportModal(
              card: sampleCard,
              isReversed: false,
              customQuote: 'The cosmic journey begins.',
            ),
          ),
        ),
      );

      expect(find.text('STORY EXPORT ENGINE'), findsOneWidget);
      expect(find.text('✦ ORACULUM ✦'), findsOneWidget);
      expect(find.text(sampleCard.name), findsWidgets);
    });
  });
}
