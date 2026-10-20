import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/tarot_lens_service.dart';
import '../../domain/tarot_lens_scan_result.dart';
import 'tarot_lens_state.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../../tarot/data/tarot_card_data.dart';

part 'tarot_lens_notifier.g.dart';

@riverpod
TarotLensService tarotLensService(Ref ref) {
  return TarotLensService();
}

@riverpod
class TarotLensNotifier extends _$TarotLensNotifier {
  @override
  TarotLensState build() {
    final defaultCard = TarotCardData.allCards.first;
    return TarotLensState(
      isScanning: false,
      scanResult: TarotLensScanResult(
        card: defaultCard,
        confidencePercent: 98,
        isReversed: false,
        detectedSymbols: const [
          'White Rose of Purity',
          'Feathered Cap',
          'Precipice Threshold',
          'Faithful White Dog'
        ],
        scryingAnalysis:
            'The Fool has entered your physical sanctum in its upright, radiant manifestation. In physical cartomancy, this card arriving upon your real-world altar signals: Innocent leap into the unknown, boundless potential, spontaneous faith. The ether surrounding you is aligning with the Air current. Take note of the room’s ambient light and the thoughts currently occupying your mind—they hold the golden key to this threshold.',
        physicalAltarRitual:
            'Center Altar Practice: Place The Fool in the sacred center of your altar cloth. Light a deep violet or white beeswax candle and burn sacred Golden Copal or Frankincense. Anchor the card’s four corners with Clear Quartz and Amethyst to integrate its archetypal initiation.',
        isHighConfidence: true,
      ),
    );
  }

  Future<void> scanFromCamera() async {
    state = state.copyWith(isScanning: true, errorMessage: null);
    final service = ref.read(tarotLensServiceProvider);
    final path = await service.captureFromCamera();
    if (path == null) {
      state = state.copyWith(isScanning: false);
      return;
    }

    final result = await service.analyzeCard(
      imagePath: path,
      preferredCard: state.scanResult?.card,
      isReversed: state.scanResult?.isReversed ?? false,
    );

    state = state.copyWith(
      isScanning: false,
      capturedImagePath: path,
      scanResult: result,
    );
  }

  Future<void> scanFromGallery() async {
    state = state.copyWith(isScanning: true, errorMessage: null);
    final service = ref.read(tarotLensServiceProvider);
    final path = await service.selectFromGallery();
    if (path == null) {
      state = state.copyWith(isScanning: false);
      return;
    }

    final result = await service.analyzeCard(
      imagePath: path,
      preferredCard: state.scanResult?.card,
      isReversed: state.scanResult?.isReversed ?? false,
    );

    state = state.copyWith(
      isScanning: false,
      capturedImagePath: path,
      scanResult: result,
    );
  }

  Future<void> selectCard(TarotCard card, {bool? isReversed}) async {
    state = state.copyWith(isScanning: true);
    final service = ref.read(tarotLensServiceProvider);
    final reversed = isReversed ?? state.scanResult?.isReversed ?? false;
    final result = await service.analyzeCard(
      imagePath: state.capturedImagePath,
      preferredCard: card,
      isReversed: reversed,
    );

    state = state.copyWith(
      isScanning: false,
      scanResult: result,
    );
  }

  Future<void> toggleOrientation() async {
    if (state.scanResult == null) return;
    final current = state.scanResult!;
    await selectCard(current.card, isReversed: !current.isReversed);
  }

  void clearCapturedImage() {
    state = state.copyWith(capturedImagePath: null);
  }
}
