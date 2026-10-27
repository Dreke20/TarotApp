import 'package:flutter/material.dart';
import 'package:tarot_app/features/astrology/synastry/domain/lunar_synastry.dart';

/// Interactive pod displaying and configuring a synastry partner's placements.
class SynastryPartnerPod extends StatelessWidget {
  final String podLabel;
  final SynastryPartner partner;
  final ValueChanged<DateTime> onBirthDateChanged;
  final ValueChanged<String> onSunSignChanged;
  final ValueChanged<String> onNameChanged;

  static const List<String> zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  const SynastryPartnerPod({
    super.key,
    required this.podLabel,
    required this.partner,
    required this.onBirthDateChanged,
    required this.onSunSignChanged,
    required this.onNameChanged,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: partner.birthDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD4AF37),
              onPrimary: Color(0xFF0F0C1B),
              surface: Color(0xFF1E1736),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onBirthDateChanged(picked);
    }
  }

  void _showSignPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF130E24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFFD4AF37), width: 0.8),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Zodiac Sun Sign',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    color: Color(0xFFD4AF37),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: zodiacSigns.map((sign) {
                    final bool isSelected = sign == partner.sunSign;
                    return InkWell(
                      onTap: () {
                        Navigator.of(bottomSheetContext).pop();
                        onSunSignChanged(sign);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD4AF37)
                              : const Color(0xFF1E1736),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFFFD700)
                                : const Color(0xFF33274E),
                          ),
                        ),
                        child: Text(
                          sign,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF0F0C1B) : Colors.white,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String dateString =
        '${partner.birthDate.year}-${partner.birthDate.month.toString().padLeft(2, '0')}-${partner.birthDate.day.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF171129),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.35), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Label & Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                podLabel.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                partner.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Date Picker Button
          InkWell(
            onTap: () => _pickDate(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF221A38),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF352952), width: 0.8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: Color(0xFFD4AF37), size: 14),
                  const SizedBox(width: 8),
                  Text(
                    dateString,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const Spacer(),
                  const Text('EDIT', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Sun Sign Selector
          InkWell(
            onTap: () => _showSignPicker(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF221A38),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF352952), width: 0.8),
              ),
              child: Row(
                children: [
                  const Text('☉', style: TextStyle(color: Color(0xFFFFD700), fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'Sun: ${partner.sunSign}',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Color(0xFFD4AF37), size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Moon & Rising badges
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C152E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF2E2248)),
                  ),
                  child: Row(
                    children: [
                      const Text('☽', style: TextStyle(color: Color(0xFF8AB4F8), fontSize: 12)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          partner.moonSign,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C152E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF2E2248)),
                  ),
                  child: Row(
                    children: [
                      const Text('🌅', style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          partner.risingSign,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Soul Card Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3), width: 0.6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎴', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                Text(
                  'Soul Card: ${partner.soulCardName}',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
