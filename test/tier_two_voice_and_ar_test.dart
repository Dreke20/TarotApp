import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot_app/features/ar_altar/data/ar_pose_tracker.dart';
import 'package:tarot_app/features/ar_altar/domain/ar_altar_card.dart';
import 'package:tarot_app/features/ar_altar/presentation/notifiers/ar_altar_notifier.dart';
import 'package:tarot_app/features/ar_altar/presentation/notifiers/ar_altar_state.dart';
import 'package:tarot_app/features/ar_altar/presentation/widgets/ar_projected_altar.dart';
import 'package:tarot_app/features/oracle_dialogue/data/oracle_dialogue_service.dart';
import 'package:tarot_app/features/oracle_dialogue/domain/oracle_dialogue_message.dart';
import 'package:tarot_app/features/oracle_dialogue/domain/oracle_dialogue_reply.dart';
import 'package:tarot_app/features/oracle_dialogue/presentation/widgets/oracle_voice_orb.dart';
import 'package:tarot_app/features/tarot/domain/oracle_persona.dart';

OracleDialogueMessage _msg(DialogueSender s, String text) => OracleDialogueMessage(
      id: text,
      sender: s,
      text: text,
      timestamp: DateTime(2026),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  group('OracleDialogueService (Voice Oracle)', () {
    final OracleDialogueService service = OracleDialogueService(random: Random(7));

    test('draws a card on the first seeker turn', () {
      final List<OracleDialogueMessage> history = <OracleDialogueMessage>[
        _msg(DialogueSender.oracle, 'greeting'),
      ];
      expect(service.shouldDrawCard('Will I find peace?', history), isTrue);
    });

    test('does not draw on later turns unless asked', () {
      final List<OracleDialogueMessage> history = <OracleDialogueMessage>[
        _msg(DialogueSender.oracle, 'greeting'),
        _msg(DialogueSender.seeker, 'first question'),
        _msg(DialogueSender.oracle, 'answer'),
      ];
      expect(service.shouldDrawCard('Tell me more about that', history), isFalse);
      expect(service.shouldDrawCard('Can you pull another card?', history), isTrue);
    });

    test('drawCard avoids cards already in play', () {
      final Set<String> seen = <String>{};
      for (int i = 0; i < 40; i++) {
        final card = service.drawCard(excludeIds: seen);
        expect(seen.contains(card.id), isFalse);
        seen.add(card.id);
      }
    });

    test('consult falls back to a local persona reply when offline', () async {
      final OracleDialogueReply reply = await service.consult(
        prompt: 'What should I focus on this week?',
        history: <OracleDialogueMessage>[_msg(DialogueSender.oracle, 'greeting')],
        persona: OraclePersona.hermit,
      );
      expect(reply.isOfflineFallback, isTrue);
      expect(reply.drawnCard, isNotNull);
      expect(reply.text, contains(reply.drawnCard!.name));
      expect(reply.text, startsWith('Let us sit with this in stillness.'));
    });
  });

  group('ArPoseTracker (AR Altar anchoring)', () {
    test('integrates gyroscope rate into yaw and pitch', () async {
      final ArPoseTracker tracker = ArPoseTracker(gyroscope: const Stream<GyroscopeEvent>.empty());
      final List<ArPose> poses = <ArPose>[];
      final StreamSubscription<ArPose> sub = tracker.poses.listen(poses.add);
      final DateTime t0 = DateTime(2026);
      tracker.ingest(0, 0, t0);
      tracker.ingest(0.5, 1.0, t0.add(const Duration(milliseconds: 100)));
      await Future<void>.delayed(Duration.zero);
      expect(poses.last.yaw, closeTo(0.1, 1e-6));
      expect(poses.last.pitch, closeTo(0.05, 1e-6));
      await sub.cancel();
      await tracker.dispose();
    });

    test('clamps extreme rotation and ignores sensor stalls', () async {
      final ArPoseTracker tracker = ArPoseTracker(gyroscope: const Stream<GyroscopeEvent>.empty());
      ArPose? last;
      final StreamSubscription<ArPose> sub = tracker.poses.listen((ArPose p) => last = p);
      DateTime t = DateTime(2026);
      tracker.ingest(0, 0, t);
      for (int i = 0; i < 100; i++) {
        t = t.add(const Duration(milliseconds: 50));
        tracker.ingest(20, 20, t);
      }
      await Future<void>.delayed(Duration.zero);
      expect(last!.yaw, ArPoseTracker.maxYaw);
      expect(last!.pitch, ArPoseTracker.maxPitch);

      tracker.recenter();
      tracker.ingest(0, 0, t);
      tracker.ingest(5, 5, t.add(const Duration(seconds: 2))); // stall -> ignored
      await Future<void>.delayed(Duration.zero);
      expect(last!.yaw, 0);
      await sub.cancel();
      await tracker.dispose();
    });
  });

  group('ArAltarNotifier', () {
    ProviderContainer makeContainer() => ProviderContainer(overrides: [
          arPoseTrackerProvider.overrideWithValue(
            ArPoseTracker(gyroscope: const Stream<GyroscopeEvent>.empty()),
          ),
        ]);

    test('deals one unique card per spread position', () async {
      final ProviderContainer container = makeContainer();
      addTearDown(container.dispose);
      final ArAltarNotifier notifier = container.read(arAltarProvider.notifier);

      notifier.setSpread(ArSpread.cross);
      await notifier.dealSpread(interval: Duration.zero);
      final ArAltarState s = container.read(arAltarProvider);

      expect(s.isMandalaAnchored, isTrue);
      expect(s.cards.length, 5);
      expect(s.cards.map((ArAltarCard c) => c.card.id).toSet().length, 5);
      expect(s.cards.map((ArAltarCard c) => c.positionName).toList(), ArSpread.cross.positions);
      expect(s.cards.every((ArAltarCard c) => !c.isRevealed), isTrue);
    });

    test('tapping flips then selects; consult prompt lists revealed cards', () async {
      final ProviderContainer container = makeContainer();
      addTearDown(container.dispose);
      final ArAltarNotifier notifier = container.read(arAltarProvider.notifier);
      await notifier.dealSpread(interval: Duration.zero);

      final ArAltarCard first = container.read(arAltarProvider).cards.first;
      notifier.tapCard(first.id);
      ArAltarState s = container.read(arAltarProvider);
      expect(s.cards.first.isRevealed, isTrue);
      expect(s.selectedCard?.id, first.id);
      expect(s.allRevealed, isFalse);
      expect(notifier.consultationPrompt(), contains('Past: ${first.card.name}'));

      notifier.revealAll();
      s = container.read(arAltarProvider);
      expect(s.allRevealed, isTrue);

      notifier.clearAltar();
      expect(container.read(arAltarProvider).cards, isEmpty);
    });

    test('spread slot layouts match spread sizes', () {
      for (final ArSpread spread in ArSpread.values) {
        expect(arSlotOffsets(spread).length, spread.size);
      }
    });
  });

  testWidgets('OracleVoiceOrb exposes phase-aware semantics and taps', (WidgetTester tester) async {
    int taps = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OracleVoiceOrb(
          phase: DialogueState.listening,
          soundLevel: 0.6,
          accent: OraclePersona.empress.accentColor,
          onTap: () => taps++,
        ),
      ),
    ));
    expect(find.bySemanticsLabel('Listening. Tap to send.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('oracle_voice_orb')));
    expect(taps, 1);
  });
}
