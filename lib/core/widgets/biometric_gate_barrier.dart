import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../services/biometric_vault_service.dart';

/// Wraps sensitive spiritual areas (Journal, Readings History)
/// with a biometric consecration barrier if the user has enabled the vault.
class BiometricGateBarrier extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final String subtitle;

  const BiometricGateBarrier({
    super.key,
    required this.child,
    this.title = 'SACRED VAULT CONSECRATED',
    this.subtitle = 'Authenticate to unseal your private astral reflections.',
  });

  @override
  ConsumerState<BiometricGateBarrier> createState() => _BiometricGateBarrierState();
}

class _BiometricGateBarrierState extends ConsumerState<BiometricGateBarrier> {
  bool _isUnlocked = false;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    final isEnabled = await BiometricVaultService.instance.isVaultEnabled();
    if (!isEnabled) {
      if (mounted) setState(() => _isUnlocked = true);
    } else {
      // Auto-trigger biometric prompt on screen entry
      _triggerAuth();
    }
  }

  Future<void> _triggerAuth() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    final success = await BiometricVaultService.instance.authenticate(
      reason: 'Scan fingerprint or face to unseal your sacred journal',
    );

    if (mounted) {
      if (success) {
        HapticFeedback.heavyImpact();
        setState(() {
          _isUnlocked = true;
          _isAuthenticating = false;
        });
      } else {
        HapticFeedback.mediumImpact();
        setState(() => _isAuthenticating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vaultEnabledAsync = ref.watch(biometricVaultProvider);

    return vaultEnabledAsync.when(
      data: (enabled) {
        if (!enabled || _isUnlocked) {
          return widget.child;
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundMidnight,
          body: Stack(
            children: [
              // Cosmic background glow
              Center(
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.goldBright.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Consecrated Golden Seal
                        GestureDetector(
                          onTap: _triggerAuth,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  AppColors.goldBright,
                                  AppColors.cosmicSurface,
                                ],
                              ),
                              border: Border.all(
                                color: AppColors.goldBright,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.goldBright.withValues(alpha: 0.35),
                                  blurRadius: 28,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.fingerprint,
                                size: 48,
                                color: AppColors.backgroundDeep,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 2.2,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          widget.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Unlock Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _triggerAuth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldBright,
                              foregroundColor: AppColors.backgroundDeep,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.lock_open, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'UNLOCK SANCTUARY',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Return to Altar Button
                        TextButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          child: Text(
                            'RETURN TO ALTAR',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              color: AppColors.goldMuted,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.backgroundMidnight,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.goldBright),
        ),
      ),
      error: (error, stack) => widget.child,
    );
  }
}
