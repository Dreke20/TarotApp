import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/card_deck_style.dart';

part 'deck_style_notifier.g.dart';

@Riverpod(keepAlive: true)
class DeckStyleNotifier extends _$DeckStyleNotifier {
  static const String _storageKey = 'consecrated_deck_style_id';

  @override
  CardDeckStyle build() {
    _loadPersistedStyle();
    return CardDeckStyle.whispersAndWarnings;
  }

  Future<void> _loadPersistedStyle() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString(_storageKey);
      if (id != null) {
        state = CardDeckStyle.fromId(id);
      }
    } catch (_) {
      // Keep default
    }
  }

  Future<void> selectStyle(CardDeckStyle style) async {
    state = style;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, style.id);
    } catch (_) {}
  }
}
