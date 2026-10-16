import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/oracle_persona.dart';

part 'oracle_persona_notifier.g.dart';

const String _prefPersonaKey = 'oraculum_active_persona';

@Riverpod(keepAlive: true)
class OraclePersonaNotifier extends _$OraclePersonaNotifier {
  @override
  OraclePersona build() {
    _loadPersistedPersona();
    return OraclePersona.highPriestess;
  }

  Future<void> _loadPersistedPersona() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_prefPersonaKey);
      if (id != null) {
        state = OraclePersona.fromId(id);
      }
    } catch (_) {}
  }

  Future<void> selectPersona(OraclePersona persona) async {
    state = persona;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefPersonaKey, persona.id);
    } catch (_) {}
  }
}

/// Compatibility alias for oraclePersonaProvider
final oraclePersonaNotifierProvider = oraclePersonaProvider;
