import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../domain/synastry_partner.dart';

/// Modal dialog allowing seekers to calibrate their Cosmic Synastry & Relationship Mirror,
/// pairing their natal energy with their partner's zodiac sign, name, and sacred bond type.
class CosmicSynastryModal extends StatefulWidget {
  final SynastryPartner currentPartner;
  final String seekerSunSign;
  final Function(SynastryPartner) onPartnerSaved;

  const CosmicSynastryModal({
    super.key,
    required this.currentPartner,
    required this.seekerSunSign,
    required this.onPartnerSaved,
  });

  static Future<void> show(
    BuildContext context, {
    required SynastryPartner currentPartner,
    required String seekerSunSign,
    required Function(SynastryPartner) onPartnerSaved,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CosmicSynastryModal(
        currentPartner: currentPartner,
        seekerSunSign: seekerSunSign,
        onPartnerSaved: onPartnerSaved,
      ),
    );
  }

  @override
  State<CosmicSynastryModal> createState() => _CosmicSynastryModalState();
}

class _CosmicSynastryModalState extends State<CosmicSynastryModal> {
  late final TextEditingController _nameController;
  late String _selectedSunSign;
  late String _selectedConnectionType;

  static const List<Map<String, String>> _zodiacSigns = [
    {'name': 'Aries', 'symbol': '♈', 'element': 'Fire'},
    {'name': 'Taurus', 'symbol': '♉', 'element': 'Earth'},
    {'name': 'Gemini', 'symbol': '♊', 'element': 'Air'},
    {'name': 'Cancer', 'symbol': '♋', 'element': 'Water'},
    {'name': 'Leo', 'symbol': '♌', 'element': 'Fire'},
    {'name': 'Virgo', 'symbol': '♍', 'element': 'Earth'},
    {'name': 'Libra', 'symbol': '♎', 'element': 'Air'},
    {'name': 'Scorpio', 'symbol': '♏', 'element': 'Water'},
    {'name': 'Sagittarius', 'symbol': '♐', 'element': 'Fire'},
    {'name': 'Capricorn', 'symbol': '♑', 'element': 'Earth'},
    {'name': 'Aquarius', 'symbol': '♒', 'element': 'Air'},
    {'name': 'Pisces', 'symbol': '♓', 'element': 'Water'},
  ];

  static const List<String> _connectionTypes = [
    'Soulmate Bond',
    'Twin Flame',
    'Karmic Mirror',
    'Creative Alliance',
    'Healing Crucible',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentPartner.name);
    _selectedSunSign = widget.currentPartner.sunSign;
    _selectedConnectionType = widget.currentPartner.connectionType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _getElementForSign(String sign) {
    final match = _zodiacSigns.firstWhere(
      (z) => z['name']?.toLowerCase() == sign.toLowerCase(),
      orElse: () => {'element': 'Water'},
    );
    return match['element'] ?? 'Water';
  }

  String _calculateElementalHarmony(String seekerSign, String partnerSign) {
    final e1 = _getElementForSign(seekerSign);
    final e2 = _getElementForSign(partnerSign);

    final pair = {e1, e2};
    if (pair.contains('Water') && pair.contains('Earth')) {
      return '✦ Sacred Fertile Garden • Emotional Safety & Flourishing ✦';
    } else if (pair.contains('Fire') && pair.contains('Air')) {
      return '✦ Radiant Ignition • Passion & Lofty Vision Intertwined ✦';
    } else if (pair.contains('Water') && pair.contains('Water')) {
      return '✦ Mystic Ocean Deep • Telepathic Intuition & Soul Resonance ✦';
    } else if (pair.contains('Fire') && pair.contains('Fire')) {
      return '✦ Solar Crucible • Unstoppable Willpower & Dynamic Drive ✦';
    } else if (pair.contains('Air') && pair.contains('Air')) {
      return '✦ Astral Winds • Synchronized Thought & Boundless Liberty ✦';
    } else if (pair.contains('Earth') && pair.contains('Earth')) {
      return '✦ Ancient Mountain • Unshakable Devotion & Abundant Security ✦';
    } else if (pair.contains('Fire') && pair.contains('Water')) {
      return '✦ Steam Alchemy • Passion Transformed into Profound Healing ✦';
    } else if (pair.contains('Fire') && pair.contains('Earth')) {
      return '✦ Molten Forge • Grounding Bold Dreams into Tangible Reality ✦';
    } else if (pair.contains('Air') && pair.contains('Water')) {
      return '✦ Celestial Mist • Intellect Harmonizing Deep Emotions ✦';
    } else {
      return '✦ Architectural Symmetry • Lofty Ideals Structured into Form ✦';
    }
  }

