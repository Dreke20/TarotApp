import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/data/tarot_card_data.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';

class TarotLensScreen extends StatefulWidget {
  const TarotLensScreen({super.key});

  @override
  State<TarotLensScreen> createState() => _TarotLensScreenState();
}

class _TarotLensScreenState extends State<TarotLensScreen> {
  final SensoryService _sensory = SensoryService();
  TarotCard? _scannedCard;
  bool _isScanning = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scannedCard = TarotCardData.allCards.first; // Default to The Fool
  }

  void _triggerScanAnimation(TarotCard card) {
    setState(() {
      _isScanning = true;
    });
    _sensory.shuffleTremorHaptic();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _scannedCard = card;
        _isScanning = false;
      });
      _sensory.completionHaptic();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredCards = TarotCardData.allCards.where((c) {
      if (_searchQuery.isEmpty) return true;
      return c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.arcana.toLowerCase().contains(_searchQuery.toLowerCase());
    }).take(12).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.goldBright),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'REAL-WORLD TAROT LENS',
          style: GoogleFonts.cinzel(
            fontSize: 15,
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
            radius: 1.3,
            colors: [
              AppColors.backgroundViolet.withValues(alpha: 0.5),
              AppColors.backgroundDeep,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Optical Viewfinder Reticle Frame
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.backgroundMidnight.withValues(alpha: 0.9),
                  border: Border.all(
                    color: _isScanning ? AppColors.goldBright : AppColors.glassBorder,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isScanning
                          ? AppColors.goldBright.withValues(alpha: 0.35)
                          : Colors.black.withValues(alpha: 0.5),
                      blurRadius: _isScanning ? 30 : 12,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Corner targeting brackets
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: AppColors.goldBright, width: 2.5),
                            left: BorderSide(color: AppColors.goldBright, width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: AppColors.goldBright, width: 2.5),
                            right: BorderSide(color: AppColors.goldBright, width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      left: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.goldBright, width: 2.5),
                            left: BorderSide(color: AppColors.goldBright, width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      right: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.goldBright, width: 2.5),
                            right: BorderSide(color: AppColors.goldBright, width: 2.5),
                          ),
                        ),
                      ),
                    ),

                    // Laser Scanning Bar
                    if (_isScanning)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 3,
                            color: AppColors.goldBright,
                          ).animate(onPlay: (c) => c.repeat(reverse: true))
                              .slideY(begin: -20, end: 20, duration: 800.ms),
                        ),
                      ),

                    // Center Content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isScanning ? Icons.document_scanner : Icons.camera_alt_outlined,
                          size: 44,
                          color: AppColors.goldBright,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _isScanning ? 'DECIPHERING ESOTERIC GLYPHS...' : 'ALIGN PHYSICAL CARD ON SACRED ALTAR',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Point sensor or select physical card drawn from your deck below',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Card Search & Selector
              TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Identify physical card name (e.g. The Moon, Ace of Wands)...',
                  hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
                  prefixIcon: const Icon(Icons.search, color: AppColors.goldBright, size: 18),
                  filled: true,
                  fillColor: AppColors.glassFillStrong,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.glassBorder)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.glassBorder)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.goldBright)),
                ),
              ),

              const SizedBox(height: 12),

              // Filtered Quick Selector Chips
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredCards.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final c = filteredCards[index];
                    final isSelected = _scannedCard?.id == c.id;
                    return GestureDetector(
                      onTap: () => _triggerScanAnimation(c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.goldBright : AppColors.glassFillStrong,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: isSelected ? AppColors.goldBright : AppColors.glassBorder),
                        ),
                        child: Text(
                          c.name,
                          style: GoogleFonts.cinzel(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.backgroundDeep : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Scanned Card Deep Esoteric Analysis
              if (_scannedCard != null) _buildCardAnalysisCard(_scannedCard!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardAnalysisCard(TarotCard card) {
    return GlassContainer(
      borderRadius: 22,
      padding: const EdgeInsets.all(20),
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.85),
      borderColor: AppColors.goldBright.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name.toUpperCase(),
                    style: GoogleFonts.cinzel(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${card.arcana} • ${card.element ?? "Cosmic Element"}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppColors.etherealLavender,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.goldBright.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.4)),
                ),
                child: Text(
                  'OPTICAL MATCH',
                  style: GoogleFonts.cinzel(
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 14),

          Text(
            'UPRIGHT ESOTERIC REVELATION',
            style: GoogleFonts.cinzel(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            card.meaningUpright,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: AppColors.textPrimary,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 14),
          Text(
            'REVERSED / SHADOW CURRENT',
            style: GoogleFonts.cinzel(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: AppColors.etherealLavender,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            card.meaningReversed,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              height: 1.45,
            ),
          ),

          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.glassFillStrong,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.wb_incandescent, color: AppColors.goldBright, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Physical Altar Practice: Place ${card.name} facing East with clear quartz or frankincense incense during twilight to ground its archetype into your waking reality.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppColors.textPrimary.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.05, end: 0);
  }
}
