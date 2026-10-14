import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/jungian_symbol_data.dart';
import '../../domain/dream_entry.dart';

part 'dream_notifier.g.dart';

@Riverpod(keepAlive: true)
class DreamNotifier extends _$DreamNotifier {
  @override
  List<DreamEntry> build() {
    _loadDreams();
    return const [];
  }

  Future<void> _loadDreams() async {
    final storage = ref.read(storageServiceProvider);
    final saved = await storage.loadDreams();
    state = saved;
  }

  Future<void> addDream({
    required String title,
    required String narrative,
    required String mood,
    required List<String> symbolKeys,
  }) async {
    final storage = ref.read(storageServiceProvider);
    
    // Archetypal decoder logic
    String? correlatedCardId;
    String? correlatedCardName;
    String? archetypalMessage;
    String? jungianAnalysis;

    if (symbolKeys.isNotEmpty) {
      final primarySymbol = JungianArchetypes.findByKey(symbolKeys.first);
      correlatedCardId = primarySymbol.tarotCardId;
      correlatedCardName = primarySymbol.tarotCardName;
      archetypalMessage = primarySymbol.archetype;

      final symbolSummaries = symbolKeys.map((k) {
        final sym = JungianArchetypes.findByKey(k);
        return '• ${sym.name} (${sym.archetype}): ${sym.meaning}';
      }).join('\n');

      jungianAnalysis = 'Jungian Dream Synthesis ($mood mood):\n'
          'Your psyche is processing archetypal currents of "$archetypalMessage".\n\n'
          'Key Archetypal Anchors:\n$symbolSummaries\n\n'
          'Oracle Resonance: Correlates directly with the $correlatedCardName Arcana.';
    } else {
      jungianAnalysis = 'Dream recorded in state of $mood consciousness. Meditate on recurring motifs to unlock deeper Jungian symbols.';
    }

    final entry = DreamEntry(
      id: 'dream_${DateTime.now().millisecondsSinceEpoch}',
      recordedAt: DateTime.now(),
      title: title.trim().isEmpty ? 'Vision of the Midnight Veil' : title.trim(),
      narrative: narrative.trim(),
      mood: mood,
      symbols: symbolKeys,
      jungianAnalysis: jungianAnalysis,
      correlatedTarotCardId: correlatedCardId,
      correlatedTarotCardName: correlatedCardName,
      archetypalMessage: archetypalMessage,
    );

    final updated = [entry, ...state];
    state = updated;
    await storage.saveDreams(updated);
  }

  Future<void> deleteDream(String id) async {
    final storage = ref.read(storageServiceProvider);
    final updated = state.where((d) => d.id != id).toList();
    state = updated;
    await storage.saveDreams(updated);
  }
}
