import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/core/utils/lunar_calculator.dart';
import 'package:tarot_app/features/auth/data/auth_repository.dart';
import 'package:tarot_app/features/auth/domain/user_profile.dart';
import 'package:tarot_app/features/tarot/data/tarot_deck_service.dart';
import 'package:tarot_app/features/tarot/domain/oracle_message.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/features/divination/data/rune_data.dart';
import 'package:tarot_app/features/divination/data/iching_data.dart';
import 'package:tarot_app/features/dream/data/jungian_symbol_data.dart';
import 'package:tarot_app/features/astrology/data/ephemeris_calculator.dart';
import 'package:tarot_app/core/services/admob_service.dart';
import 'package:tarot_app/features/monetization/presentation/monetization_state.dart';
import 'package:tarot_app/features/subscription/domain/subscription_plan.dart';
import 'package:tarot_app/features/subscription/presentation/subscription_state.dart';
import 'package:tarot_app/features/subscription/data/in_app_purchase_service.dart';
import 'package:tarot_app/core/services/ambient_soundscape_service.dart';
import 'package:tarot_app/main.dart';

void main() {
  group('Tarot Engine Domain Tests', () {
    test('Deck contains 78 unique cards', () {
      final service = TarotDeckService();
      final deck = service.getFullDeck();
      expect(deck.length, 78);

      final uniqueIds = deck.map((c) => c.id).toSet();
      expect(uniqueIds.length, 78);
    });

    test('Fisher-Yates shuffle produces properly permuted deck', () {
      final service = TarotDeckService();
      final deck = service.getFullDeck();
      final shuffled = service.shuffleDeck(deck: deck);

      expect(shuffled.length, 78);
      final exactOrderMatch = List.generate(78, (i) => deck[i].id == shuffled[i].id)
          .every((matches) => matches);
      expect(exactOrderMatch, isFalse);
    });

    test('Daily Guidance draws 1 card with correct position name', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.dailyGuidance);

      expect(drawn.length, 1);
      expect(drawn.first.positionName, 'Today\'s Guidance');
    });

    test('The Three Fates draws 3 cards with Past, Present, Future positions', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.threeFates);

      expect(drawn.length, 3);
      expect(drawn[0].positionName, contains('Past'));
      expect(drawn[1].positionName, contains('Present'));
      expect(drawn[2].positionName, contains('Future'));
    });

    test('The Celtic Cross draws 10 cards with all 10 life path positions', () {
      final service = TarotDeckService();
      final drawn = service.drawSpread(spreadType: SpreadType.celticCross);

      expect(drawn.length, 10);
      expect(drawn[0].positionName, contains('Present'));
      expect(drawn[1].positionName, contains('Crossing'));
      expect(drawn[9].positionName, contains('Culmination'));
    });

    test('OracleMessage model serializes and parses properly', () {
      final msg = OracleMessage(
        role: 'user',
        content: 'What does the Empress signify here?',
        timestamp: DateTime(2026, 10, 13),
      );
      final json = msg.toJson();
      expect(json['role'], 'user');
      expect(json['content'], 'What does the Empress signify here?');

      final parsed = OracleMessage.fromJson(json);
      expect(parsed.role, 'user');
      expect(parsed.content, msg.content);
    });

    test('UserProfile supports astrological signs and pro membership', () {
      const profile = UserProfile(
        id: 'u1',
        displayName: 'Aura',
        zodiacSign: 'Aries',
        moonSign: 'Scorpio',
        risingSign: 'Leo',
        isPro: true,
      );
      expect(profile.isPro, isTrue);
      expect(profile.zodiacSign, 'Aries');
      expect(profile.moonSign, 'Scorpio');
      expect(profile.risingSign, 'Leo');
    });

    test('AuthRepository verifyAndActivatePro does not grant guest Pro', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = AuthRepository();
      await expectLater(
        repo.verifyAndActivatePro(
          action: 'subscribe',
          plan: 'yearly',
          receipt: 'play-purchase-token',
          productId: 'oracle_pro_yearly',
          source: 'google_play',
        ),
        throwsA(isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('Sign in'),
        )),
      );
      expect((await repo.getCurrentProfile()).isPro, isFalse);
    });

    test('Specialized Spreads draw accurate card counts and positions', () {
      final service = TarotDeckService();

      final heart = service.drawSpread(spreadType: SpreadType.heartOfTwo);
      expect(heart.length, 5);
      expect(heart[0].positionName, contains('Emotional Core'));
      expect(heart[4].positionName, contains('Harmonious Horizon'));

      final career = service.drawSpread(spreadType: SpreadType.careerCrossroads);
      expect(career.length, 5);
      expect(career[0].positionName, contains('Professional Station'));
      expect(career[4].positionName, contains('Peak Career'));

      final shadow = service.drawSpread(spreadType: SpreadType.shadowMirror);
      expect(shadow.length, 4);
      expect(shadow[0].positionName, contains('Persona'));
      expect(shadow[3].positionName, contains('Integration'));
    });

    test('LunarCalculator calculates valid moon phase and illumination', () {
      final lunar = LunarCalculator.getTodayLunarInfo();
      expect(lunar.phase.title.isNotEmpty, isTrue);
      expect(lunar.phase.symbol.isNotEmpty, isTrue);
      expect(lunar.illuminationPercent, inInclusiveRange(0.0, 100.0));
      expect(lunar.moonZodiac.isNotEmpty, isTrue);
    });

    test('Wheel of the Year 12-House Spread draws 12 cards with zodiac houses', () {
      final service = TarotDeckService();
      final wheel = service.drawSpread(spreadType: SpreadType.wheelOfTheYear);
      expect(wheel.length, 12);
      expect(wheel[0].positionName, contains('1st House'));
      expect(wheel[11].positionName, contains('12th House'));
    });

    test('Elder Futhark Runes dataset contains all 24 sacred stones across 3 Aetts', () {
      expect(RuneData.allRunes.length, 24);
      final uniqueIds = RuneData.allRunes.map((r) => r.id).toSet();
      expect(uniqueIds.length, 24);
      expect(RuneData.allRunes.where((r) => r.aett == "Freya's Aett").length, 8);
      expect(RuneData.allRunes.where((r) => r.aett == "Heimdall's Aett").length, 8);
      expect(RuneData.allRunes.where((r) => r.aett == "Tyr's Aett").length, 8);
    });

    test('I Ching dataset provides primary hexagrams with 6 binary lines', () {
      expect(IChingData.primaryHexagrams.isNotEmpty, isTrue);
      for (final hex in IChingData.primaryHexagrams) {
        expect(hex.lines.length, 6);
        expect(hex.name.isNotEmpty, isTrue);
        expect(hex.chineseCharacter.isNotEmpty, isTrue);
      }
    });

    test('Jungian Archetypes catalog links dream symbols to corresponding Tarot cards', () {
      expect(JungianArchetypes.allSymbols.length, greaterThanOrEqualTo(10));
      final water = JungianArchetypes.findByKey('water');
      expect(water.tarotCardName, 'The Moon');
      final tower = JungianArchetypes.findByKey('tower');
      expect(tower.tarotCardName, 'The Tower');
    });

    test('EphemerisCalculator generates 8 planetary placements and elemental balance', () {
      final chart = EphemerisCalculator.calculateChart(
        sunSign: 'Scorpio',
        moonSign: 'Pisces',
        risingSign: 'Cancer',
      );
      expect(chart.placements.length, 8);
      expect(chart.dominantElement, 'Water');
      expect(chart.waterPercent, greaterThan(0.0));
      expect(chart.soulArchetype.isNotEmpty, isTrue);
    });

    test('MonetizationState tracks starlight pass tokens and handles offerings', () {
      const initial = MonetizationState();
      expect(initial.starlightPassTokens, 0);
      expect(initial.hasStarlightPass, isFalse);

      final withTokens = initial.copyWith(starlightPassTokens: 2);
      expect(withTokens.hasStarlightPass, isTrue);
      expect(withTokens.starlightPassTokens, 2);

      final consumed = withTokens.copyWith(starlightPassTokens: withTokens.starlightPassTokens - 1);
      expect(consumed.starlightPassTokens, 1);
      expect(consumed.hasStarlightPass, isTrue);
    });

    test('AdMobService provides singleton instance and initialization flags', () {
      final admob = AdMobService.instance;
      expect(admob, isNotNull);
      expect(admob.isNativeSupported, isA<bool>());
    });

    test('SubscriptionPlan enum contains valid Play Billing / StoreKit product identifiers', () {
      expect(SubscriptionPlan.allProductIds.contains('oracle_pro_yearly'), isTrue);
      expect(SubscriptionPlan.allProductIds.contains('oracle_pro_monthly'), isTrue);
      expect(SubscriptionPlan.allProductIds.contains('oracle_pro_lifetime'), isTrue);
      expect(SubscriptionPlan.fromId('oracle_pro_yearly'), SubscriptionPlan.yearly);
      expect(SubscriptionPlan.fromId('oracle_pro_monthly'), SubscriptionPlan.monthly);
      expect(SubscriptionPlan.yearly.defaultPrice, '\$49.99 / yr');
    });

    test('SubscriptionState maintains immutable plan pricing and defaults', () {
      const state = SubscriptionState();
      expect(state.selectedPlan, SubscriptionPlan.yearly);
      expect(state.isAvailable, isFalse);
      expect(state.isLoading, isFalse);
      expect(state.priceFor(SubscriptionPlan.yearly), '\$49.99 / yr');

      final withLocalized = state.copyWith(
        localizedPrices: {'oracle_pro_yearly': '€27.99 / yr'},
      );
      expect(withLocalized.priceFor(SubscriptionPlan.yearly), '€27.99 / yr');
      expect(withLocalized.priceFor(SubscriptionPlan.monthly), '\$9.99 / mo');
    });

    test('InAppPurchaseService instantiates with clean stream defaults', () {
      final service = InAppPurchaseService();
      expect(service, isNotNull);
      expect(service.isAvailable, isFalse);
      expect(service.products, isEmpty);
      service.dispose();
    });

    test('SoundscapeTrack catalog contains all 6 sacred Solfeggio and ambient loops', () {
      expect(SoundscapeTrack.values.length, 6);
      expect(SoundscapeTrack.solfeggio432.assetPath, 'audio/solfeggio_432.wav');
      expect(SoundscapeTrack.solfeggio528.assetPath, 'audio/solfeggio_528.wav');
      expect(SoundscapeTrack.solfeggio741.assetPath, 'audio/solfeggio_741.wav');
      expect(SoundscapeTrack.celestialDrone.assetPath, 'audio/celestial_drone.wav');
      expect(SoundscapeTrack.tibetanBowls.assetPath, 'audio/tibetan_bowls.wav');
      expect(SoundscapeTrack.sacredWind.assetPath, 'audio/astral_breeze.wav');
    });

    test('AmbientAudioState manages volume and loop tracking', () {
      const state = AmbientAudioState();
      expect(state.isPlaying, isFalse);
      expect(state.volume, 0.5);
      expect(state.track, SoundscapeTrack.solfeggio432);

      final playing = state.copyWith(isPlaying: true, volume: 0.8, track: SoundscapeTrack.solfeggio528);
      expect(playing.isPlaying, isTrue);
      expect(playing.volume, 0.8);
      expect(playing.track, SoundscapeTrack.solfeggio528);
    });
  });

  group('TarotApp Smoke Test', () {
    testWidgets('App renders Astral Guidance altar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: TarotApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('ASTRAL GUIDANCE'), findsOneWidget);
      expect(find.text('CONSULT ORACLE'), findsOneWidget);
    });
  });
}
