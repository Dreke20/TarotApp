import 'package:flutter/material.dart';
import 'package:tarot_app/features/astrology/synastry/domain/lunar_synastry.dart';

/// Card visualizing the elemental confluence between two soul charts.
class ElementalMatrixView extends StatelessWidget {
  final LunarSynastryReading reading;

  const ElementalMatrixView({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    final String elemA = reading.partnerA.dominantElement;
    final String elemB = reading.partnerB.dominantElement;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161026),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('⚖️', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  reading.elementalConfluence.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Cinzel',
                    color: Color(0xFFD4AF37),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(reading.elementalBalancePercent * 100).round()}% ALCHEMY',
                  style: const TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Two Partner Elemental Pills
          Row(
            children: [
              Expanded(
                child: _buildElementPill(reading.partnerA.name, elemA),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('✦', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16)),
              ),
              Expanded(
                child: _buildElementPill(reading.partnerB.name, elemB),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dynamic Narrative Description
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1634),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF332654), width: 0.6),
            ),
            child: Text(
              reading.elementalDynamic,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                height: 1.45,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElementPill(String name, String element) {
    final (Color color, String glyph) = _elementMeta(element);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(glyph, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
                Text(
                  element,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _elementMeta(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return (const Color(0xFFFF6B6B), '🔥');
      case 'water':
        return (const Color(0xFF4EE2EC), '🌊');
      case 'earth':
        return (const Color(0xFF50C878), '🌍');
      case 'air':
      default:
        return (const Color(0xFFFFD166), '💨');
    }
  }
}
