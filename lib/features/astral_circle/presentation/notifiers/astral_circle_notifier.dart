import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/supabase/supabase_client.dart';
import '../../data/astral_circle_service.dart';
import '../../domain/astral_circle_session.dart';

part 'astral_circle_notifier.g.dart';

@riverpod
AstralCircleService astralCircleService(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final service = AstralCircleService(supabase);
  ref.onDispose(() => service.dispose());
  return service;
}

@riverpod
class AstralCircleNotifier extends _$AstralCircleNotifier {
  StreamSubscription<AstralCircleSession?>? _sub;
  AstralParticipantRole _myRole = AstralParticipantRole.host;
  String _myName = 'Seeker';

  AstralParticipantRole get myRole => _myRole;
  String get myName => _myName;

  @override
  AsyncValue<AstralCircleSession?> build() {
    final service = ref.watch(astralCircleServiceProvider);

    _sub?.cancel();
    _sub = service.sessionStream.listen((session) {
      state = AsyncValue.data(session);
    });

    ref.onDispose(() {
      _sub?.cancel();
    });

    return AsyncValue.data(service.currentSession);
  }

  /// Hosts a new Astral Circle.
  Future<void> createRoom({required String hostName, String spreadType = 'threeCard'}) async {
    state = const AsyncValue.loading();
    _myRole = AstralParticipantRole.host;
    _myName = hostName.trim().isEmpty ? 'Circle Host' : hostName.trim();

    try {
      final service = ref.read(astralCircleServiceProvider);
      final session = await service.createRoom(hostName: _myName, spreadType: spreadType);
      state = AsyncValue.data(session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Joins an existing Astral Circle with a room code.
  Future<void> joinRoom({required String roomCode, required String guestName}) async {
    state = const AsyncValue.loading();
    _myRole = AstralParticipantRole.guest;
    _myName = guestName.trim().isEmpty ? 'Astral Guest' : guestName.trim();

    try {
      final service = ref.read(astralCircleServiceProvider);
      final session = await service.joinRoom(roomCode: roomCode, guestName: _myName);
      state = AsyncValue.data(session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Draws a card and synchronizes it across all participants.
  Future<void> drawCard({
    required String cardId,
    required int positionIndex,
    required bool isReversed,
  }) async {
    final service = ref.read(astralCircleServiceProvider);
    await service.drawCard(
      cardId: cardId,
      positionIndex: positionIndex,
      isReversed: isReversed,
      role: _myRole,
      name: _myName,
    );
  }

  /// Broadcasts oracle synthesis.
  Future<void> broadcastSynthesis(String synthesis) async {
    final service = ref.read(astralCircleServiceProvider);
    await service.broadcastSynthesis(synthesis);
  }

  /// Leaves the current circle room.
  Future<void> leaveRoom() async {
    final service = ref.read(astralCircleServiceProvider);
    await service.leaveRoom();
    state = const AsyncValue.data(null);
  }

  /// Whether it is this participant's turn to draw.
  bool get canDraw {
    final session = state.value;
    if (session == null || session.status != AstralCircleStatus.active) return false;
    return session.activeTurn == _myRole;
  }
}

/// Backward/convenience alias for astralCircleProvider
final astralCircleNotifierProvider = astralCircleProvider;
