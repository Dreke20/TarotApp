import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../data/tarot_deck_service.dart';
import '../../domain/shuffle_ritual.dart';
import '../../domain/tarot_card.dart';
import '../notifiers/reading_notifier.dart';

/// Modal presenting interactive 3D physical shuffling:
/// 1. Sacred Riffle & Cascade Bridge
/// 2. Celtic Altar Chaos Wash
/// 3. Three Fates Tri-Fold Cut
class SacredRiffleShuffleModal extends ConsumerStatefulWidget {
  final VoidCallback? onShuffled;

  const SacredRiffleShuffleModal({super.key, this.onShuffled});

  static Future<void> show(BuildContext context, {VoidCallback? onShuffled}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SacredRiffleShuffleModal(onShuffled: onShuffled),
    );
  }

  @override
  ConsumerState<SacredRiffleShuffleModal> createState() => _SacredRiffleShuffleModalState();
}

class _SacredRiffleShuffleModalState extends ConsumerState<SacredRiffleShuffleModal>
    with TickerProviderStateMixin {
  ShuffleStyle _selectedStyle = ShuffleStyle.riffleBridge;

  late final AnimationController _riffleController;
  late final AnimationController _scatterController;
  late final AnimationController _bridgeController;

  bool _isShuffling = false;
  bool _isComplete = false;
  int _passesCompleted = 0;
  List<TarotCard>? _shuffledDeck;

  // Tri-fold cut restacking order tracking (piles 0, 1, 2)
  final List<int> _selectedCutOrder = [];

  final TarotDeckService _deckService = TarotDeckService();
  final SensoryService _sensory = SensoryService();

  @override
  void initState() {
    super.initState();

    _riffleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _bridgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scatterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
  }

  @override
  void dispose() {
    _riffleController.dispose();
    _bridgeController.dispose();
    _scatterController.dispose();
    super.dispose();
  }

  Future<void> _performRiffleShuffle() async {
    if (_isShuffling) return;

    setState(() {
      _isShuffling = true;
      _isComplete = false;
    });

    // Step 1: Split & Riffle Interlace with tactile micro-clicks
    _riffleController.forward(from: 0.0);

    for (int i = 0; i < 14; i++) {
      await Future.delayed(const Duration(milliseconds: 90));
      if (!mounted) return;
      HapticFeedback.selectionClick();
    }

    // Step 2: Parabolic Cascade Bridge snap down
    _bridgeController.forward(from: 0.0);
    _sensory.playCardFlipSound();
    await Future.delayed(const Duration(milliseconds: 850));

    if (!mounted) return;
    _sensory.completionHaptic();

    _shuffledDeck = _deckService.riffleShuffleDeck(passes: 3);

    setState(() {
      _isShuffling = false;
      _isComplete = true;
      _passesCompleted++;
    });
  }

  Future<void> _performCelticScatter() async {
    if (_isShuffling) return;

    setState(() {
      _isShuffling = true;
      _isComplete = false;
    });

    _scatterController.repeat();

    for (int i = 0; i < 8; i++) {
      await Future.delayed(const Duration(milliseconds: 280));
      if (!mounted) return;
      HapticFeedback.lightImpact();
    }

    _scatterController.stop();
    _sensory.completionHaptic();
    _sensory.playCardFlipSound();

    _shuffledDeck = _deckService.celticChaosScatter();

    setState(() {
      _isShuffling = false;
      _isComplete = true;
      _passesCompleted++;
    });
  }

  void _onCutPileTapped(int pileIndex) {
    if (_isShuffling || _selectedCutOrder.contains(pileIndex)) return;

    HapticFeedback.mediumImpact();
    setState(() {
      _selectedCutOrder.add(pileIndex);
      if (_selectedCutOrder.length == 3) {
        _isComplete = true;
        _shuffledDeck = _deckService.threePileCutDeck(restackOrder: _selectedCutOrder);
        _passesCompleted++;
      }
    });
  }

  void _resetCutPiles() {
    setState(() {
      _selectedCutOrder.clear();
      _isComplete = false;
      _shuffledDeck = null;
    });
  }

  void _applyShuffledDeckAndDeal() {
    final deck = _shuffledDeck ?? _deckService.shuffleDeck();
    final notifier = ref.read(readingNotifierProvider.notifier);
    final spreadType = ref.read(readingNotifierProvider).spreadType;

    final drawn = _deckService.drawSpread(
      spreadType: spreadType,
      shuffledDeck: deck,
    );

    notifier.setManualDrawnCards(drawn);

    Navigator.of(context).pop();
    widget.onShuffled?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0C1B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1.2),
          left: BorderSide(color: Color(0xFFD4AF37), width: 0.4),
          right: BorderSide(color: Color(0xFFD4AF37), width: 0.4),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Text('🎴', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SACRED 3D SHUFFLE STUDIO',
                        style: GoogleFonts.cinzel(
                          color: const Color(0xFFD4AF37),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        _passesCompleted > 0
                            ? 'Physical Riffle & Bridge • $_passesCompleted passes consecrated'
                            : 'Physical Riffle, Bridge Cascade & Tri-Fold Physics',
                        style: TextStyle(
                          color: _passesCompleted > 0 ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.6),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Style Selector Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: ShuffleStyle.values.map((style) {
                final bool isSelected = style == _selectedStyle;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      onTap: _isShuffling
                          ? null
                          : () {
                              HapticFeedback.selectionClick();
                              setState(() {
                                _selectedStyle = style;
                                _isComplete = false;
                                _selectedCutOrder.clear();
                              });
                            },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD4AF37).withValues(alpha: 0.22)
                              : const Color(0xFF1E1736),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFFFD700)
                                : const Color(0xFF33274E),
                            width: isSelected ? 1.2 : 0.6,
                          ),
                        ),
                        child: Text(
                          style.glyph,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Selected Style Description Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF161126),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2E234B)),
            ),
            child: Row(
              children: [
                Text(_selectedStyle.glyph, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedStyle.title.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        _selectedStyle.subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3D Visual Physics Arena
          Expanded(
            child: Center(
              child: _buildPhysicsArena(),
            ),
          ),

          // Action Buttons Bar
          _buildBottomActionStrip(),
        ],
      ),
    );
  }

  Widget _buildPhysicsArena() {
    switch (_selectedStyle) {
      case ShuffleStyle.riffleBridge:
        return _buildRiffleBridgeArena();
      case ShuffleStyle.celticScatter:
        return _buildCelticScatterArena();
      case ShuffleStyle.threePilesCut:
        return _buildThreePilesCutArena();
    }
  }

  // 1. Riffle & Bridge 3D Arena
  Widget _buildRiffleBridgeArena() {
    return AnimatedBuilder(
      animation: Listenable.merge([_riffleController, _bridgeController]),
      builder: (context, child) {
        final double riffleVal = _riffleController.value;
        final double bridgeVal = _bridgeController.value;

        // Perspective 3D rotation angles
        final double leftAngle = -0.35 * (1.0 - riffleVal) + (bridgeVal * 0.15);
        final double rightAngle = 0.35 * (1.0 - riffleVal) - (bridgeVal * 0.15);
        final double spreadX = 75.0 * (1.0 - riffleVal);
        final double bridgeLift = math.sin(bridgeVal * math.pi) * -45.0;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Center Altar Cloth Glow
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFD4AF37).withValues(alpha: _isShuffling ? 0.2 : 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Left Stack (3D tilted)
            Transform.translate(
              offset: Offset(-spreadX, bridgeLift),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY(leftAngle)
                  ..rotateZ(-0.06 * (1.0 - riffleVal)),
                alignment: Alignment.centerRight,
                child: _buildCardStackRepresentation(
                  label: 'Left 39',
                  isLeft: true,
                  cardCount: 39,
                ),
              ),
            ),

            // Right Stack (3D tilted)
            Transform.translate(
              offset: Offset(spreadX, bridgeLift),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY(rightAngle)
                  ..rotateZ(0.06 * (1.0 - riffleVal)),
                alignment: Alignment.centerLeft,
                child: _buildCardStackRepresentation(
                  label: 'Right 39',
                  isLeft: false,
                  cardCount: 39,
                ),
              ),
            ),

            // Central Interlocking Cascade Particles
            if (riffleVal > 0.05 && riffleVal < 0.95)
              Positioned(
                bottom: 80,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '⚡ INTERLACING CARDS...',
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

            // Bridge Snap Banner
            if (bridgeVal > 0.1 && bridgeVal < 0.9)
              Positioned(
                top: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4EE2EC).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '✨ CASCADE BRIDGE SNAP',
                    style: TextStyle(
                      color: Color(0xFF4EE2EC),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // 2. Celtic Chaos Scatter Vortex Arena
  Widget _buildCelticScatterArena() {
    return AnimatedBuilder(
      animation: _scatterController,
      builder: (context, child) {
        final double spin = _scatterController.value * 2 * math.pi;

        return SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Concentric Altar Ring
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
              ),

              // 8 Swirling card proxies in circle
              ...List.generate(8, (i) {
                final double cardAngle = spin + (i * (math.pi / 4));
                final double radius = 75.0;
                final double x = math.cos(cardAngle) * radius;
                final double y = math.sin(cardAngle) * radius;

                return Transform.translate(
                  offset: Offset(x, y),
                  child: Transform.rotate(
                    angle: cardAngle + math.pi / 2,
                    child: Container(
                      width: 44,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: AppColors.cardBackGradient,
                        border: Border.all(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                          width: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('✦', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10)),
                      ),
                    ),
                  ),
                );
              }),

              // Center Vortex Eye
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1B1430),
                  border: Border.all(color: const Color(0xFFFFD700)),
                ),
                child: const Center(
                  child: Text('🌀', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 3. Three Fates Tri-Fold Cut Arena
  Widget _buildThreePilesCutArena() {
    final List<String> titles = ['The Weaver', 'The Measurer', 'The Cutter'];
    final List<String> times = ['Past', 'Present', 'Future'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _selectedCutOrder.length < 3
              ? 'Select piles in order to restack the deck'
              : '✦ Deck Consecrated & Restacked ✦',
          style: TextStyle(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.9),
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final int? orderIndex = _selectedCutOrder.contains(i)
                ? _selectedCutOrder.indexOf(i) + 1
                : null;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => _onCutPileTapped(i),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildCardStackRepresentation(
                          label: '26 Cards',
                          isLeft: i == 0,
                          cardCount: 26,
                          width: 70,
                          height: 105,
                        ),
                        if (orderIndex != null)
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFFD700),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '$orderIndex',
                                style: const TextStyle(
                                  color: Color(0xFF0F0C1B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      titles[i],
                      style: const TextStyle(
                        fontFamily: 'Cinzel',
                        color: Color(0xFFFFD700),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      times[i],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        if (_selectedCutOrder.isNotEmpty && _selectedCutOrder.length < 3) ...[
          const SizedBox(height: 14),
          TextButton(
            onPressed: _resetCutPiles,
            child: const Text('Reset Selection', style: TextStyle(color: Colors.white54, fontSize: 11)),
          ),
        ],
      ],
    );
  }

  Widget _buildCardStackRepresentation({
    required String label,
    required bool isLeft,
    required int cardCount,
    double width = 85,
    double height = 135,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppColors.cardBackGradient,
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.style, color: Color(0xFFD4AF37), size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionStrip() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: [
          if (_isComplete) ...[
            ElevatedButton(
              onPressed: _applyShuffledDeckAndDeal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0F0C1B),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.auto_awesome, size: 18),
                  SizedBox(width: 8),
                  Text(
                    '✦ CONSECRATE & DEAL SPREAD ✦',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: _isShuffling
                  ? null
                  : () {
                      HapticFeedback.mediumImpact();
                      if (_selectedStyle == ShuffleStyle.riffleBridge) {
                        _performRiffleShuffle();
                      } else if (_selectedStyle == ShuffleStyle.celticScatter) {
                        _performCelticScatter();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2145),
                foregroundColor: const Color(0xFFFFD700),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.0),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.waves_rounded, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _isShuffling
                        ? 'SHUFFLING WITH 3D CASCADE...'
                        : 'INITIATE ${_selectedStyle.title.toUpperCase()}',
                    style: const TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
