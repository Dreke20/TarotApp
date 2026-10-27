import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_reflection.freezed.dart';
part 'audio_reflection.g.dart';

/// A seeker's spoken voice reflection attached to a tarot divination reading.
@freezed
abstract class AudioReflection with _$AudioReflection {
  const factory AudioReflection({
    required String id,
    required String readingId,
    required DateTime recordedAt,
    required int durationSeconds,
    required String transcription,
    @Default([]) List<double> waveformSamples,
  }) = _AudioReflection;

  factory AudioReflection.fromJson(Map<String, dynamic> json) =>
      _$AudioReflectionFromJson(json);
}
