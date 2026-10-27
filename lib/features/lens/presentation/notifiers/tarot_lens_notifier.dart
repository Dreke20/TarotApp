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
        confidencePercent: TarotLensService.manualSelectionConfidence,
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
    final path = await ref.read(tarotLensServiceProvider).captureFromCamera();
    await _scanPhoto(path);
  }

  Future<void> scanFromGallery() async {
    final path = await ref.read(tarotLensServiceProvider).selectFromGallery();
    await _scanPhoto(path);
  }

  /// Asks Gemini which card the photo shows. If it can't tell, the seeker
  /// is asked to pick the card from the list instead of being shown a guess.
  Future<void> _scanPhoto(String? path) async {
    if (path == null) return;
    state = state.copyWith(isScanning: true, errorMessage: null);
    final service = ref.read(tarotLensServiceProvider);
    final match = await service.identifyCard(path);

    final result = await service.analyzeCard(
      imagePath: path,
      preferredCard: match?.card ?? state.scanResult?.card,
      isReversed: match?.isReversed ?? state.scanResult?.isReversed ?? false,
      confidencePercent:
          match?.confidencePercent ?? TarotLensService.unrecognizedConfidence,
      visibleSymbols: match?.visibleSymbols ?? const [],
    );

    String? message;
    if (match == null) {
      message = "The Lens couldn't recognize this card. Choose it from the list below.";
    } else if (!result.isHighConfidence) {
      message = 'Not fully sure about this one. If it looks wrong, choose the right card below.';
    }

    state = state.copyWith(
      isScanning: false,
      capturedImagePath: path,
      scanResult: result,
      errorMessage: message,
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
      errorMessage: null,
    );
  }

  Future<void> toggleOrientation() async {
    if (state.scanResult == null) return;
    final current = state.scanResult!;
    final service = ref.read(tarotLensServiceProvider);
    final result = await service.analyzeCard(
      imagePath: state.capturedImagePath,
      preferredCard: current.card,
      isReversed: !current.isReversed,
      confidencePercent: current.confidencePercent,
    );
    state = state.copyWith(scanResult: result);
  }

  void clearCapturedImage() {
    state = state.copyWith(capturedImagePath: null);
  }
}
