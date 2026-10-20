import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/tarot_lens_scan_result.dart';

part 'tarot_lens_state.freezed.dart';

@freezed
abstract class TarotLensState with _$TarotLensState {
  const factory TarotLensState({
    @Default(false) bool isScanning,
    String? capturedImagePath,
    TarotLensScanResult? scanResult,
    String? errorMessage,
  }) = _TarotLensState;
}
