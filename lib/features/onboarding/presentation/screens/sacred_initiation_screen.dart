import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../../../core/widgets/stardust_particle_field.dart';
import '../../../astrology/data/ephemeris_calculator.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../tarot/data/tarot_card_data.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../../tarot/presentation/screens/tarot_table_screen.dart';

/// The immersive Sacred Initiation Onboarding flow for first-time seekers.
class SacredInitiationScreen extends ConsumerStatefulWidget {
  const SacredInitiationScreen({super.key});

  @override
  ConsumerState<SacredInitiationScreen> createState() => _SacredInitiationScreenState();
}

class _SacredInitiationScreenState extends ConsumerState<SacredInitiationScreen> {
  int _currentStep = 0; // 0: Name, 1: Birthdate/Astrology, 2: Attune Seal, 3: Soul Card Reveal
  final TextEditingController _nameController = TextEditingController();
  DateTime _birthDate = DateTime(1998, 10, 24);
  bool _isAttuning = false;
  double _attuneProgress = 0.0;
  Timer? _attuneTimer;

  String _sunSign = 'Scorpio';
  String _moonSign = 'Pisces';
  String _risingSign = 'Cancer';
  int _soulCardNumber = 17;
  TarotCard? _soulCard;

  @override
  void initState() {
    super.initState();
    _recalculateAstrology();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _attuneTimer?.cancel();
    super.dispose();
  }

  void _recalculateAstrology() {
    _sunSign = EphemerisCalculator.getZodiacSignFromDate(_birthDate);
    final chart = EphemerisCalculator.calculateChart(sunSign: _sunSign);
    _moonSign = chart.moonSign;
    _risingSign = chart.risingSign;
    _soulCardNumber = EphemerisCalculator.calculateSoulCardNumber(_birthDate);

    final matching = TarotCardData.allCards.where(
      (c) => c.arcana == 'major' && c.number == _soulCardNumber,
    );
    _soulCard = matching.isNotEmpty ? matching.first : TarotCardData.allCards.first;
  }

