import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../../core/widgets/holographic_foil_card.dart';
import '../../../tarot/data/tarot_card_data.dart';
import '../../../tarot/domain/spread_type.dart';
import '../../../tarot/domain/tarot_card.dart';
import '../../../tarot/presentation/notifiers/reading_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../../tarot/presentation/widgets/tarot_card_widget.dart';
import '../../data/tarot_lens_service.dart';
import '../../domain/tarot_lens_scan_result.dart';
import '../notifiers/tarot_lens_notifier.dart';

/// The Real-World Tarot Lens: Optical Camera Scanner & Multimodal Esoteric Scrying
class TarotLensScreen extends ConsumerStatefulWidget {
  const TarotLensScreen({super.key});

  @override
  ConsumerState<TarotLensScreen> createState() => _TarotLensScreenState();
}

class _TarotLensScreenState extends ConsumerState<TarotLensScreen> {
  final SensoryService _sensory = SensoryService();
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _anchorCardToTable(TarotCard card, bool isReversed) {
    _sensory.completionHaptic();
    _sensory.playRevelationSound();

    final readingNotifier = ref.read(readingNotifierProvider.notifier);
    readingNotifier.setSpread(SpreadType.dailyGuidance);
    readingNotifier.setQuestion('Physical Altar Invocation • ${card.name}');
    readingNotifier.setManualDrawnCards([card.copyWith(isReversed: isReversed)]);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cosmicSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.goldBright, width: 1.2),
        ),
        content: Row(
          children: [
            const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${card.name.toUpperCase()} anchored to Sacred Altar Table!',
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final lensState = ref.watch(tarotLensProvider);
    final lensNotifier = ref.read(tarotLensProvider.notifier);
    ref.listen(tarotLensProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });
    final scanResult = lensState.scanResult;

    final filteredCards = TarotCardData.allCards.where((c) {
      if (_searchQuery.isEmpty) return true;
      return c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.arcana.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (c.element?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).take(14).toList();

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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // 1. Optical Viewfinder Reticle Frame
                  _buildViewfinder(lensState, lensNotifier),

                  const SizedBox(height: 16),

                  // 2. Camera & Photo Action Controls
                  _buildCameraActionControls(lensState, lensNotifier),

                  const SizedBox(height: 18),

                  // 3. Manual Search & Quick Selector
                  _buildCardSearchAndChips(filteredCards, scanResult?.card, lensNotifier),

                  const SizedBox(height: 22),

                  // 4. Scanned Card Deep Esoteric Analysis Sheet
                  if (scanResult != null)
                    _buildScannedCardAnalysis(scanResult, lensNotifier),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewfinder(dynamic lensState, dynamic lensNotifier) {
    final hasCapturedPhoto = lensState.capturedImagePath != null;
    final isScanning = lensState.isScanning;

    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.backgroundMidnight.withValues(alpha: 0.92),
        border: Border.all(
          color: isScanning ? AppColors.goldBright : AppColors.glassBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isScanning
                ? AppColors.goldBright.withValues(alpha: 0.4)
                : Colors.black.withValues(alpha: 0.5),
            blurRadius: isScanning ? 32 : 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // If a real photo was captured from device camera / gallery
            if (hasCapturedPhoto)
              Positioned.fill(
                child: Image.file(
                  File(lensState.capturedImagePath!),
                  fit: BoxFit.cover,
                ),
              ),

            // Subtle dark overlay over captured photo to maintain legibility of reticle
            if (hasCapturedPhoto)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),

            // Corner targeting brackets
            _buildReticleBracket(top: 14, left: 14, isTop: true, isLeft: true),
            _buildReticleBracket(top: 14, right: 14, isTop: true, isLeft: false),
            _buildReticleBracket(bottom: 14, left: 14, isTop: false, isLeft: true),
            _buildReticleBracket(bottom: 14, right: 14, isTop: false, isLeft: false),

            // Laser Scanning Bar
            if (isScanning)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.goldBright,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldBright.withValues(alpha: 0.8),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .slideY(begin: -22, end: 22, duration: 900.ms),
                ),
              ),

            // Center Viewfinder Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backgroundDeep.withValues(alpha: 0.75),
                    border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
                  ),
                  child: Icon(
                    isScanning
                        ? Icons.document_scanner
                        : hasCapturedPhoto
                            ? Icons.verified
                            : Icons.camera_alt_outlined,
                    size: 38,
                    color: AppColors.goldBright,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  isScanning
                      ? 'DECIPHERING ESOTERIC GLYPHS & SYMBOLS...'
                      : hasCapturedPhoto
                          ? 'PHYSICAL CARD CAPTURED & ANALYZED'
                          : 'ALIGN PHYSICAL TAROT CARD IN SENSOR RETICLE',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    hasCapturedPhoto
                        ? 'Tap "Retake Photo" or select cards below to compare optical patterns'
                        : 'Snap a card from your physical deck to unlock deep altar scrying & symbols',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      color: AppColors.textMuted,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),

            // Retake / Clear photo button
            if (hasCapturedPhoto)
              Positioned(
                top: 14,
                right: 14,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.goldBright, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.backgroundMidnight.withValues(alpha: 0.8),
                  ),
                  onPressed: () {
                    _sensory.cardSelectionHaptic();
                    lensNotifier.clearCapturedImage();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReticleBracket({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required bool isTop,
    required bool isLeft,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? const BorderSide(color: AppColors.goldBright, width: 2.5) : BorderSide.none,
            bottom: !isTop ? const BorderSide(color: AppColors.goldBright, width: 2.5) : BorderSide.none,
            left: isLeft ? const BorderSide(color: AppColors.goldBright, width: 2.5) : BorderSide.none,
            right: !isLeft ? const BorderSide(color: AppColors.goldBright, width: 2.5) : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCameraActionControls(dynamic lensState, dynamic lensNotifier) {
    return Row(
      children: [
        // 1. Capture with Camera Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              _sensory.cardSelectionHaptic();
              lensNotifier.scanFromCamera();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.goldBright, AppColors.goldMetallic],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt, color: AppColors.backgroundDeep, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'CAPTURE PHOTO',
                    style: GoogleFonts.cinzel(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundDeep,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // 2. Select from Gallery Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              _sensory.cardSelectionHaptic();
              lensNotifier.scanFromGallery();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.glassFillStrong,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_library_outlined, color: AppColors.goldBright, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'FROM GALLERY',
                    style: GoogleFonts.cinzel(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldBright,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardSearchAndChips(
    List<TarotCard> filteredCards,
    TarotCard? activeCard,
    dynamic lensNotifier,
  ) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (val) => setState(() => _searchQuery = val),
          style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Identify physical card name (e.g. The Moon, Ace of Pentacles)...',
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12),
            prefixIcon: const Icon(Icons.search, color: AppColors.goldBright, size: 18),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textMuted, size: 16),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            filled: true,
            fillColor: AppColors.glassFillStrong,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.goldBright),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Filtered Quick Selector Chips
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: filteredCards.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final c = filteredCards[index];
              final isSelected = activeCard?.id == c.id;
              return GestureDetector(
                onTap: () {
                  _sensory.cardSelectionHaptic();
                  lensNotifier.selectCard(c);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.goldBright : AppColors.glassFillStrong,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
                    ),
                  ),
                  child: Text(
                    c.name,
                    style: GoogleFonts.cinzel(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.backgroundDeep : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScannedCardAnalysis(TarotLensScanResult result, dynamic lensNotifier) {
    final card = result.card;
    final isReversed = result.isReversed;
    final hasCapturedPhoto = result.capturedImagePath != null;

    return GlassContainer(
      borderRadius: 24,
      padding: const EdgeInsets.all(22),
      fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.9),
      borderColor: AppColors.goldBright.withValues(alpha: 0.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Title and Optical Match Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.name.toUpperCase(),
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${card.arcana.toUpperCase()} • ${card.element ?? "COSMIC"} ELEMENT',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.etherealLavender,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.goldBright.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 12),
                    const SizedBox(width: 5),
                    Text(
                      result.confidencePercent >= TarotLensService.manualSelectionConfidence
                          ? 'CHOSEN CARD'
                          : result.confidencePercent <= TarotLensService.unrecognizedConfidence
                              ? 'NOT RECOGNIZED'
                              : '${result.confidencePercent}% OPTICAL MATCH',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 16),

          // Orientation Toggle Button
          Row(
            children: [
              Text(
                'PHYSICAL ORIENTATION:',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _sensory.cardFlipHaptic();
                  lensNotifier.toggleOrientation();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isReversed
                        ? AppColors.etherealLavender.withValues(alpha: 0.2)
                        : AppColors.goldBright.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isReversed ? AppColors.etherealLavender : AppColors.goldBright,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isReversed ? Icons.sync : Icons.arrow_upward,
                        size: 13,
                        color: isReversed ? AppColors.etherealLavender : AppColors.goldBright,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isReversed ? 'REVERSED / INVERTED' : 'UPRIGHT',
                        style: GoogleFonts.cinzel(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isReversed ? AppColors.etherealLavender : AppColors.goldBright,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Side-by-Side Visual Inspection: Physical Photo & Consecrated Card Face
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Captured Photo Preview (or viewfinder thumbnail)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'PHYSICAL CAPTURE',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.backgroundDeep,
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: hasCapturedPhoto
                            ? Image.file(
                                File(result.capturedImagePath!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.textMuted.withValues(alpha: 0.5),
                                  size: 32,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Right: Consecrated Card Face
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'CONSECRATED ARCHETYPE',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.goldBright,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 180,
                      child: HolographicFoilCard(
                        borderRadius: BorderRadius.circular(14),
                        child: TarotCardWidget(
                          card: card,
                          width: 120,
                          height: 180,
                          isFaceUp: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Detected Esoteric Symbols
          Text(
            'DETECTED ESOTERIC SYMBOLS',
            style: GoogleFonts.cinzel(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: AppColors.goldBright,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: result.detectedSymbols.map((sym) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.glassFillStrong,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.blur_on, color: AppColors.goldBright, size: 12),
                    const SizedBox(width: 5),
                    Text(
                      sym,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 18),

          // Scrying Revelation
          Text(
            isReversed ? 'SHADOW / INWARD CURRENT' : 'UPRIGHT ESOTERIC REVELATION',
            style: GoogleFonts.cinzel(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: isReversed ? AppColors.etherealLavender : AppColors.goldBright,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            result.scryingAnalysis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: AppColors.textPrimary,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 18),

          // Physical Altar Practice Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.glassFillStrong,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.goldMetallic.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.wb_incandescent, color: AppColors.goldBright, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PHYSICAL ALTAR CONSECRATION PRACTICE',
                        style: GoogleFonts.cinzel(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldBright,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result.physicalAltarRitual,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: AppColors.textPrimary.withValues(alpha: 0.95),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // 5. "ANCHOR TO SACRED ALTAR TABLE" Button
          GestureDetector(
            onTap: () => _anchorCardToTable(card, isReversed),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.goldBright, AppColors.goldMetallic],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldBright.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.table_restaurant, color: AppColors.backgroundDeep, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'ANCHOR TO SACRED ALTAR TABLE',
                    style: GoogleFonts.cinzel(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundDeep,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}
