import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/external_launch_service.dart';

/// An evocative, high-luxury card encouraging seekers to connect with a live human intuitive reader.
class LiveReaderCard extends StatelessWidget {
  final bool isCompact;

  const LiveReaderCard({
    super.key,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0D15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.goldBright.withValues(alpha: 0.35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldBright.withValues(alpha: 0.08),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.goldBright.withValues(alpha: 0.12),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.3)),
              ),
              child: const Icon(
                Icons.record_voice_over_outlined,
                color: AppColors.goldBright,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TALK TO A LIVE PERSON',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    'Live 1-on-1 readings on whispers26.com',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                ExternalLaunchService.openLiveReader(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldBright,
                foregroundColor: AppColors.backgroundDeep,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CONNECT',
                    style: GoogleFonts.cinzel(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.open_in_new, size: 12),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0B12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.goldBright.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldBright.withValues(alpha: 0.08),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle warm corner glow
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.goldBright.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.goldBright.withValues(alpha: 0.15),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Icon(
                        Icons.record_voice_over_outlined,
                        color: AppColors.goldBright,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'SEEK A LIVING ORACLE',
                                style: GoogleFonts.cinzel(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldBright,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: AppColors.goldBright.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.goldBright.withValues(alpha: 0.4),
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  'LIVE',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'whispers26.com Intuitive Sanctuary',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Want personalized human insight beyond the AI cards? Connect 1-on-1 with master intuitive readers for live private consultations, deeper spiritual discernment, and tailored clarity.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      ExternalLaunchService.openLiveReader(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldBright,
                      foregroundColor: AppColors.backgroundDeep,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.goldBright.withValues(alpha: 0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'TALK TO A LIVE PERSON',
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.open_in_new, size: 14),
                      ],
                    ),
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
