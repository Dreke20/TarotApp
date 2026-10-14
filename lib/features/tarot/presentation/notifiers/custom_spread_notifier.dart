import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/custom_spread.dart';

part 'custom_spread_notifier.g.dart';

@Riverpod(keepAlive: true)
class CustomSpreadNotifier extends _$CustomSpreadNotifier {
  @override
  List<CustomSpread> build() {
    _loadCustomSpreads();
    return _initialSpreads;
  }

  static const List<CustomSpread> _initialSpreads = [
    CustomSpread(
      id: 'shadow_work_4',
      title: 'Shadow Integration Spread',
      description: 'A 4-card inquiry into the unconscious persona, hidden defense mechanism, and the golden gift in the darkness.',
      positions: [
        'The Persona (Mask Shown to the World)',
        'The Shadow (Hidden Fears & Denials)',
        'The Catalyst (What Triggers the Eruption)',
        'The Integration (How to Reclaim the Power)',
      ],
      isUserCreated: false,
    ),
    CustomSpread(
      id: 'elemental_cross_5',
      title: 'Five Elements Alchemy',
      description: 'Consult Earth, Air, Fire, Water, and Spirit to restore sacred balance across all dimensions of life.',
      positions: [
        'Earth (Physical Foundation & Wealth)',
        'Air (Mental Clarity & Truth)',
        'Fire (Will, Passion & Creative Force)',
        'Water (Emotional Currents & Intuition)',
        'Spirit (Divine Purpose & Cosmic Guidance)',
      ],
      isUserCreated: false,
    ),
  ];

  Future<void> _loadCustomSpreads() async {
    final storage = ref.read(storageServiceProvider);
    final saved = await storage.loadCustomSpreads();
    if (saved.isNotEmpty) {
      state = [...saved, ..._initialSpreads.where((init) => !saved.any((s) => s.id == init.id))];
    }
  }

  Future<void> addCustomSpread({
    required String title,
    required String description,
    required List<String> positions,
  }) async {
    final storage = ref.read(storageServiceProvider);
    final spread = CustomSpread(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      title: title.trim().isEmpty ? 'Personal Sacred Spread' : title.trim(),
      description: description.trim(),
      positions: positions,
      isUserCreated: true,
    );

    final updated = [spread, ...state];
    state = updated;
    await storage.saveCustomSpreads(updated.where((s) => s.isUserCreated).toList());
  }

  Future<void> deleteCustomSpread(String id) async {
    final storage = ref.read(storageServiceProvider);
    final updated = state.where((s) => s.id != id).toList();
    state = updated;
    await storage.saveCustomSpreads(updated.where((s) => s.isUserCreated).toList());
  }
}
