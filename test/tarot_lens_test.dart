import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarot_app/features/lens/data/tarot_lens_service.dart';
import 'package:tarot_app/features/lens/domain/tarot_lens_scan_result.dart';
import 'package:tarot_app/features/lens/presentation/notifiers/tarot_lens_notifier.dart';
import 'package:tarot_app/features/lens/presentation/screens/tarot_lens_screen.dart';
import 'package:tarot_app/features/tarot/data/tarot_card_data.dart';

void main() {
  group('Tarot Lens & Multimodal Scrying Tests', () {
    test('TarotLensScanResult domain model serializes and deserializes accurately', () {
      final card = TarotCardData.allCards.first; // The Fool
      final result = TarotLensScanResult(
        card: card,
        confidencePercent: 97,
        isReversed: false,
        detectedSymbols: const ['White Rose of Purity', 'Feathered Cap'],
        scryingAnalysis: 'Spontaneous leap of faith into new spiritual horizons.',
        physicalAltarRitual: 'Place at center altar with Clear Quartz.',
        capturedImagePath: '/mock/path/fool.jpg',
        isHighConfidence: true,
      );

      final json = result.toJson();
      expect(json['confidencePercent'], 97);
      expect(json['isReversed'], false);
      expect(json['detectedSymbols'], contains('White Rose of Purity'));
      expect(json['capturedImagePath'], '/mock/path/fool.jpg');

      final reconstructed = TarotLensScanResult.fromJson({
        ...json,
        'card': result.card.toJson(),
      });
      expect(reconstructed.card.name, card.name);
      expect(reconstructed.confidencePercent, 97);
      expect(reconstructed.isHighConfidence, true);
    });

    test('TarotLensService extracts esoteric symbols and ritual directions appropriately', () async {
      final service = TarotLensService();

      // Test Swords card (Air / East)
      final swordCard = TarotCardData.allCards.firstWhere((c) => c.id == 'swords_ace');
      final swordResult = await service.analyzeCard(preferredCard: swordCard);
      expect(swordResult.detectedSymbols, isNotEmpty);
      expect(swordResult.physicalAltarRitual, contains('Eastern Air Gate'));
      expect(swordResult.physicalAltarRitual, contains('White Sage'));

      // Test Pentacles card (Earth / North)
      final pentacleCard = TarotCardData.allCards.firstWhere((c) => c.id == 'pentacles_ace');
      final pentacleResult = await service.analyzeCard(preferredCard: pentacleCard);
      expect(pentacleResult.detectedSymbols, isNotEmpty);
      expect(pentacleResult.physicalAltarRitual, contains('Northern Earth Gate'));

      // Test Major Arcana (Center)
      final priestess = TarotCardData.allCards.firstWhere((c) => c.id == 'major_2_the_high_priestess');
      final priestessResult = await service.analyzeCard(preferredCard: priestess);
      expect(priestessResult.detectedSymbols, contains('Twin Pillars of Boaz & Jachin'));
      expect(priestessResult.physicalAltarRitual, contains('Center Altar Practice'));
    });

    test('TarotLensNotifier updates state on card selection and orientation toggle', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = container.read(tarotLensProvider);
      expect(initial.isScanning, false);
      expect(initial.scanResult, isNotNull);
      expect(initial.scanResult!.card.name, 'The Fool');

      // Select The Magician
      final magician = TarotCardData.allCards.firstWhere((c) => c.id == 'major_1_the_magician');
      await container.read(tarotLensProvider.notifier).selectCard(magician);

      final updated = container.read(tarotLensProvider);
      expect(updated.scanResult?.card.name, 'The Magician');
      expect(updated.scanResult?.isReversed, false);

      // Toggle orientation to reversed
      await container.read(tarotLensProvider.notifier).toggleOrientation();
      final reversedState = container.read(tarotLensProvider);
      expect(reversedState.scanResult?.isReversed, true);
    });

    testWidgets('TarotLensScreen renders Viewfinder, Action Buttons, and Scrying Sheet', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: TarotLensScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Screen Title
      expect(find.text('REAL-WORLD TAROT LENS'), findsOneWidget);

      // Verify Viewfinder Reticle & Description
      expect(find.text('ALIGN PHYSICAL TAROT CARD IN SENSOR RETICLE'), findsOneWidget);

      // Verify Camera and Gallery action buttons
      expect(find.text('CAPTURE PHOTO'), findsOneWidget);
      expect(find.text('FROM GALLERY'), findsOneWidget);

      // Verify Search Box and Card Name
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('THE FOOL'), findsOneWidget);

      // Verify Optical Match Badge
      expect(find.textContaining('OPTICAL MATCH'), findsWidgets);

      // Verify Anchor to Sacred Altar Table action button
      expect(find.text('ANCHOR TO SACRED ALTAR TABLE'), findsOneWidget);
    });
  });
}
