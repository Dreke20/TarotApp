import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/audio_reflection_service.dart';
import '../../domain/audio_reflection.dart';
import 'glass_container.dart';

/// Interactive audio voice-note reflection recorder and player widget.
class SeekerVoiceNoteRecorder extends StatefulWidget {
  final String readingId;
  final VoidCallback? onSaved;

  const SeekerVoiceNoteRecorder({
    super.key,
    required this.readingId,
    this.onSaved,
  });

  @override
  State<SeekerVoiceNoteRecorder> createState() => _SeekerVoiceNoteRecorderState();
}

class _SeekerVoiceNoteRecorderState extends State<SeekerVoiceNoteRecorder>
    with SingleTickerProviderStateMixin {
  AudioReflection? _savedReflection;
  bool _isLoading = true;
  bool _isRecording = false;
  bool _isPlaying = false;
  int _recordSeconds = 0;
  Timer? _recordTimer;
  Timer? _playbackTimer;
  int _playbackSeconds = 0;
  late TextEditingController _transcriptController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _transcriptController = TextEditingController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _loadSavedReflection();
  }

  Future<void> _loadSavedReflection() async {
    final reflection = await AudioReflectionService.instance.getReflectionForReading(widget.readingId);
    if (mounted) {
      setState(() {
        _savedReflection = reflection;
        _isLoading = false;
        if (reflection != null) {
          _transcriptController.text = reflection.transcription;
        }
      });
    }
  }

  @override
  void dispose() {
    _recordTimer?.cancel();
    _playbackTimer?.cancel();
    _transcriptController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startRecording() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isRecording = true;
      _recordSeconds = 0;
    });
    _pulseController.repeat(reverse: true);
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _recordSeconds++;
        if (_recordSeconds >= 120) {
          _stopRecording();
        }
      });
    });
  }

  Future<void> _stopRecording() async {
    HapticFeedback.mediumImpact();
    _recordTimer?.cancel();
    _pulseController.stop();

    final samples = AudioReflectionService.generateWaveformSamples(28);
    final reflection = AudioReflection(
      id: 'refl_${widget.readingId}_${DateTime.now().millisecondsSinceEpoch}',
      readingId: widget.readingId,
      recordedAt: DateTime.now(),
      durationSeconds: _recordSeconds > 0 ? _recordSeconds : 1,
      transcription: _transcriptController.text.isNotEmpty
          ? _transcriptController.text
          : 'Spoken intention & prophecy reflection at the sacred altar.',
      waveformSamples: samples,
    );

    await AudioReflectionService.instance.saveReflection(reflection);
    if (mounted) {
      setState(() {
        _isRecording = false;
        _savedReflection = reflection;
      });
      widget.onSaved?.call();
    }
  }

  void _togglePlayback() {
    if (_savedReflection == null) return;
    HapticFeedback.lightImpact();

    if (_isPlaying) {
      _playbackTimer?.cancel();
      setState(() {
        _isPlaying = false;
        _playbackSeconds = 0;
      });
    } else {
      setState(() {
        _isPlaying = true;
        _playbackSeconds = 0;
      });
      final total = _savedReflection!.durationSeconds;
      _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        setState(() {
          _playbackSeconds++;
          if (_playbackSeconds >= total) {
            _playbackTimer?.cancel();
            _isPlaying = false;
            _playbackSeconds = 0;
          }
        });
      });
    }
  }

  Future<void> _deleteReflection() async {
    HapticFeedback.selectionClick();
    await AudioReflectionService.instance.deleteReflection(widget.readingId);
    if (mounted) {
      setState(() {
        _savedReflection = null;
        _transcriptController.clear();
        _isPlaying = false;
        _playbackSeconds = 0;
      });
      widget.onSaved?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(height: 40);
    }

    return GlassContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(14),
      borderColor: AppColors.goldBright.withValues(alpha: 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('🎙️', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  Text(
                    'SPOKEN VOICE REFLECTION',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              if (_savedReflection != null && !_isRecording)
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 16, color: Colors.white54),
                  tooltip: 'Delete reflection',
                  onPressed: _deleteReflection,
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Active Recording State
          if (_isRecording) ...[
            Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = 1.0 + 0.2 * _pulseController.value;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF4D4D),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  'RECORDING: 0:${_recordSeconds.toString().padLeft(2, '0')}',
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF758F),
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4D4D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  icon: const Icon(Icons.stop, size: 16),
                  label: const Text('SAVE NOTE'),
                  onPressed: _stopRecording,
                ),
              ],
            ),
          ]
          // Saved Reflection Playback State
          else if (_savedReflection != null) ...[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    size: 32,
                    color: AppColors.goldBright,
                  ),
                  onPressed: _togglePlayback,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Glowing Waveform Bars
                      _buildWaveformView(_savedReflection!.waveformSamples),
                      const SizedBox(height: 4),
                      Text(
                        '${_playbackSeconds}s / ${_savedReflection!.durationSeconds}s · Recorded ${_formatDate(_savedReflection!.recordedAt)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _savedReflection!.transcription,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ]
          // Empty State: Tap to Record
          else ...[
            Text(
              'Capture your spoken impressions, psychic revelations, and altar epiphanies.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _transcriptController,
              maxLines: 2,
              style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add an optional written reflection or intention...',
                hintStyle: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E1638),
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright.withValues(alpha: 0.15),
                  foregroundColor: AppColors.goldBright,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.goldBright, width: 1.2),
                  ),
                ),
                icon: const Icon(Icons.mic, size: 16),
                label: Text(
                  'RECORD SPOKEN REFLECTION',
                  style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                onPressed: _startRecording,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWaveformView(List<double> samples) {
    if (samples.isEmpty) return const SizedBox(height: 16);
    return SizedBox(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: samples.asMap().entries.map((entry) {
          final idx = entry.key;
          final val = entry.value;
          final total = _savedReflection?.durationSeconds ?? 1;
          final currentFraction = total > 0 ? (_playbackSeconds / total) : 0.0;
          final barFraction = idx / samples.length;
          final isPlayed = _isPlaying && barFraction <= currentFraction;

          return Container(
            width: 3.5,
            height: (val * 20).clamp(4.0, 20.0),
            decoration: BoxDecoration(
              color: isPlayed ? AppColors.goldBright : const Color(0xFF9B51E0).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(2),
              boxShadow: isPlayed
                  ? [
                      BoxShadow(
                        color: AppColors.goldBright.withValues(alpha: 0.6),
                        blurRadius: 4,
                      )
                    ]
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.month}/${dt.day} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
