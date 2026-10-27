import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/audio_reflection.dart';

/// Service responsible for managing, persisting, and playing spoken audio reflections.
class AudioReflectionService {
  AudioReflectionService._();
  static final AudioReflectionService instance = AudioReflectionService._();

  static const String _prefReflectionsKey = 'oraculum_audio_reflections_map';

  /// Saves or updates a seeker's audio reflection for a specific reading.
  Future<void> saveReflection(AudioReflection reflection) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = await _getStoredMap(prefs);
      map[reflection.readingId] = reflection.toJson();
      await prefs.setString(_prefReflectionsKey, jsonEncode(map));
    } catch (_) {}
  }

  /// Retrieves the recorded audio reflection for a specific reading, if any exists.
  Future<AudioReflection?> getReflectionForReading(String readingId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = await _getStoredMap(prefs);
      final raw = map[readingId];
      if (raw != null) {
        return AudioReflection.fromJson(Map<String, dynamic>.from(raw as Map));
      }
    } catch (_) {}
    return null;
  }

  /// Deletes the audio reflection for a specific reading.
  Future<void> deleteReflection(String readingId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = await _getStoredMap(prefs);
      map.remove(readingId);
      await prefs.setString(_prefReflectionsKey, jsonEncode(map));
    } catch (_) {}
  }

  /// Generates organic rhythmic waveform amplitude samples (0.1 to 1.0) for visual playback.
  static List<double> generateWaveformSamples([int count = 24]) {
    final rand = Random();
    final samples = <double>[];
    for (int i = 0; i < count; i++) {
      // Natural speech envelope simulation
      final envelope = sin((i / (count - 1)) * pi);
      final jitter = rand.nextDouble() * 0.4 + 0.3;
      final amplitude = (envelope * jitter).clamp(0.15, 1.0);
      samples.add(double.parse(amplitude.toStringAsFixed(2)));
    }
    return samples;
  }

  Future<Map<String, dynamic>> _getStoredMap(SharedPreferences prefs) async {
    final rawStr = prefs.getString(_prefReflectionsKey);
    if (rawStr != null) {
      final decoded = jsonDecode(rawStr);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    }
    return <String, dynamic>{};
  }
}
