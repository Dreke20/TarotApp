import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/tarot/data/card_synergy_service.dart';
import 'package:tarot_app/features/tarot/domain/card_pair_synergy.dart';
import 'package:tarot_app/features/tarot/domain/tarot_card.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/card_synergy_modal.dart';
import 'package:tarot_app/features/tarot/presentation/widgets/typewriter_prophecy_view.dart';

void main() {
  const cardTower = TarotCard(
    id: 'm16',
    name: 'The Tower',
    arcana: 'major',
    number: 16,
    meaningUpright: 'Sudden upheaval, shattering of illusions',
    meaningReversed: 'Internal transformation, avoiding disaster',
    element: 'Fire',
  );

  const cardThreeSwords = TarotCard(
    id: 's03',
    name: 'Three of Swords',
    arcana: 'minor',
    suit: 'swords',
    number: 3,
    meaningUpright: 'Heartbreak, emotional grief, mental sorrow',
    meaningReversed: 'Recovery, releasing painful memories',
    element: 'Air',
  );

  const cardPriestess = TarotCard(
    id: 'm02',
    name: 'The High Priestess',
    arcana: 'major',
    number: 2,
    meaningUpright: 'Intuition, subconscious realms, divine mystery',
    meaningReversed: 'Secretive motives, disconnected from intuition',
    element: 'Water',
  );

  const cardMagician = TarotCard(
    id: 'm01',
    name: 'The Magician',
    arcana: 'major',
    number: 1,
    meaningUpright: 'Conscious will, resourcefulness, manifestation',
    meaningReversed: 'Blocked potential, manipulation',
    element: 'Air',
  );

  group('CardSynergyService Tests', () {
    test('synthesizes bespoke Tower and Three of Swords alchemical pair', () {
      final synergy = CardSynergyService.synthesize(cardTower, cardThreeSwords);

      expect(synergy.firstCard.id, 'm16');
      expect(synergy.secondCard.id, 's03');
      expect(synergy.alchemicalTitle, 'The Shattering of Outdated Mental Constructs');
      expect(synergy.alchemicalPhase, contains('Nigredo'));
      expect(synergy.elementalReaction, contains('Fire & Air'));
      expect(synergy.harmonyScore, 5);
      expect(synergy.synthesisInsight, contains('The Tower'));
      expect(synergy.synthesisInsight, contains('Three of Swords'));
      expect(synergy.actionableFormula, isNotEmpty);
    });

    test('synthesizes Magician and High Priestess hermetic pair', () {
      final synergy = CardSynergyService.synthesize(cardMagician, cardPriestess);

      expect(synergy.alchemicalTitle, 'The Hermetic Conjunction of Will & Mystery');
      expect(synergy.elementalReaction, contains('Water & Air'));
      expect(synergy.alchemicalPhase, contains('Albedo'));
    });

    test('generateAllPairs produces all N*(N-1)/2 unique pairs for spread', () {
      final spread = [cardTower, cardThreeSwords, cardPriestess];
      final allPairs = CardSynergyService.generateAllPairs(spread);

      expect(allPairs.length, 3); // 3 * 2 / 2 = 3 pairs
      expect(allPairs[0].firstCard.id, cardTower.id);
      expect(allPairs[0].secondCard.id, cardThreeSwords.id);
      expect(allPairs[1].firstCard.id, cardTower.id);
      expect(allPairs[1].secondCard.id, cardPriestess.id);
      expect(allPairs[2].firstCard.id, cardThreeSwords.id);
      expect(allPairs[2].secondCard.id, cardPriestess.id);
    });

    test('generateAllPairs handles single card with shadow mirror synthesis', () {
      final pairs = CardSynergyService.generateAllPairs([cardTower]);

      expect(pairs.length, 1);
      expect(pairs.first.firstCard.id, cardTower.id);
      expect(pairs.first.secondCard.name, contains('Shadow Mirror'));
      expect(pairs.first.secondCard.isReversed, isTrue);
    });

    test('handles JSON serialization roundtrip for CardPairSynergy', () {
      final synergy = CardSynergyService.synthesize(cardTower, cardThreeSwords);
      final json = synergy.toJson();
      final revived = CardPairSynergy.fromJson(json);

      expect(revived.alchemicalTitle, synergy.alchemicalTitle);
      expect(revived.harmonyScore, synergy.harmonyScore);
      expect(revived.elementalReaction, synergy.elementalReaction);
      expect(revived.firstCard.name, 'The Tower');
      expect(revived.secondCard.name, 'Three of Swords');
    });
  });

  group('TypewriterProphecyView Widget Tests', () {
    testWidgets('unveils text progressively and reveals all on skip', (tester) async {
      bool completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TypewriterProphecyView(
              text: 'The stars illuminate your destiny with boundless golden light.',
              tokenCadence: const Duration(milliseconds: 10),
              autoStart: true,
              onCompleted: () => completed = true,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 20));

      // Initially active scrying
      expect(find.textContaining('SCRYING STREAM ACTIVE'), findsOneWidget);
      expect(find.text('REVEAL ALL'), findsOneWidget);

      // Tap REVEAL ALL
      await tester.tap(find.text('REVEAL ALL'));
      await tester.pump(const Duration(milliseconds: 20));

      expect(find.textContaining('The stars illuminate your destiny'), findsOneWidget);
      expect(find.text('PROPHECY MANIFESTED'), findsOneWidget);
      expect(completed, isTrue);
    });

    testWidgets('renders completed state immediately when autoStart is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypewriterProphecyView(
              text: 'Ancient wisdom speaks in silence.',
              autoStart: false,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 20));

      expect(find.text('PROPHECY MANIFESTED'), findsOneWidget);
      expect(find.textContaining('Ancient wisdom speaks in silence.'), findsOneWidget);
    });
  });

  group('CardSynergyModal Widget Tests', () {
    testWidgets('renders dual-card synergy modal with title and archetypes', (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final spread = [cardTower, cardThreeSwords, cardPriestess];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CardSynergyModal(
                spreadCards: spread,
                initialCard1: cardTower,
                initialCard2: cardThreeSwords,
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('ALCHEMICAL SYNERGY'), findsOneWidget);
      expect(find.text('The Shattering of Outdated Mental Constructs'), findsOneWidget);
      expect(find.textContaining('NIGREDO'), findsOneWidget);
      expect(find.text('ARCHETYPAL SYNTHESIS'), findsOneWidget);
      expect(find.text('ALCHEMICAL INTEGRATION PROTOCOL'), findsOneWidget);

      // Can switch between spread pairs
      expect(find.text('${cardTower.name} + ${cardPriestess.name}'), findsOneWidget);
      await tester.tap(find.text('${cardTower.name} + ${cardPriestess.name}'));
      await tester.pump(const Duration(milliseconds: 100));

      // Updated pair is displayed
      expect(find.textContaining('Volatile Steam'), findsWidgets);
    });
  });
}
