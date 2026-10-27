import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tarot_app/core/constants/app_colors.dart';
import 'package:tarot_app/features/tarot/domain/spread_type.dart';
import 'package:tarot_app/features/tarot/domain/synastry_partner.dart' as tarot_sp;
import 'package:tarot_app/features/tarot/presentation/notifiers/reading_notifier.dart';
import 'package:tarot_app/features/astrology/synastry/data/synastry_service.dart';
import 'package:tarot_app/features/astrology/synastry/domain/lunar_synastry.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/notifiers/synastry_notifier.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/elemental_matrix_view.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_aspect_card.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_harmony_gauge.dart';
import 'package:tarot_app/features/astrology/synastry/presentation/widgets/synastry_partner_pod.dart';

/// Screen for celestial synastry, lunar compatibility, and dual-chart scrying.
class LunarSynastryScreen extends ConsumerWidget {
  const LunarSynastryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final synastryState = ref.watch(synastryProvider);
    final notifier = ref.read(synastryProvider.notifier);
    final LunarSynastryReading? reading = synastryState.reading;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0A17),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'LUNAR SYNASTRY',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.goldBright,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.4,
            colors: [
              const Color(0xFF241A3B),
              const Color(0xFF0D0A17),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Presets Bar
              _buildPresetsBar(synastryState, notifier),
              const SizedBox(height: 16),

              // Dual Partner Pods
              SynastryPartnerPod(
                podLabel: 'Partner A (Seeker)',
                partner: synastryState.partnerA,
                onBirthDateChanged: (d) => notifier.updatePartnerA(birthDate: d),
                onSunSignChanged: (s) => notifier.updatePartnerA(sunSign: s),
                onNameChanged: (n) => notifier.updatePartnerA(name: n),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    '∞',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SynastryPartnerPod(
                podLabel: 'Partner B (Beloved / Companion)',
                partner: synastryState.partnerB,
                onBirthDateChanged: (d) => notifier.updatePartnerB(birthDate: d),
                onSunSignChanged: (s) => notifier.updatePartnerB(sunSign: s),
                onNameChanged: (n) => notifier.updatePartnerB(name: n),
              ),
              const SizedBox(height: 18),

              // Scry Button
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  notifier.scry();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: const Color(0xFF0F0C1B),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.auto_awesome, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'SCRY CELESTIAL SYNASTRY',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Reading Content
              if (reading != null) ...[
                // Harmony Gauge
                SynastryHarmonyGauge(
                  score: reading.compatibilityScore,
                  bondTitle: reading.bondTitle,
                  relationshipArchetype: reading.relationshipArchetype,
                ),
                const SizedBox(height: 18),

                // Elemental Confluence Matrix
                ElementalMatrixView(reading: reading),
                const SizedBox(height: 18),

                // Moon Phase Synergy Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF19132A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF8AB4F8).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('🌙', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Text(
                            'LUNAR PHASE & SUBMITTED PASSAGES',
                            style: TextStyle(
                              fontFamily: 'Cinzel',
                              color: Color(0xFF8AB4F8),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        reading.moonPhaseSynergy,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Planetary Aspects Section
                Row(
                  children: const [
                    Text('🪐', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 8),
                    Text(
                      'PLANETARY ASPECTS & TAROT TALISMANS',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        color: Color(0xFFD4AF37),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...reading.aspects.map((aspect) => SynastryAspectCard(aspect: aspect)),
                const SizedBox(height: 18),

                // Oracle Prophecy & Karmic Lesson Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161026),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '✦ ORACLE CHANNELING & KARMIC PURPOSE',
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          color: Color(0xFFFFD700),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        reading.oracleProphecy,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Divider(color: Color(0xFF2C2245), height: 24),
                      Text(
                        'Karmic Lesson: ${reading.karmicLesson}',
                        style: TextStyle(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.9),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Soul Growth Point: ${reading.soulChallenge}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Sacred Ritual Guidance
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF140F24),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF382B57)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🕯️', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SACRED CONSECRATION RITUAL',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              reading.sacredRitual,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Anchor to Altar Button
                OutlinedButton.icon(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    const service = SynastryService();
                    final intention = service.createAltarIntention(reading);
                    final readingNotifier = ref.read(readingNotifierProvider.notifier);
                    readingNotifier.setQuestion(intention);
                    readingNotifier.setSpread(SpreadType.solAndLuna);
                    readingNotifier.setSynastryPartner(
                      tarot_sp.SynastryPartner(
                        name: reading.partnerB.name,
                        sunSign: reading.partnerB.sunSign,
                        moonSign: reading.partnerB.moonSign,
                        risingSign: reading.partnerB.risingSign,
                        connectionType: reading.relationshipArchetype,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF1F1735),
                        content: Row(
                          children: const [
                            Icon(Icons.check_circle_outline, color: Color(0xFFFFD700)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Synastry Intention anchored to Altar Table!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );

                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: const Icon(Icons.style_outlined, color: Color(0xFFFFD700)),
                  label: const Text(
                    '✦ ANCHOR SYNASTRY TO ALTAR ✦',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFFD700),
                    side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresetsBar(SynastryState state, SynastryNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ARCHETYPAL PRESETS',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: SynastryPreset.allPresets.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final preset = SynastryPreset.allPresets[index];
              return InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  notifier.applyPreset(preset);
                },
                borderRadius: BorderRadius.circular(19),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1736),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: const Color(0xFF382B57)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(preset.glyph, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        preset.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
