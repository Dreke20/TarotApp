/// Sacred shuffling styles and physical deck manipulation methods.
enum ShuffleStyle {
  riffleBridge(
    id: 'riffle_bridge',
    title: 'Sacred Riffle & Bridge',
    subtitle: '3D split, interlacing card cascade & parabolic bridge snap',
    glyph: '🎴',
    durationMs: 2400,
  ),
  celticScatter(
    id: 'celtic_scatter',
    title: 'Celtic Altar Chaos Wash',
    subtitle: '78 cards swirling in an elemental vortex on consecrated cloth',
    glyph: '🌀',
    durationMs: 3000,
  ),
  threePilesCut(
    id: 'three_piles_cut',
    title: 'Three Fates Tri-Fold Cut',
    subtitle: 'Past, Present & Future consecrated piles restacked by your intuition',
    glyph: '⚖️',
    durationMs: 2000,
  );

  final String id;
  final String title;
  final String subtitle;
  final String glyph;
  final int durationMs;

  const ShuffleStyle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.glyph,
    required this.durationMs,
  });
}

/// Statistics and entropy metrics captured during a physical shuffle session.
class ShuffleSessionMetrics {
  final ShuffleStyle style;
  final int passesCompleted;
  final double entropyScore; // 0.0 to 1.0
  final DateTime timestamp;

  const ShuffleSessionMetrics({
    required this.style,
    required this.passesCompleted,
    required this.entropyScore,
    required this.timestamp,
  });
}
