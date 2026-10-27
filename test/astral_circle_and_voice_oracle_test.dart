import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarot_app/features/astral_circle/domain/astral_circle_session.dart';
import 'package:tarot_app/features/astral_circle/data/astral_circle_service.dart';
import 'package:tarot_app/features/astral_circle/presentation/widgets/astral_circle_banner.dart';
import 'package:tarot_app/features/astral_circle/presentation/notifiers/astral_circle_notifier.dart';
import 'package:tarot_app/features/voice_oracle/domain/hands_free_voice_state.dart';
import 'package:tarot_app/features/voice_oracle/presentation/widgets/hands_free_communion_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AstralCircle Domain & Service Tests', () {
    test('generateRoomCode produces valid prefix and number format', () {
      final code = AstralCircleService.generateRoomCode();
      expect(code, matches(r'^[A-Z]+-\d{3}$'));
    });

    test('AstralCircleSession serialization and deserialization', () {
      final now = DateTime.now();
      final placement = AstralCardPlacement(
        cardId: 'the_fool',
        positionIndex: 0,
        placedBy: AstralParticipantRole.host,
        placedByName: 'Aura Weaver',
        timestamp: now,
      );

      final session = AstralCircleSession(
        id: 'sess-001',
        roomCode: 'SOL-777',
        hostId: 'user-001',
        hostName: 'Aura Weaver',
        guestId: 'user-002',
        guestName: 'Starlight Seeker',
        status: AstralCircleStatus.active,
        spreadType: 'threeCard',
        drawnCards: [placement],
        createdAt: now,
      );

      final json = session.toJson();
      expect(json['roomCode'], 'SOL-777');
      expect(json['status'], 'active');
      expect((json['drawnCards'] as List).length, 1);

      final jsonPayload = Map<String, dynamic>.from(json);
      jsonPayload['drawnCards'] = session.drawnCards.map((c) => c.toJson()).toList();
      final restored = AstralCircleSession.fromJson(jsonPayload);
      expect(restored.roomCode, session.roomCode);
      expect(restored.hostName, 'Aura Weaver');
      expect(restored.drawnCards.first.cardId, 'the_fool');
      expect(restored.drawnCards.first.placedByName, 'Aura Weaver');
    });

    test('AstralCardPlacement defaults isReversed to false', () {
      final placement = AstralCardPlacement(
        cardId: 'the_magician',
        positionIndex: 1,
        placedBy: AstralParticipantRole.guest,
        placedByName: 'Starlight Seeker',
        timestamp: DateTime.now(),
      );
      expect(placement.isReversed, false);
    });
  });

  group('HandsFreeVoiceState Domain Tests', () {
    test('Default HandsFreeVoiceState properties', () {
      const state = HandsFreeVoiceState();
      expect(state.handsFreeEnabled, true);
      expect(state.isListening, false);
      expect(state.currentTranscript, isEmpty);
      expect(state.lastFinalizedInquiry, isNull);
      expect(state.soundLevel, 0.0);
      expect(state.duckingLevel, 1.0);
    });

    test('HandsFreeVoiceState copyWith updates cleanly', () {
      const state = HandsFreeVoiceState();
      final updated = state.copyWith(
        isListening: true,
        currentTranscript: 'What is my divine path?',
        duckingLevel: 0.15,
        soundLevel: 4.5,
      );

      expect(updated.isListening, true);
      expect(updated.currentTranscript, 'What is my divine path?');
      expect(updated.duckingLevel, 0.15);
      expect(updated.soundLevel, 4.5);
    });
  });

  group('AstralCircle & Voice Oracle Widget Tests', () {
    testWidgets('AstralCircleBanner renders when circle is active', (tester) async {
      final session = AstralCircleSession(
        id: 'sess-banner',
        roomCode: 'LUN-314',
        hostId: 'host-1',
        hostName: 'High Priestess',
        guestId: 'guest-2',
        guestName: 'Wandering Sage',
        status: AstralCircleStatus.active,
        spreadType: 'threeCard',
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            astralCircleNotifierProvider.overrideWith(() => _MockAstralCircleNotifier(session)),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: AstralCircleBanner(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('ASTRAL CIRCLE'), findsOneWidget);
      expect(find.text('LUN-314'), findsOneWidget);
    });

    testWidgets('HandsFreeCommunionModal renders invocation title and prompts', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: HandsFreeCommunionModal(),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('VOICE ORACLE'), findsOneWidget);
      expect(find.text('ORACULAR INSPIRATIONS'), findsOneWidget);
      expect(find.text('What energy surrounds my path today?'), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsOneWidget);
    });
  });
}

class _MockAstralCircleNotifier extends AstralCircleNotifier {
  final AstralCircleSession? _mockSession;
  _MockAstralCircleNotifier(this._mockSession);

  @override
  AsyncValue<AstralCircleSession?> build() => AsyncValue.data(_mockSession);
}
