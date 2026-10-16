import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/altar_cloth.dart';

part 'altar_cloth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AltarClothNotifier extends _$AltarClothNotifier {
  static const String _storageKey = 'consecrated_altar_cloth_id';

  @override
  AltarCloth build() {
    _loadPersistedCloth();
    return AltarCloth.midnightObsidian;
  }

  Future<void> _loadPersistedCloth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_storageKey);
      if (id != null) {
        state = AltarCloth.fromId(id);
      }
    } catch (_) {
      // Keep default
    }
  }

  Future<void> selectCloth(AltarCloth cloth) async {
    state = cloth;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, cloth.id);
    } catch (_) {}
  }
}
