import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/astral_circle_session.dart';

/// Real-time service managing shared Astral Circle rooms and card synchronization.
class AstralCircleService {
  final SupabaseClient? _supabase;
  RealtimeChannel? _activeChannel;
  final _sessionController = StreamController<AstralCircleSession?>.broadcast();

  AstralCircleSession? _currentSession;

  AstralCircleService([this._supabase]);

  Stream<AstralCircleSession?> get sessionStream => _sessionController.stream;
  AstralCircleSession? get currentSession => _currentSession;

  static const List<String> _celestialPrefixes = [
    'SOL',
    'LUNA',
    'ORAC',
    'VEGA',
    'NOVA',
    'AURA',
    'ZENITH',
    'ALTAIR',
  ];

  /// Generates a sacred 6-character room code (e.g., SOL-742).
  static String generateRoomCode() {
    final rand = Random();
    final prefix = _celestialPrefixes[rand.nextInt(_celestialPrefixes.length)];
    final number = 100 + rand.nextInt(900);
    return '$prefix-$number';
  }

  /// Hosts a new Sacred Circle room.
  Future<AstralCircleSession> createRoom({
    required String hostName,
    String spreadType = 'threeCard',
  }) async {
    await leaveRoom();

    final roomCode = generateRoomCode();
    final hostId = _supabase?.auth.currentUser?.id ?? 'host_${DateTime.now().millisecondsSinceEpoch}';

    final session = AstralCircleSession(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      roomCode: roomCode,
      hostId: hostId,
      hostName: hostName.trim().isEmpty ? 'Celestial Seeker' : hostName.trim(),
      spreadType: spreadType,
      drawnCards: const [],
      activeTurn: AstralParticipantRole.host,
      status: AstralCircleStatus.waiting,
      createdAt: DateTime.now(),
    );

    _currentSession = session;
    _sessionController.add(_currentSession);

    _setupRealtimeChannel(roomCode, isHost: true);
    return session;
  }

  /// Joins an existing Sacred Circle via room code.
  Future<AstralCircleSession> joinRoom({
    required String roomCode,
    required String guestName,
  }) async {
    await leaveRoom();

    final normalizedCode = roomCode.trim().toUpperCase();
    final guestId = _supabase?.auth.currentUser?.id ?? 'guest_${DateTime.now().millisecondsSinceEpoch}';
    final sanitizedGuestName = guestName.trim().isEmpty ? 'Astral Pilgrim' : guestName.trim();

    final session = AstralCircleSession(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      roomCode: normalizedCode,
      hostId: 'host_peer',
      hostName: 'Circle Host',
      guestId: guestId,
      guestName: sanitizedGuestName,
      drawnCards: const [],
      activeTurn: AstralParticipantRole.host,
      status: AstralCircleStatus.active,
      createdAt: DateTime.now(),
    );

    _currentSession = session;
    _sessionController.add(_currentSession);

    _setupRealtimeChannel(normalizedCode, isHost: false);

    // Broadcast guest join notice to host
    _activeChannel?.sendBroadcastMessage(
      event: 'guest_joined',
      payload: {
        'guestId': guestId,
        'guestName': sanitizedGuestName,
      },
    );

    return session;
  }

  /// Connects to Supabase Realtime broadcast channel.
  void _setupRealtimeChannel(String roomCode, {required bool isHost}) {
    final client = _supabase;
    if (client == null) return;

    final channelName = 'astral_circle_$roomCode';
    _activeChannel = client.channel(channelName);

    _activeChannel?.onBroadcast(
      event: 'guest_joined',
      callback: (payload) {
        if (_currentSession == null) return;
        final guestId = payload['guestId'] as String? ?? 'guest';
        final guestName = payload['guestName'] as String? ?? 'Astral Pilgrim';

        _currentSession = _currentSession!.copyWith(
          guestId: guestId,
          guestName: guestName,
          status: AstralCircleStatus.active,
        );
        _sessionController.add(_currentSession);

        if (isHost) {
          // Sync current session state back to newly arrived guest
          _activeChannel?.sendBroadcastMessage(
            event: 'sync_state',
            payload: _currentSession!.toJson(),
          );
        }
      },
    );

    _activeChannel?.onBroadcast(
      event: 'sync_state',
      callback: (payload) {
        try {
          final synced = AstralCircleSession.fromJson(payload);
          _currentSession = synced;
          _sessionController.add(_currentSession);
        } catch (e) {
          debugPrint('[AstralCircleService] Error parsing sync_state: $e');
        }
      },
    );

    _activeChannel?.onBroadcast(
      event: 'card_drawn',
      callback: (payload) {
        try {
          final placement = AstralCardPlacement.fromJson(payload);
          if (_currentSession == null) return;

          final updatedCards = List<AstralCardPlacement>.from(_currentSession!.drawnCards)..add(placement);
          final nextTurn = _currentSession!.activeTurn == AstralParticipantRole.host
              ? AstralParticipantRole.guest
              : AstralParticipantRole.host;

          _currentSession = _currentSession!.copyWith(
            drawnCards: updatedCards,
            activeTurn: nextTurn,
          );
          _sessionController.add(_currentSession);
        } catch (e) {
          debugPrint('[AstralCircleService] Error parsing card_drawn: $e');
        }
      },
    );

    _activeChannel?.onBroadcast(
      event: 'oracle_synthesized',
      callback: (payload) {
        final synthesis = payload['synthesis'] as String?;
        if (_currentSession != null && synthesis != null) {
          _currentSession = _currentSession!.copyWith(
            oracleSynthesis: synthesis,
            status: AstralCircleStatus.completed,
          );
          _sessionController.add(_currentSession);
        }
      },
    );

    _activeChannel?.subscribe();
  }

  /// Broadcasts a card draw to all circle participants.
  Future<void> drawCard({
    required String cardId,
    required int positionIndex,
    required bool isReversed,
    required AstralParticipantRole role,
    required String name,
  }) async {
    final placement = AstralCardPlacement(
      cardId: cardId,
      positionIndex: positionIndex,
      isReversed: isReversed,
      placedBy: role,
      placedByName: name,
      timestamp: DateTime.now(),
    );

    if (_currentSession != null) {
      final updatedCards = List<AstralCardPlacement>.from(_currentSession!.drawnCards)..add(placement);
      final nextTurn = role == AstralParticipantRole.host
          ? AstralParticipantRole.guest
          : AstralParticipantRole.host;

      _currentSession = _currentSession!.copyWith(
        drawnCards: updatedCards,
        activeTurn: nextTurn,
      );
      _sessionController.add(_currentSession);
    }

    await _activeChannel?.sendBroadcastMessage(
      event: 'card_drawn',
      payload: placement.toJson(),
    );
  }

  /// Broadcasts shared oracle synthesis to the circle.
  Future<void> broadcastSynthesis(String synthesis) async {
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(
        oracleSynthesis: synthesis,
        status: AstralCircleStatus.completed,
      );
      _sessionController.add(_currentSession);
    }

    await _activeChannel?.sendBroadcastMessage(
      event: 'oracle_synthesized',
      payload: {'synthesis': synthesis},
    );
  }

  /// Leaves and disbands the active circle.
  Future<void> leaveRoom() async {
    if (_activeChannel != null) {
      await _activeChannel?.sendBroadcastMessage(
        event: 'session_closed',
        payload: {},
      );
      await _supabase?.removeChannel(_activeChannel!);
      _activeChannel = null;
    }
    _currentSession = null;
    _sessionController.add(null);
  }

  void dispose() {
    leaveRoom();
    _sessionController.close();
  }
}
