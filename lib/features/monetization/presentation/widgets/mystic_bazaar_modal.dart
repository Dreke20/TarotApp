import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/auth_notifier.dart';
import '../../../subscription/presentation/oracle_pro_modal.dart';
import '../../domain/celestial_bazaar_models.dart';
import '../notifiers/bazaar_notifier.dart';

/// Master Sanctum Bazaar & Treasury Modal providing access to Starlight Shards,
/// 7-day Sanctuary Candles, Holographic Card Foils, and Twin Flame Dossiers.
class MysticBazaarModal extends ConsumerStatefulWidget {
  const MysticBazaarModal({super.key});

  static Future<void> show(BuildContext context) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MysticBazaarModal(),
    );
  }

  @override
  ConsumerState<MysticBazaarModal> createState() => _MysticBazaarModalState();
}

class _MysticBazaarModalState extends ConsumerState<MysticBazaarModal>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Candle Intention state
  CandleType _selectedCandle = CandleType.protection;
  final TextEditingController _intentionController = TextEditingController();

  // Synastry state
  final TextEditingController _seekerNameController = TextEditingController(text: 'Seeker');
  final TextEditingController _partnerNameController = TextEditingController();
  String _seekerSign = 'Scorpio';
  String _partnerSign = 'Pisces';

  final List<String> _zodiacSigns = const [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _intentionController.dispose();
    _seekerNameController.dispose();
    _partnerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bazaarState = ref.watch(bazaarProvider);
    final bazaarNotifier = ref.read(bazaarProvider.notifier);
    final authState = ref.watch(authNotifierProvider);
    final isPro = authState.profile?.isPro ?? false;

    // Toast notifications on message or error
    ref.listen<BazaarState>(bazaarProvider, (previous, next) {
      if (next.message != null && next.message != previous?.message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message!),
            backgroundColor: const Color(0xFF1E1435),
            behavior: SnackBarBehavior.floating,
          ),
        );
        bazaarNotifier.clearMessages();
      } else if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
        bazaarNotifier.clearMessages();
      }
    });

    return Container(
      height: mediaQuery.size.height * 0.90,
      decoration: const BoxDecoration(
        color: Color(0xFF0D0A14),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Top Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                const Text('🏛️', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MYSTIC BAZAAR & TREASURY',
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: AppColors.goldBright,
                        ),
                      ),
                      Text(
                        'Sacred relics, intention candles & astral blueprints',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Shards Vault Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('✦', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 13)),
                      const SizedBox(width: 5),
                      Text(
                        '${bazaarState.shards}',
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.goldBright,
            indicatorWeight: 2.5,
            labelColor: AppColors.goldBright,
            unselectedLabelColor: Colors.white60,
            labelStyle: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
            unselectedLabelStyle: GoogleFonts.cinzel(fontSize: 11),
            tabs: const [
              Tab(icon: Text('💎'), text: 'SHARDS'),
              Tab(icon: Text('🕯️'), text: 'CANDLES'),
              Tab(icon: Text('✨'), text: 'HOLO FOILS'),
              Tab(icon: Text('💫'), text: 'SYNASTRY'),
            ],
          ),

          const Divider(color: Colors.white12, height: 1),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildShardsTab(bazaarState, bazaarNotifier, isPro),
                _buildCandlesTab(bazaarState, bazaarNotifier, isPro),
                _buildFoilsTab(bazaarState, bazaarNotifier, isPro),
                _buildSynastryTab(bazaarState, bazaarNotifier, isPro),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: STARLIGHT SHARDS TREASURY
  // ==========================================
  Widget _buildShardsTab(
    BazaarState state,
    BazaarNotifier notifier,
    bool isPro,
  ) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Daily Celestial Offering (Rewarded Ad)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4C1D95).withValues(alpha: 0.4),
                const Color(0xFF1E1035).withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFA855F7), width: 1.2),
          ),
          child: Row(
            children: [
              const Text('✨', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CELESTIAL STARLIGHT OFFERING',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Watch a sacred rewarded offering to receive +1 Starlight Shard.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA855F7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: state.isProcessing
                    ? null
                    : () => notifier.watchAdForShard(isPro: isPro),
                child: Text(
                  '+1 FREE',
                  style: GoogleFonts.cinzel(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'STARLIGHT SHARD BUNDLES',
          style: GoogleFonts.cinzel(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 10),

        ...ShardPack.values.map((pack) {
          final isHighlighted = pack == ShardPack.medium;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? const Color(0xFFD4AF37).withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHighlighted ? const Color(0xFFD4AF37) : Colors.white12,
                width: isHighlighted ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                  ),
                  child: Text(
                    pack == ShardPack.small
                        ? '🔮'
                        : pack == ShardPack.medium
                            ? '💎'
                            : '👑',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (pack.bonusText != null)
                        Text(
                          pack.bonusText!,
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF59E0B),
                          ),
                        ),
                      Text(
                        pack.title,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        pack.tagline,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isHighlighted ? AppColors.goldBright : Colors.white12,
                    foregroundColor: isHighlighted ? Colors.black : Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => notifier.buyShardPack(pack),
                  child: Text(
                    pack.price,
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 10),

        // Oracle Pro upsell banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              const Text('👑', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Oracle Pro members receive infinite follow-ups & zero ad interruptions.',
                  style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => OracleProModal.show(context),
                child: Text(
                  'VIEW PRO',
                  style: GoogleFonts.cinzel(fontSize: 10, color: AppColors.goldBright),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: 7-DAY SANCTUARY CANDLES
  // ==========================================
  Widget _buildCandlesTab(
    BazaarState state,
    BazaarNotifier notifier,
    bool isPro,
  ) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Active Candles section if any
        if (state.activeCandles.isNotEmpty) ...[
          Text(
            'CURRENTLY BURNING ALTAR CANDLES',
            style: GoogleFonts.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: AppColors.goldMuted,
            ),
          ),
          const SizedBox(height: 10),
          ...state.activeCandles.map((candle) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: candle.type.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: candle.type.primaryColor.withValues(alpha: 0.45),
                ),
              ),
              child: Row(
                children: [
                  Text(candle.type.glyph, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          candle.type.name,
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '"${candle.intention}"',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: candle.type.primaryColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${candle.daysRemaining}d left',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: candle.type.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
        ],

        Text(
          'SELECT SACRED CANDLE FLAME',
          style: GoogleFonts.cinzel(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 10),

        // Candle Selector Cards
        ...CandleType.values.map((type) {
          final isSelected = type == _selectedCandle;
          return GestureDetector(
            onTap: () => setState(() => _selectedCandle = type),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected
                    ? type.primaryColor.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? type.primaryColor : Colors.white12,
                  width: isSelected ? 1.6 : 1,
                ),
              ),
              child: Row(
                children: [
                  Text(type.glyph, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.name,
                          style: GoogleFonts.cinzel(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          type.intentionPrompt,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    isPro ? 'FREE (PRO)' : '${type.shardCost} ✦',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? type.primaryColor : AppColors.goldMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 14),

        // Intention Input
        Text(
          'SPEAK OR INSCRIBE YOUR SACRED INTENTION:',
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _intentionController,
          maxLines: 2,
          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
          decoration: InputDecoration(
            hintText: 'e.g. "May peace, health, and sovereign light protect my sanctuary..."',
            hintStyle: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white30),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _selectedCandle.primaryColor),
            ),
          ),
        ),

        const SizedBox(height: 14),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedCandle.primaryColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          icon: const Text('🕯️', style: TextStyle(fontSize: 16)),
          label: Text(
            isPro
                ? 'IGNITE FLAME FOR 7 DAYS (PRO)'
                : 'IGNITE FLAME FOR 7 DAYS (3 ✦)',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          onPressed: () {
            notifier.lightCandle(
              type: _selectedCandle,
              intention: _intentionController.text,
              isPro: isPro,
            );
            _intentionController.clear();
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 3: HOLOGRAPHIC FOILS & CARD FINISHES
  // ==========================================
  Widget _buildFoilsTab(
    BazaarState state,
    BazaarNotifier notifier,
    bool isPro,
  ) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          'HOLOGRAPHIC 3D FOIL FINISHES',
          style: GoogleFonts.cinzel(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Shaders reflect radiant device tilt and gyroscopic shimmer during readings.',
          style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 14),

        ...CardFoilFinish.values.map((foil) {
          final isUnlocked = isPro || state.isFoilUnlocked(foil.id);
          final isEquipped = state.equippedFoil == foil.id;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isEquipped
                  ? foil.accentColor.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isEquipped ? foil.accentColor : Colors.white12,
                width: isEquipped ? 1.8 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [foil.accentColor, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: foil.accentColor, width: 1.2),
                  ),
                  child: const Center(
                    child: Text('🎴', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foil.name,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        foil.tagline,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEquipped)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: foil.accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'EQUIPPED',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: foil.accentColor,
                      ),
                    ),
                  )
                else if (isUnlocked)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: foil.accentColor,
                      side: BorderSide(color: foil.accentColor),
                    ),
                    onPressed: () => notifier.equipFoil(foil),
                    child: Text(
                      'EQUIP',
                      style: GoogleFonts.cinzel(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: foil.accentColor,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => notifier.unlockFoil(foil, isPro: isPro),
                    child: Text(
                      '${foil.shardCost} ✦',
                      style: GoogleFonts.cinzel(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ==========================================
  // TAB 4: TWIN FLAME & SYNASTRY DOSSIER
  // ==========================================
  Widget _buildSynastryTab(
    BazaarState state,
    BazaarNotifier notifier,
    bool isPro,
  ) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFBE185D).withValues(alpha: 0.3),
                const Color(0xFF1B0C1E).withValues(alpha: 0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF472B6), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('💫', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Text(
                    'TWIN FLAME SYNASTRY BLUEPRINT',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF472B6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'A comprehensive esoteric analysis mapping lunar harmony, karmic soul connections, and a 5-card relational spread.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'COSMIC SEEKER 1:',
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: _seekerNameController,
                style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Your name',
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _seekerSign,
                dropdownColor: const Color(0xFF160E26),
                style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white),
                items: _zodiacSigns
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _seekerSign = v ?? _seekerSign),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          'COSMIC SEEKER 2 (PARTNER / FLAME):',
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.goldMuted,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: _partnerNameController,
                style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Partner name',
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _partnerSign,
                dropdownColor: const Color(0xFF160E26),
                style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.white),
                items: _zodiacSigns
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _partnerSign = v ?? _partnerSign),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF472B6),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () {
            if (_partnerNameController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter your partner\'s name.')),
              );
              return;
            }
            notifier.generateSynastryDossier(
              seekerName: _seekerNameController.text.trim(),
              partnerName: _partnerNameController.text.trim(),
              seekerSign: _seekerSign,
              partnerSign: _partnerSign,
              isPro: isPro,
            );
          },
          child: Text(
            isPro ? 'CHANNEL BLUEPRINT (PRO FREE)' : 'CHANNEL BLUEPRINT (5 ✦ or \$4.99)',
            style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),

        // List of previously generated dossiers
        if (state.dossiers.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            'INSCRIBED DOSSIERS',
            style: GoogleFonts.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: AppColors.goldMuted,
            ),
          ),
          const SizedBox(height: 10),
          ...state.dossiers.map((d) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF472B6).withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${d.seekerName} & ${d.partnerName}',
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF472B6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${d.harmonyScore}% HARMONY',
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF472B6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    d.connectionArchetype,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.goldBright,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    d.channeledReading,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.white70,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}