  @override
  Widget build(BuildContext context) {
    final harmony = _calculateElementalHarmony(widget.seekerSunSign, _selectedSunSign);

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0B18),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: AppColors.goldBright, width: 1.5)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.goldMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('⚭', style: TextStyle(fontSize: 22, color: AppColors.goldBright)),
                    const SizedBox(width: 8),
                    Text(
                      'COSMIC SYNASTRY MIRROR',
                      style: GoogleFonts.cinzel(
                        color: AppColors.goldBright,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Elemental Harmony Callout
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF2A163E).withValues(alpha: 0.8),
                          const Color(0xFF130E22).withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.35)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'YOU (${widget.seekerSunSign.toUpperCase()})',
                              style: GoogleFonts.cinzel(
                                color: AppColors.goldBright,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('⚭', style: TextStyle(color: Colors.white70, fontSize: 16)),
                            ),
                            Text(
                              'THEM (${_selectedSunSign.toUpperCase()})',
                              style: GoogleFonts.cinzel(
                                color: AppColors.goldBright,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          harmony,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFFE5DCF2),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Partner Name Input
                  Text(
                    'COUNTERPART NAME OR MONIKER',
                    style: GoogleFonts.cinzel(
                      color: AppColors.goldBright,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: TextField(
                      controller: _nameController,
                      style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Elena, Beloved Soul, Twin Flame...',
                        hintStyle: GoogleFonts.plusJakartaSans(color: Colors.white30, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Partner Zodiac Sign Grid
                  Text(
                    'THEIR SOLAR ASTROLOGICAL SIGN',
                    style: GoogleFonts.cinzel(
                      color: AppColors.goldBright,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _zodiacSigns.map((zodiac) {
                      final name = zodiac['name']!;
                      final symbol = zodiac['symbol']!;
                      final isSelected = _selectedSunSign.toLowerCase() == name.toLowerCase();

                      return GestureDetector(
                        onTap: () {
                          SensoryService().cardSelectionHaptic();
                          setState(() => _selectedSunSign = name);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.goldBright : AppColors.glassFill,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.goldBright
                                  : AppColors.goldMuted.withValues(alpha: 0.35),
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                symbol,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected ? Colors.black : AppColors.goldBright,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                name,
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Relational Nexus Archetype
                  Text(
                    'SACRED CONNECTION DYNAMIC',
                    style: GoogleFonts.cinzel(
                      color: AppColors.goldBright,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _connectionTypes.map((type) {
                      final isSelected = _selectedConnectionType == type;
                      return GestureDetector(
                        onTap: () {
                          SensoryService().cardSelectionHaptic();
                          setState(() => _selectedConnectionType = type);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.etherealLavender.withValues(alpha: 0.25)
                                : AppColors.glassFill,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.etherealLavender
                                  : AppColors.glassBorder,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Text(
                            type,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright,
                  foregroundColor: AppColors.backgroundDeep,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 6,
                ),
                onPressed: () {
                  SensoryService().completionHaptic();
                  final partner = SynastryPartner(
                    name: _nameController.text.trim().isEmpty
                        ? 'Beloved Seeker'
                        : _nameController.text.trim(),
                    sunSign: _selectedSunSign,
                    connectionType: _selectedConnectionType,
                  );
                  widget.onPartnerSaved(partner);
                  Navigator.of(context).pop();
                },
                child: Text(
                  '✦ SEAL SACRED SYNASTRY ✦',
                  style: GoogleFonts.cinzel(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