  void _startAttuning() {
    final sensory = ref.read(sensoryServiceProvider);
    sensory.sacredHeartbeatHaptic();
    setState(() {
      _isAttuning = true;
      _attuneProgress = 0.0;
    });

    _attuneTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;
      setState(() {
        _attuneProgress += 0.035;
      });

      if (_attuneProgress % 0.25 < 0.04) {
        sensory.sacredHeartbeatHaptic();
      }

      if (_attuneProgress >= 1.0) {
        timer.cancel();
        sensory.completionHaptic();
        sensory.playRevelationSound();
        setState(() {
          _isAttuning = false;
          _currentStep = 3; // Advance to Soul Card Reveal
        });
      }
    });
  }

  void _cancelAttuning() {
    _attuneTimer?.cancel();
    if (_attuneProgress < 1.0) {
      setState(() {
        _isAttuning = false;
        _attuneProgress = 0.0;
      });
    }
  }

  Future<void> _completeInitiation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_initiation', true);

    final name = _nameController.text.trim().isEmpty ? 'Seeker' : _nameController.text.trim();
    // Update Auth Profile
    await ref.read(authProvider.notifier).updateZodiacSigns(
      sunSign: _sunSign,
      moonSign: _moonSign,
      risingSign: _risingSign,
      displayName: name,
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (context, animation, secondaryAnimation) => const TarotTableScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: StardustParticleField(
        enableAmbientDrift: true,
        enableTouchTrails: true,
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _buildCurrentStep(),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildNameStep();
      case 1:
        return _buildBirthdateStep();
      case 2:
        return _buildAttuneStep();
      case 3:
      default:
        return _buildSoulCardStep();
    }
  }

  // --- Step 0: Seeker Moniker ---
  Widget _buildNameStep() {
    return Center(
      key: const ValueKey('step_0_name'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: AppColors.goldAccent, size: 48)
                .animate()
                .scale(duration: 800.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 20),
            Text(
              'SACRED INITIATION',
              style: GoogleFonts.cinzel(
                color: AppColors.goldAccent,
                fontSize: 13,
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'What is your earthly name?',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The cards speak directly to your soul\'s vibration.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 36),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.goldAccent.withValues(alpha: 0.5)),
              ),
              child: TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your name...',
                  hintStyle: GoogleFonts.outfit(color: Colors.white30, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildProceedButton(
              title: 'PROCEED TO ALIGNMENT',
              onPressed: () {
                ref.read(sensoryServiceProvider).cardSelectionHaptic();
                setState(() => _currentStep = 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 1: Birthdate & Big Three Natal Reveal ---
  Widget _buildBirthdateStep() {
    return Center(
      key: const ValueKey('step_1_birthdate'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Text(
              'CELESTIAL EPHEMERIS',
              style: GoogleFonts.cinzel(
                color: AppColors.goldAccent,
                fontSize: 12,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'When did you arrive beneath the stars?',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            // Date picker trigger button
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _birthDate,
                  firstDate: DateTime(1930),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: AppColors.goldAccent,
                          onPrimary: Colors.black,
                          surface: Color(0xFF151026),
                          onSurface: Colors.white,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    _birthDate = picked;
                    _recalculateAstrology();
                  });
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.goldAccent.withValues(alpha: 0.6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.goldAccent, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('MMMM d, yyyy').format(_birthDate),
                      style: GoogleFonts.cinzel(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_drop_down, color: AppColors.goldAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            // The Big Three Placement Badges
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSignBadge('☀️ SUN', _sunSign),
                const SizedBox(width: 12),
                _buildSignBadge('🌙 MOON', _moonSign),
                const SizedBox(width: 12),
                _buildSignBadge('🏹 RISING', _risingSign),
              ],
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 36),
            _buildProceedButton(
              title: 'CALIBRATE SACRED ALTAR',
              onPressed: () {
                ref.read(sensoryServiceProvider).cardSelectionHaptic();
                setState(() => _currentStep = 2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignBadge(String label, String sign) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1430),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldAccent.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.cinzel(color: AppColors.goldAccent, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(sign, style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- Step 2: Attune Runic Seal with Heartbeat Haptic ---
  Widget _buildAttuneStep() {
    return Center(
      key: const ValueKey('step_2_attune'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Text(
              'RESONANCE CALIBRATION',
              style: GoogleFonts.cinzel(
                color: AppColors.goldAccent,
                fontSize: 12,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Attune Your Frequency',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Press and hold the celestial seal to bridge your energy into the cards.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 40),
            // Interactive Press-and-Hold Altar Seal
            GestureDetector(
              onTapDown: (_) => _startAttuning(),
              onTapUp: (_) => _cancelAttuning(),
              onTapCancel: _cancelAttuning,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _isAttuning ? const Color(0xFFFFD700) : const Color(0xFF2E224D),
                      const Color(0xFF100A20),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isAttuning
                          ? AppColors.goldAccent.withValues(alpha: 0.8)
                          : AppColors.goldAccent.withValues(alpha: 0.2),
                      blurRadius: _isAttuning ? 40 : 16,
                      spreadRadius: _isAttuning ? 6 : 2,
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.goldAccent,
                    width: _isAttuning ? 3.0 : 1.5,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Ring
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        value: _attuneProgress,
                        strokeWidth: 3.5,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldAccent),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app_rounded,
                          color: _isAttuning ? Colors.black : AppColors.goldAccent,
                          size: 42,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isAttuning ? 'ATTUNING...' : 'HOLD TO ATTUNE',
                          style: GoogleFonts.cinzel(
                            color: _isAttuning ? Colors.black : Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Text(
              _isAttuning ? 'Synchronizing with lunar harmonics...' : 'Rest your thumb upon the seal',
              style: GoogleFonts.outfit(
                color: _isAttuning ? AppColors.goldAccent : Colors.white38,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 3: Soul Blueprint Card Reveal ---
  Widget _buildSoulCardStep() {
    final soul = _soulCard ?? TarotCardData.allCards.first;
    return Center(
      key: const ValueKey('step_3_soul_card'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              'YOUR SOUL BLUEPRINT',
              style: GoogleFonts.cinzel(
                color: AppColors.goldAccent,
                fontSize: 12,
                letterSpacing: 4.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              soul.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'MAJOR ARCANA ${soul.number != null ? "• ${soul.number}" : ""}',
              style: GoogleFonts.cinzel(color: AppColors.goldAccent, fontSize: 11, letterSpacing: 2.0),
            ),
            const SizedBox(height: 20),
            // Holographic 3D Tilt Card
            SizedBox(
              width: 190,
              height: 285,
              child: HolographicFoilCard(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/cards/${soul.id}.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF1B1430),
                    alignment: Alignment.center,
                    child: Text(soul.name, style: GoogleFonts.cinzel(color: AppColors.goldAccent)),
                  ),
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF16102A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.goldAccent.withValues(alpha: 0.3)),
              ),
              child: Text(
                soul.meaningUpright,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
              ),
            ),
            const SizedBox(height: 28),
            _buildProceedButton(
              title: '✦ ENTER THE ASTRAL ALTAR ✦',
              onPressed: _completeInitiation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProceedButton({required String title, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFAA8020)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(
          title,
          style: GoogleFonts.cinzel(
            color: const Color(0xFF0F0B18),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
