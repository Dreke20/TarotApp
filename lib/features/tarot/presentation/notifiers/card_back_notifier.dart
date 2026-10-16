import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/card_back_design.dart';

part 'card_back_notifier.g.dart';

@Riverpod(keepAlive: true)
class CardBackNotifier extends _$CardBackNotifier {
  static const String _storageKey = 'consecrated_card_back_id';

  @override
  CardBackDesign build() {
    _loadPersistedDesign();
    return CardBackDesign.eyeOfProvidence;
  }

  Future<void> _loadPersistedDesign() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_storageKey);
      if (id != null) {
        state = CardBackDesign.fromId(id);
      }
    } catch (_) {
      // Keep default
    }
  }

  Future<void> selectDesign(CardBackDesign design) async {
    state = design;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, design.id);
    } catch (_) {}
  }
}
