import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/presentation/auth_notifier.dart';
import '../../tarot/presentation/widgets/glass_container.dart';

class OracleProModal extends ConsumerStatefulWidget {
  const OracleProModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const OracleProModal(),
    );
  }

  @override
  ConsumerState<OracleProModal> createState() => _OracleProModalState();
}

class _OracleProModalState extends ConsumerState<OracleProModal> {
  bool _isAnnual = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.9,
      ),
      margin: const EdgeInsets.only(top: 24),
      child: GlassContainer(
        borderRadius: 28,
        blur: 26,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.95),
        borderColor: AppColors.goldBright,
        borderWidth: 1.8,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Modal Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.workspace_premium, color: AppColors.goldBright, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'ORACLE PRO',
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 2.0,
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
            const Divider(color: AppColors.glassBorder, height: 20),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Spark banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.backgroundViolet.withValues(alpha: 0.8),
                            AppColors.cosmicSurface.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 30),
                          const SizedBox(height: 8),
                          Text(
                            'UNVEIL THE INFINITE VEIL',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cinzel(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Unlock high-dimension tarot spreads, deep conversational AI follow-ups, and sacred voice revelations.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Feature highlights
                    _buildFeatureRow(
                      icon: Icons.all_inclusive,
                      title: 'The Celtic Cross (10 Cards)',
                      description: 'Master the iconic 10-card matrix illuminating your complete destiny.',
                    ),
                    _buildFeatureRow(
                      icon: Icons.forum,
                      title: 'Multi-Turn Oracle Conversations',
                      description: 'Ask unlimited follow-up inquiries directly to the AI Oracle.',
                    ),
                    _buildFeatureRow(
                      icon: Icons.style,
                      title: 'All Sacred Art Decks',
                      description: 'Full access to Ethereal Luminary and Obsidian Mystery decks.',
                    ),
                    _buildFeatureRow(
                      icon: Icons.record_voice_over,
                      title: 'Ethereal Voice Narration',
                      description: 'Listen to spoken prophecies channeled by celestial sound synthesis.',
                    ),
                    const SizedBox(height: 18),

                    // Plan selection cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildPlanCard(
                            isAnnual: true,
                            title: 'ANNUAL PLAN',
                            price: '\$29.99 / yr',
                            savings: 'SAVE 50%',
                            isSelected: _isAnnual,
                            onTap: () => setState(() => _isAnnual = true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildPlanCard(
                            isAnnual: false,
                            title: 'MONTHLY',
                            price: '\$4.99 / mo',
                            savings: null,
                            isSelected: !_isAnnual,
                            onTap: () => setState(() => _isAnnual = false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Subscribe Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldBright,
                  foregroundColor: AppColors.backgroundDeep,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                ),
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).setProStatus(true);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✨ Welcome to Oracle Pro! All celestial mysteries are unlocked.'),
                        backgroundColor: AppColors.cosmicSurface,
                      ),
                    );
                  }
                },
                child: Text(
                  'UPGRADE TO ORACLE PRO',
                  style: GoogleFonts.cinzel(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.cosmicSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.goldMuted.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, color: AppColors.goldBright, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cinzel(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required bool isAnnual,
    required String title,
    required String price,
    required String? savings,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cosmicSurface : AppColors.glassFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (savings != null)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.goldBright,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  savings,
                  style: GoogleFonts.cinzel(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundDeep,
                  ),
                ),
              ),
            Text(
              title,
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
