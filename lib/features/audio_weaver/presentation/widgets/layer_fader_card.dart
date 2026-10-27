import 'package:flutter/material.dart';
import '../../domain/sound_layer.dart';

/// Card component for an individual soundscape layer with track selector,
/// fader slider, mute toggle, and vibrational frequency indicator.
class LayerFaderCard extends StatelessWidget {
  final SoundLayerCategory category;
  final SoundLayerTrack activeTrack;
  final List<SoundLayerTrack> availableTracks;
  final double volume;
  final bool isMuted;
  final ValueChanged<double> onVolumeChanged;
  final VoidCallback onToggleMute;
  final ValueChanged<SoundLayerTrack> onTrackSelected;

  const LayerFaderCard({
    super.key,
    required this.category,
    required this.activeTrack,
    required this.availableTracks,
    required this.volume,
    required this.isMuted,
    required this.onVolumeChanged,
    required this.onToggleMute,
    required this.onTrackSelected,
  });

  void _showTrackPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF13101E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFFD4AF37), width: 0.8),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(category.glyph, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Text(
                      'Select ${category.title}',
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ...availableTracks.map((track) {
                  final bool isSelected = track.id == activeTrack.id;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFD4AF37).withValues(alpha: 0.15)
                          : const Color(0xFF1E192E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFD4AF37)
                            : const Color(0xFF2C2442),
                        width: isSelected ? 1.2 : 0.8,
                      ),
                    ),
                    child: ListTile(
                      leading: Text(track.glyph, style: const TextStyle(fontSize: 24)),
                      title: Row(
                        children: [
                          Text(
                            track.title,
                            style: TextStyle(
                              color: isSelected ? const Color(0xFFFFD700) : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          if (track.hz != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                                  width: 0.6,
                                ),
                              ),
                              child: Text(
                                track.hz!,
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      subtitle: Text(
                        track.description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Color(0xFFD4AF37), size: 20)
                          : null,
                      onTap: () {
                        Navigator.of(bottomSheetContext).pop();
                        onTrackSelected(track);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int percent = (volume * 100).round();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF181326),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMuted
              ? Colors.white12
              : const Color(0xFFD4AF37).withValues(alpha: 0.35),
          width: 0.8,
        ),
        boxShadow: [
          if (!isMuted && volume > 0)
            BoxShadow(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Category & Mute Toggle
          Row(
            children: [
              Text(category.glyph, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.title.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: isMuted ? Colors.white30 : const Color(0xFFFFD700),
                  size: 20,
                ),
                tooltip: isMuted ? 'Unmute Layer' : 'Mute Layer',
                onPressed: onToggleMute,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Track Selector Pill
          InkWell(
            onTap: () => _showTrackPicker(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF221A36),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF382C54),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Text(activeTrack.glyph, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              activeTrack.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (activeTrack.hz != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  activeTrack.hz!,
                                  style: const TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          activeTrack.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Color(0xFFD4AF37),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Volume Slider & Percentage
          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: isMuted
                        ? Colors.white24
                        : const Color(0xFFD4AF37),
                    inactiveTrackColor: const Color(0xFF2E2448),
                    thumbColor: isMuted ? Colors.white38 : const Color(0xFFFFD700),
                    trackHeight: 3.5,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayColor: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                  ),
                  child: Slider(
                    value: isMuted ? 0.0 : volume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (val) {
                      if (isMuted) onToggleMute();
                      onVolumeChanged(val);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 38,
                child: Text(
                  isMuted ? 'MUTED' : '$percent%',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: isMuted ? Colors.white30 : const Color(0xFFD4AF37),
                    fontSize: isMuted ? 9 : 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
