import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tarot_app/features/astrology/synastry/data/synastry_calculator.dart';
import 'package:tarot_app/features/astrology/synastry/data/synastry_service.dart';
import 'package:tarot_app/features/astrology/synastry/domain/lunar_synastry.dart';

part 'synastry_notifier.g.dart';

class SynastryState {
  final SynastryPartner partnerA;
  final SynastryPartner partnerB;
  final LunarSynastryReading? reading;
  final bool isScrying;

  const SynastryState({
    required this.partnerA,
    required this.partnerB,
    this.reading,
    this.isScrying = false,
  });

  SynastryState copyWith({
    SynastryPartner? partnerA,
    SynastryPartner? partnerB,
    LunarSynastryReading? reading,
    bool clearReading = false,
    bool? isScrying,
  }) {
    return SynastryState(
      partnerA: partnerA ?? this.partnerA,
      partnerB: partnerB ?? this.partnerB,
      reading: clearReading ? null : (reading ?? this.reading),
      isScrying: isScrying ?? this.isScrying,
    );
  }
}

@Riverpod(keepAlive: true)
class SynastryNotifier extends _$SynastryNotifier {
  final SynastryService _service = const SynastryService();

  @override
  SynastryState build() {
    final SynastryPartner initialA = SynastryCalculator.createPartner(
      name: 'Seeker',
      birthDate: DateTime(1996, 8, 8),
      sunSignOverride: 'Leo',
      moonSignOverride: 'Aries',
    );

    final SynastryPartner initialB = SynastryCalculator.createPartner(
      name: 'Beloved',
      birthDate: DateTime(1998, 12, 12),
      sunSignOverride: 'Sagittarius',
      moonSignOverride: 'Leo',
    );

    // Initial default scry
    final initialReading = _service.scryConnection(
      partnerA: initialA,
      partnerB: initialB,
    );

    return SynastryState(
      partnerA: initialA,
      partnerB: initialB,
      reading: initialReading,
    );
  }

  void updatePartnerA({
    String? name,
    DateTime? birthDate,
    String? sunSign,
  }) {
    final updated = SynastryCalculator.createPartner(
      name: name ?? state.partnerA.name,
      birthDate: birthDate ?? state.partnerA.birthDate,
      sunSignOverride: sunSign ?? state.partnerA.sunSign,
    );
    state = state.copyWith(partnerA: updated);
    scry();
  }

  void updatePartnerB({
    String? name,
    DateTime? birthDate,
    String? sunSign,
  }) {
    final updated = SynastryCalculator.createPartner(
      name: name ?? state.partnerB.name,
      birthDate: birthDate ?? state.partnerB.birthDate,
      sunSignOverride: sunSign ?? state.partnerB.sunSign,
    );
    state = state.copyWith(partnerB: updated);
    scry();
  }

  void applyPreset(SynastryPreset preset) {
    state = state.copyWith(
      partnerA: preset.partnerA,
      partnerB: preset.partnerB,
    );
    scry();
  }

  void scry() {
    state = state.copyWith(isScrying: true);
    final reading = _service.scryConnection(
      partnerA: state.partnerA,
      partnerB: state.partnerB,
    );
    state = state.copyWith(reading: reading, isScrying: false);
  }
}
