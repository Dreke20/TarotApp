import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/external_launch_service.dart';
import '../../monetization/presentation/widgets/starlight_offering_modal.dart';
import '../../tarot/presentation/widgets/glass_container.dart';
import '../domain/subscription_plan.dart';
import 'subscription_notifier.dart';

/// Modal paywall and plan selector for unlocking Oracle Pro with native In-App Purchases.
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
  bool _showPromoField = false;
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final subState = ref.watch(subscriptionNotifierProvider);
    final subNotifier = ref.read(subscriptionNotifierProvider.notifier);

    // Listen to purchase events & notifications
    ref.listen<SubscriptionState>(subscriptionNotifierProvider, (previous, next) {
      if (next.successMessage != null && next.successMessage != previous?.successMessage) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✨ ${next.successMessage!}'),
            backgroundColor: AppColors.cosmicSurface,
          ),
        );
        subNotifier.clearMessages();
      } else if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red.shade900,
          ),
        );
        subNotifier.clearMessages();
      }
    });

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
                    // Social Proof Trust Badge
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.goldMuted.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.goldBright.withValues(alpha: 0.28),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star_rounded,
                                color: AppColors.goldBright,
                                size: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '4.9/5 RATING · 15,000+ SEEKERS WORLDWIDE',
                            style: GoogleFonts.cinzel(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

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
                    _buildFeatureRow(
                      icon: Icons.block,
                      title: '100% Ad-Free Sanctuary',
                      description: 'Zero ads, banners, or offerings across all divination tools.',
                    ),
                    const SizedBox(height: 18),

                    // Featured Annual Plan Card (with 3-day Free Trial)
                    _buildFeaturedAnnualCard(
                      price: subState.priceFor(SubscriptionPlan.yearly),
                      isSelected: subState.selectedPlan == SubscriptionPlan.yearly,
                      onTap: () => subNotifier.selectPlan(SubscriptionPlan.yearly),
                    ),
                    const SizedBox(height: 10),

                    // Monthly & Lifetime cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildPlanCard(
                            plan: SubscriptionPlan.monthly,
                            price: subState.priceFor(SubscriptionPlan.monthly),
                            badgeText: 'FLEXIBLE',
                            isSelected: subState.selectedPlan == SubscriptionPlan.monthly,
                            onTap: () => subNotifier.selectPlan(SubscriptionPlan.monthly),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildPlanCard(
                            plan: SubscriptionPlan.lifetime,
                            price: subState.priceFor(SubscriptionPlan.lifetime),
                            badgeText: 'ONE-TIME',
                            isSelected: subState.selectedPlan == SubscriptionPlan.lifetime,
                            onTap: () => subNotifier.selectPlan(SubscriptionPlan.lifetime),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Promo Code Toggle / Input
                    if (!_showPromoField)
                      TextButton.icon(
                        icon: const Icon(Icons.confirmation_number_outlined,
                            size: 15, color: AppColors.etherealLavender),
                        label: Text(
                          'Redeem Celestial Code',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.etherealLavender,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () => setState(() => _showPromoField = true),
                      )
                    else ...[
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _promoController,
                              textCapitalization: TextCapitalization.characters,
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.goldBright,
                                letterSpacing: 1.5,
                              ),
                              decoration: InputDecoration(
                                hintText: 'ENTER CODE (e.g. CELESTIAL_PRO)',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                filled: true,
                                fillColor: AppColors.glassFill,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: AppColors.glassBorder),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldBright,
                              foregroundColor: AppColors.backgroundDeep,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: subState.isSubmitting
                                ? null
                                : () => subNotifier.redeemPromoCode(_promoController.text),
                            child: Text(
                              'APPLY',
                              style: GoogleFonts.cinzel(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],

                    // Restore Purchases Link
                    TextButton(
                      onPressed: subState.isSubmitting
                          ? null
                          : () => subNotifier.restorePurchases(),
                      child: Text(
                        'Restore Previous Purchases',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Subscribe Button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: subState.isSubmitting ? null : AppColors.goldButtonGradient,
                  color: subState.isSubmitting ? AppColors.goldMuted : null,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldMetallic.withValues(alpha: 0.35),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color(0xFF09080C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: subState.isSubmitting
                      ? null
                      : () => subNotifier.purchaseSelectedPlan(),
                  child: subState.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF09080C)),
                          ),
                        )
                      : Text(
                          _getPlanButtonLabel(subState.selectedPlan),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cinzel(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: const Color(0xFF09080C),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subState.selectedPlan == SubscriptionPlan.yearly
                  ? 'Includes 3-day free trial. Cancel anytime in Google Play.'
                  : subState.selectedPlan == SubscriptionPlan.lifetime
                      ? 'One-time investment. All future updates included forever.'
                      : 'Monthly subscription. Cancel anytime in Google Play.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('✦', style: TextStyle(color: AppColors.goldMuted, fontSize: 11)),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    StarlightOfferingModal.show(context);
                  },
                  child: Text(
                    'Prefer free? Offer celestial incense (Watch an ad for 1 Pass)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      color: AppColors.goldBright,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('✦', style: TextStyle(color: AppColors.goldMuted, fontSize: 11)),
              ],
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ExternalLaunchService.openLiveReader(context);
              },
              icon: const Icon(Icons.record_voice_over_outlined, size: 14, color: AppColors.goldBright),
              label: Text(
                'Prefer a real human reading? Talk to a live person on whispers26.com ↗',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: AppColors.goldMuted,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPlanButtonLabel(SubscriptionPlan plan) {
    switch (plan) {
      case SubscriptionPlan.yearly:
        return '✦ START 3-DAY FREE TRIAL & UPGRADE ✦';
      case SubscriptionPlan.lifetime:
        return '✦ UNLOCK LIFETIME ACCESS ✦';
      case SubscriptionPlan.monthly:
        return '✦ SUBSCRIBE TO ORACLE PRO ✦';
    }
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

  Widget _buildFeaturedAnnualCard({
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cosmicSurface : AppColors.glassFill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.2),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                        decoration: BoxDecoration(
                          gradient: AppColors.goldButtonGradient,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'SAVE 50%',
                          style: GoogleFonts.cinzel(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF09080C),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: AppColors.etherealLavender.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.etherealLavender.withValues(alpha: 0.5),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          '3-DAY FREE TRIAL',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.etherealLavender,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'ANNUAL SANCTUARY',
                    style: GoogleFonts.cinzel(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Only \$2.50/month · Cancel anytime',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.goldBright : AppColors.textMuted,
                      width: 1.8,
                    ),
                    color: isSelected ? AppColors.goldBright : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 13, color: Color(0xFF09080C))
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required SubscriptionPlan plan,
    required String price,
    required String? badgeText,
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
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.12),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      badgeText,
                      style: GoogleFonts.cinzel(
                        fontSize: 7.5,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.backgroundDeep : AppColors.textSecondary,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 14),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.goldBright : AppColors.textMuted,
                      width: 1.5,
                    ),
                    color: isSelected ? AppColors.goldBright : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 11, color: Color(0xFF09080C))
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              plan.title,
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              price,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
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
