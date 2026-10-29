import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/external_launch_service.dart';
import '../../monetization/presentation/widgets/starlight_offering_modal.dart';
import '../../monetization/presentation/widgets/mystic_bazaar_modal.dart';
import '../../tarot/presentation/widgets/glass_container.dart';
import '../domain/subscription_offer.dart';
import '../domain/subscription_plan.dart';
import 'subscription_notifier.dart';

/// Modal paywall and plan selector for unlocking Oracle Pro with native In-App Purchases.
///
/// Oracle Pro is granted only by a store purchase or restore. There is no promo-code field.
class OracleProModal extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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

                    _buildFeaturedAnnualCard(
                      price: subState.paywallPriceFor(SubscriptionPlan.yearly),
                      trialPhrase: subState.trialPhraseFor(SubscriptionPlan.yearly),
                      savingsLabel: subState.yearlySavingsLabel,
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
                            price: subState.paywallPriceFor(SubscriptionPlan.monthly),
                            badgeText: 'FLEXIBLE',
                            isSelected: subState.selectedPlan == SubscriptionPlan.monthly,
                            onTap: () => subNotifier.selectPlan(SubscriptionPlan.monthly),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildPlanCard(
                            plan: SubscriptionPlan.lifetime,
                            price: subState.paywallPriceFor(SubscriptionPlan.lifetime),
                            badgeText: 'ONE-TIME',
                            isSelected: subState.selectedPlan == SubscriptionPlan.lifetime,
                            onTap: () => subNotifier.selectPlan(SubscriptionPlan.lifetime),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Restore Purchases Button / Link
                    Center(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onPressed: subState.isSubmitting
                            ? null
                            : () => subNotifier.restorePurchases(),
                        icon: const Icon(Icons.restore, size: 15, color: AppColors.goldBright),
                        label: Text(
                          'Restore Previous Purchases',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.glassBorder,
                          ),
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
                  onPressed: subState.canPurchase(subState.selectedPlan)
                      ? () => subNotifier.purchaseSelectedPlan()
                      : null,
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
                          _getPlanButtonLabel(subState),
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
              _planFootnote(subState),
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                MysticBazaarModal.show(context);
              },
              icon: const Text('🏛️', style: TextStyle(fontSize: 14)),
              label: Text(
                'Looking for Starlight Shards or 7-Day Intention Candles? Visit Mystic Bazaar ↗',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5,
                  color: AppColors.goldBright,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
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
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Subscriptions renew automatically unless cancelled at least 24 hours prior to the end of the billing period in Google Play Subscriptions. Payment is charged to your Google Play account.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 8.5,
                  color: AppColors.textMuted.withValues(alpha: 0.8),
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => ExternalLaunchService.openTermsOfService(context),
                  child: Text(
                    'Terms of Service',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.5,
                      color: AppColors.goldMuted,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text('  •  ', style: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.5), fontSize: 10)),
                GestureDetector(
                  onTap: () => ExternalLaunchService.openPrivacyPolicy(context),
                  child: Text(
                    'Privacy Policy',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.5,
                      color: AppColors.goldMuted,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text('  •  ', style: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.5), fontSize: 10)),
                GestureDetector(
                  onTap: () => ExternalLaunchService.openManageSubscriptions(context),
                  child: Text(
                    'Manage Subscriptions',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.5,
                      color: AppColors.goldMuted,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getPlanButtonLabel(SubscriptionState state) {
    if (state.isLoading) return '✦ LOADING PRICES ✦';
    if (!state.isAvailable ||
        state.paywallPriceFor(state.selectedPlan) == PaywallQuote.unavailablePrice) {
      return '✦ STORE UNAVAILABLE ✦';
    }
    final trial = state.trialPhraseFor(state.selectedPlan);
    if (trial != null) return '✦ START ${trial.toUpperCase()} ✦';
    if (state.selectedPlan == SubscriptionPlan.lifetime) {
      return '✦ UNLOCK LIFETIME ACCESS ✦';
    }
    return '✦ SUBSCRIBE TO ORACLE PRO ✦';
  }

  String _planFootnote(SubscriptionState state) {
    if (state.isLoading) return 'Loading prices from the store…';
    if (!state.isAvailable) {
      return 'Store unavailable. Purchases stay disabled until the store returns live prices.';
    }
    if (state.selectedPlan == SubscriptionPlan.lifetime) {
      return 'One-time investment. All future updates included forever.';
    }
    final trial = state.trialPhraseFor(state.selectedPlan);
    if (trial != null) {
      return '$trial, then the price shown. Cancel anytime in your store subscriptions.';
    }
    if (state.selectedPlan == SubscriptionPlan.yearly) {
      return 'Annual subscription. Cancel anytime in your store subscriptions.';
    }
    return 'Monthly subscription. Cancel anytime in your store subscriptions.';
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
    required String? trialPhrase,
    required String? savingsLabel,
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
                  if (savingsLabel != null || trialPhrase != null)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (savingsLabel != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                            decoration: BoxDecoration(
                              gradient: AppColors.goldButtonGradient,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              savingsLabel,
                              style: GoogleFonts.cinzel(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF09080C),
                              ),
                            ),
                          ),
                        if (trialPhrase != null)
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
                              trialPhrase.toUpperCase(),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.etherealLavender,
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (savingsLabel != null || trialPhrase != null) const SizedBox(height: 7),
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
                    price,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Cancel anytime',
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
