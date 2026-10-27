import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../altar/presentation/widgets/altar_cloth_selector_modal.dart';
import '../../astral_circle/presentation/widgets/astral_circle_hub_modal.dart';
import '../../voice_oracle/presentation/widgets/hands_free_communion_modal.dart';
import '../../altar/presentation/widgets/crystal_grid_sheet.dart';
import '../../altar/presentation/widgets/custom_ritual_forge_modal.dart';
import '../../altar/presentation/widgets/sacred_breathing_modal.dart';
import '../../altar/presentation/widgets/smoke_purification_modal.dart';
import '../../ar_altar/presentation/screens/ar_altar_screen.dart';
import '../../audio_weaver/presentation/widgets/sacred_audio_weaver_modal.dart';
import '../../astrology/domain/sabbat_calendar.dart';
import '../../astrology/presentation/screens/lunar_almanac_screen.dart';
import '../../astrology/presentation/screens/natal_chart_screen.dart';
import '../../astrology/synastry/presentation/screens/lunar_synastry_screen.dart';
import '../../astrology/transit/presentation/screens/celestial_transit_screen.dart';
import '../../collective/presentation/screens/collective_sanctuary_screen.dart';
import '../../divination/data/iching_data.dart';
import '../../divination/data/rune_data.dart';
import '../../divination/presentation/screens/iching_screen.dart';
import '../../divination/presentation/screens/rune_casting_screen.dart';
import '../../dream/data/jungian_symbol_data.dart';
import '../../dream/presentation/screens/dream_journal_screen.dart';
import '../../lens/presentation/screens/tarot_lens_screen.dart';
import '../../meditation/domain/archetypal_pathworking.dart';
import '../../meditation/presentation/screens/pathworking_sanctuary_screen.dart';
import '../../notifications/presentation/widgets/cosmic_notification_modal.dart';
import '../../oracle_dialogue/presentation/screens/conversational_oracle_screen.dart';
import '../../tarot/data/tarot_card_data.dart';
import '../../tarot/domain/spread_type.dart';
import '../../tarot/presentation/notifiers/reading_notifier.dart';
import '../../tarot/presentation/screens/custom_spread_builder_screen.dart';
import '../../tarot/presentation/screens/readings_history_screen.dart';
import '../../tarot/presentation/screens/seekers_chronicle_screen.dart';
import '../../tarot/presentation/screens/tarot_codex_screen.dart';
import '../../tarot/presentation/widgets/card_back_selector_modal.dart';
import '../../tarot/presentation/widgets/deck_switcher_modal.dart';
import '../../tarot/presentation/widgets/oracle_persona_selector_modal.dart';
import '../../tarot/presentation/widgets/mystic_widget_hub_modal.dart';
import '../../tarot/presentation/widgets/sacred_riffle_shuffle_modal.dart';
import '../../wallpaper/presentation/screens/wallpaper_studio_screen.dart';
import '../../../../core/services/external_launch_service.dart';
import '../../monetization/presentation/widgets/mystic_bazaar_modal.dart';
import '../domain/sanctum_item.dart';

/// Central catalog indexing all sacred sanctuaries, esoteric tools, and
/// divination entities (cards, runes, hexagrams, dream archetypes, sabbats).
class SanctumCatalog {
  const SanctumCatalog._();

  /// Primary core sanctuaries available across the 4 sacred quadrants.
  static final List<SanctumItem> allSanctuaries = [
    // ==========================================
    // QUADRANT 1: DIVINATION SANCTUARIES
    // ==========================================
    SanctumItem(
      id: 'sanctuary_tarot_altar',
      title: 'Astral Guidance Altar',
      subtitle: '78-card sacred table with 3D flips, foil shaders & Celtic Cross',
      iconGlyph: '🎴',
      iconData: Icons.style,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.divination,
      badgeText: 'CORE ALTAR',
      searchKeywords: ['tarot', 'altar', 'cards', 'reading', 'celtic cross', 'shuffle', 'divination'],
      onOpen: (context, ref) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    ),
    SanctumItem(
      id: 'sanctuary_riffle_shuffle',
      title: 'Sacred 3D Riffle & Bridge Studio',
      subtitle: 'Physical Gilbert-Shannon-Reeds card riffle, Celtic chaos wash & tri-fold cut',
      iconGlyph: '🎴',
      iconData: Icons.waves_rounded,
      accentColor: const Color(0xFFFFD700),
      category: SanctumCategory.divination,
      badgeText: '3D SHUFFLE',
      searchKeywords: ['shuffle', 'riffle', 'bridge', 'cut', 'physics', 'celtic wash', 'tri-fold', 'cards'],
      onOpen: (context, ref) {
        SacredRiffleShuffleModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_sol_luna_spread',
      title: 'Sol & Luna Synastry Spread',
      subtitle: 'Dual-soul 3-card spread: Solar Will, Lunar Heart & Conjunction Bridge',
      iconGlyph: '☀️',
      iconData: Icons.brightness_medium,
      accentColor: const Color(0xFFFFD700),
      category: SanctumCategory.divination,
      badgeText: 'SYNASTRY SPREAD',
      searchKeywords: ['synastry', 'sol and luna', 'relationship', 'partner', 'love', 'conjunction', 'soulmate', 'spread'],
      onOpen: (context, ref) {
        ref.read(readingNotifierProvider.notifier).setSpread(SpreadType.solAndLuna);
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    ),
    SanctumItem(
      id: 'sanctuary_ar_altar',
      title: 'Augmented Reality Altar',
      subtitle: 'Project sacred mandalas & live tarot spreads into your room',
      iconGlyph: '🕯️',
      iconData: Icons.view_in_ar,
      accentColor: const Color(0xFFE5A93C),
      category: SanctumCategory.divination,
      badgeText: 'AR CAM',
      searchKeywords: ['ar', 'augmented reality', 'camera', 'spatial', 'mandala', 'room altar'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ArAltarScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_voice_oracle',
      title: 'Conversational Voice Oracle',
      subtitle: 'Hands-free spoken channeling with responsive voice synthesis',
      iconGlyph: '🔮',
      iconData: Icons.record_voice_over,
      accentColor: const Color(0xFF9B51E0),
      category: SanctumCategory.divination,
      badgeText: 'VOICE AI',
      searchKeywords: ['voice', 'spoken', 'speech', 'dialogue', 'channeling', 'talk', 'conversation'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ConversationalOracleScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_tarot_lens',
      title: 'Real-World Tarot Lens',
      subtitle: 'Camera vision & photo scrying to identify physical tarot cards',
      iconGlyph: '🔍',
      iconData: Icons.camera_alt_outlined,
      accentColor: const Color(0xFF00C9FF),
      category: SanctumCategory.divination,
      badgeText: 'VISION LENS',
      searchKeywords: ['lens', 'camera', 'scan', 'photo', 'recognition', 'physical cards', 'multimodal'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const TarotLensScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_runes',
      title: 'Elder Futhark Rune Sanctuary',
      subtitle: '24 authentic stone casts across Freya, Heimdall & Tyr Aetts',
      iconGlyph: 'ᚦ',
      iconData: Icons.brightness_high,
      accentColor: const Color(0xFFE2B770),
      category: SanctumCategory.divination,
      badgeText: '24 RUNES',
      searchKeywords: ['runes', 'elder futhark', 'nordic', 'odin', 'stones', 'merkstave', 'casting'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const RuneCastingScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_iching',
      title: 'I Ching Book of Changes',
      subtitle: 'Sacred 3-coin tossing ritual with 64 hexagram judgments',
      iconGlyph: '☯',
      iconData: Icons.change_circle_outlined,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.divination,
      badgeText: '64 HEXAGRAMS',
      searchKeywords: ['i ching', 'hexagram', 'coins', 'tao', 'yin yang', 'changes', 'trigram'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const IChingScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_astral_circle',
      title: 'Astral Circle • Multiplayer Altar',
      subtitle: 'Real-time synchronized tarot table with 6-character sacred room codes',
      iconGlyph: '♾️',
      iconData: Icons.all_inclusive,
      accentColor: const Color(0xFF8BFFB8),
      category: SanctumCategory.divination,
      badgeText: 'CO-OP REALTIME',
      searchKeywords: ['multiplayer', 'circle', 'co-op', 'shared', 'room', 'partner', 'realtime', 'duo'],
      onOpen: (context, ref) {
        AstralCircleHubModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_hands_free_voice',
      title: 'Voice Oracle • Hands-Free Communion',
      subtitle: 'Atmospheric voice activity scrying with automatic background audio ducking',
      iconGlyph: '🎙️',
      iconData: Icons.mic,
      accentColor: const Color(0xFFFFD700),
      category: SanctumCategory.divination,
      badgeText: 'HANDS-FREE',
      searchKeywords: ['voice', 'hands-free', 'speech', 'communion', 'ducking', 'mic', 'vad'],
      onOpen: (context, ref) {
        HandsFreeCommunionModal.show(context);
      },
    ),

    // ==========================================
    // QUADRANT 2: CELESTIAL EPHEMERIS & STARS
    // ==========================================
    SanctumItem(
      id: 'sanctuary_lunar_almanac',
      title: 'Lunar Almanac & Ephemeris',
      subtitle: '29.5-day live moon transit, illumination & Sabbat wheel',
      iconGlyph: '🌙',
      iconData: Icons.brightness_3,
      accentColor: const Color(0xFF8AB4F8),
      category: SanctumCategory.celestial,
      badgeText: 'MOON EPHEMERIS',
      searchKeywords: ['lunar', 'moon', 'almanac', 'ephemeris', 'sabbat', 'wheel of the year', 'illumination', 'transit'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LunarAlmanacScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_natal_chart',
      title: 'Complete Natal Ephemeris & Chart',
      subtitle: 'Calculates 8 planetary placements, elemental balance & soul archetype',
      iconGlyph: '🪐',
      iconData: Icons.pie_chart_outline,
      accentColor: const Color(0xFFB39DDB),
      category: SanctumCategory.celestial,
      badgeText: 'ASTROLOGY',
      searchKeywords: ['natal', 'chart', 'ephemeris', 'astrology', 'sun', 'moon', 'rising', 'planets', 'zodiac'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NatalChartScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_synastry',
      title: 'Lunar Synastry & Compatibility',
      subtitle: 'Celestial dual-chart scrying, planetary aspects, elemental alchemy & Tarot bonds',
      iconGlyph: '💞',
      iconData: Icons.favorite_border,
      accentColor: const Color(0xFFFF758F),
      category: SanctumCategory.celestial,
      badgeText: 'SYNASTRY',
      searchKeywords: ['synastry', 'compatibility', 'lunar', 'relationship', 'love', 'aspects', 'twin flame', 'partner'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LunarSynastryScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_cosmic_reminders',
      title: 'Cosmic Horary Reminders',
      subtitle: 'Morning guidance alerts, New & Full Moon peaks & Sabbat eves',
      iconGlyph: '🔔',
      iconData: Icons.notifications_active_outlined,
      accentColor: const Color(0xFFFFD166),
      category: SanctumCategory.celestial,
      badgeText: 'NOTIFICATIONS',
      searchKeywords: ['notifications', 'reminders', 'horary', 'morning', 'sabbat eves', 'full moon alert'],
      onOpen: (context, ref) {
        CosmicNotificationModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_collective_sanctuary',
      title: 'Collective Consciousness',
      subtitle: 'Live global tarot draw heatmap & worldwide intention well',
      iconGlyph: '✨',
      iconData: Icons.public,
      accentColor: const Color(0xFF64DFDF),
      category: SanctumCategory.celestial,
      badgeText: 'GLOBAL WELL',
      searchKeywords: ['collective', 'consciousness', 'global', 'heatmap', 'intentions', 'world', 'synastry'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CollectiveSanctuaryScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_oracle_personas',
      title: 'Archetypal Oracle Personas',
      subtitle: '5 divine channeling voices with calibrated solfeggio timbres',
      iconGlyph: '👑',
      iconData: Icons.face_retouching_natural,
      accentColor: const Color(0xFFFF9E7D),
      category: SanctumCategory.celestial,
      badgeText: '5 VOICES',
      searchKeywords: ['persona', 'voices', 'high priestess', 'hermit', 'empress', 'magician', 'shadow mirror', 'timbre'],
      onOpen: (context, ref) {
        OraclePersonaSelectorModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_celestial_transits',
      title: 'Live Celestial Transits & Planetary Hours',
      subtitle: 'Real-time 7-planet sky coordinates, Chaldean hour rulers & natal transit aspects',
      iconGlyph: '🪐',
      iconData: Icons.auto_awesome_rounded,
      accentColor: const Color(0xFFFFD166),
      category: SanctumCategory.celestial,
      badgeText: 'SKY TRANSITS',
      searchKeywords: ['transit', 'ephemeris', 'planetary hours', 'aspects', 'conjunction', 'chaldean', 'planets'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CelestialTransitScreen()),
        );
      },
    ),

    // ==========================================
    // QUADRANT 3: INNER RITES & CONSECRATION
    // ==========================================
    SanctumItem(
      id: 'sanctuary_mystic_bazaar',
      title: 'Mystic Bazaar & Treasury',
      subtitle: 'Starlight Shards, 7-day intention candles, holographic foils & Twin Flame blueprints',
      iconGlyph: '🏛️',
      iconData: Icons.storefront_rounded,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.inner,
      badgeText: 'BAZAAR',
      searchKeywords: ['bazaar', 'treasury', 'shards', 'candles', 'foils', 'synastry', 'store', 'shop', 'offerings'],
      onOpen: (context, ref) {
        MysticBazaarModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_dream_journal',
      title: 'Astral Dream Journal & Decoder',
      subtitle: 'Jungian archetypal decoder linking nocturnal dreams to Tarot',
      iconGlyph: '🌌',
      iconData: Icons.bedtime_outlined,
      accentColor: const Color(0xFFC5A3FF),
      category: SanctumCategory.inner,
      badgeText: 'JUNGIAN AI',
      searchKeywords: ['dreams', 'journal', 'jungian', 'shadow', 'night', 'subconscious', 'dreamcatcher'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DreamJournalScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_audio_weaver',
      title: 'Sacred Audio Weaver Studio',
      subtitle: 'Multi-layer 432Hz/528Hz soundscape mixer with singing bowls, chimes & sleep timer',
      iconGlyph: '🪐',
      iconData: Icons.waves_rounded,
      accentColor: const Color(0xFFFFD700),
      category: SanctumCategory.inner,
      badgeText: 'AUDIO STUDIO',
      searchKeywords: ['audio', 'weaver', 'frequencies', 'soundscape', 'solfeggio', '432hz', '528hz', 'binaural', 'mixer', 'bowls', 'sleep timer'],
      onOpen: (context, ref) {
        SacredAudioWeaverModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_pathworkings',
      title: 'Archetypal Pathworkings',
      subtitle: '5 guided Major Arcana audio meditations with Solfeggio soundscapes',
      iconGlyph: '🧘',
      iconData: Icons.self_improvement,
      accentColor: const Color(0xFF70E000),
      category: SanctumCategory.inner,
      badgeText: '5 MEDITATIONS',
      searchKeywords: ['pathworking', 'meditation', 'solfeggio', 'audio journey', 'trance', 'sacred sound'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PathworkingSanctuaryScreen(
              onIntentionAnchored: (intention) {
                ref.read(readingNotifierProvider.notifier).setQuestion(intention);
              },
            ),
          ),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_breathing',
      title: 'Sacred 4-7-8 Intention Breath',
      subtitle: 'Concentric geometry breathing orb with tactile centering pulse',
      iconGlyph: '🫁',
      iconData: Icons.air,
      accentColor: const Color(0xFF48CAE4),
      category: SanctumCategory.inner,
      badgeText: '4-7-8 RITE',
      searchKeywords: ['breath', 'breathing', '4-7-8', 'pranayama', 'centering', 'calm', 'focus'],
      onOpen: (context, ref) {
        SacredBreathingModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_smudge',
      title: 'Altar Smudge & Herb Purification',
      subtitle: 'GPU smoke particle simulation with Palo Santo, White Sage & Copal',
      iconGlyph: '🪵',
      iconData: Icons.local_fire_department_outlined,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.inner,
      badgeText: 'SMOKE RITUAL',
      searchKeywords: ['smudge', 'purify', 'smoke', 'sage', 'palo santo', 'copal', 'consecration', 'incense'],
      onOpen: (context, ref) {
        SmokePurificationModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_crystal_grid',
      title: 'Cardinal Guardian Crystal Grid',
      subtitle: 'Configure 6 sacred elemental crystals across the 4 altar quadrants',
      iconGlyph: '💎',
      iconData: Icons.diamond_outlined,
      accentColor: const Color(0xFFE0AAFF),
      category: SanctumCategory.inner,
      badgeText: 'CRYSTAL GRID',
      searchKeywords: ['crystals', 'quartz', 'amethyst', 'tourmaline', 'citrine', 'lapis', 'grid', 'energy'],
      onOpen: (context, ref) {
        CrystalGridSheet.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_altar_cloths',
      title: 'Consecrated Altar Cloths',
      subtitle: '4 sacred fabric weaves: Obsidian Velvet, Sacred Silk & Starlight Satin',
      iconGlyph: '✨',
      iconData: Icons.table_restaurant,
      accentColor: const Color(0xFFDEB887),
      category: SanctumCategory.inner,
      badgeText: 'ALTAR WEAVE',
      searchKeywords: ['cloth', 'altar cloth', 'velvet', 'silk', 'sri yantra', 'zodiac wheel', 'sacred fabric'],
      onOpen: (context, ref) {
        AltarClothSelectorModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_ritual_forge',
      title: 'Seeker Rituals & Consecration Spells',
      subtitle: 'Multi-step esoteric rites, Solfeggio attunements, crystal smudging & custom spell weaver',
      iconGlyph: '📜',
      iconData: Icons.auto_fix_high_rounded,
      accentColor: const Color(0xFFFFD166),
      category: SanctumCategory.inner,
      badgeText: 'RITUAL FORGE',
      searchKeywords: ['ritual', 'spell', 'consecration', 'solfeggio', 'attunement', 'incantation', 'forge', 'custom'],
      onOpen: (context, ref) {
        CustomRitualForgeModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_card_backs',
      title: 'Card Back Sacred Geometries',
      subtitle: '4 3D flippable talismans: Eye of Providence, Metatron & Ouroboros',
      iconGlyph: '👁️',
      iconData: Icons.style,
      accentColor: const Color(0xFFE2B770),
      category: SanctumCategory.inner,
      badgeText: 'TALISMAN BACKS',
      searchKeywords: ['card backs', 'talismans', 'metatron', 'providence', 'ouroboros', 'sacred geometry'],
      onOpen: (context, ref) {
        CardBackSelectorModal.show(context);
      },
    ),

    // ==========================================
    // QUADRANT 4: CODEX, GRIMOIRE & STUDIO
    // ==========================================
    SanctumItem(
      id: 'sanctuary_codex',
      title: 'Sacred Tarot Codex',
      subtitle: 'Complete 78-card encyclopedia with audio wisdom & archetype inspector',
      iconGlyph: '📖',
      iconData: Icons.menu_book,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.grimoire,
      badgeText: '78 CARDS',
      searchKeywords: ['codex', 'encyclopedia', 'cards', 'major arcana', 'minor arcana', 'wands', 'cups', 'swords', 'pentacles'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const TarotCodexScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_journal_history',
      title: 'Reading Journal & History',
      subtitle: 'Biometric-protected vault of past readings, reflections & stalker cards',
      iconGlyph: '📜',
      iconData: Icons.auto_stories,
      accentColor: const Color(0xFF50E3C2),
      category: SanctumCategory.grimoire,
      badgeText: 'HISTORY VAULT',
      searchKeywords: ['journal', 'history', 'past readings', 'notes', 'vault', 'starred readings'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ReadingsHistoryScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_seekers_chronicle',
      title: "The Seeker's Chronicle",
      subtitle: 'Multi-chapter weekly & monthly destiny synthesis report',
      iconGlyph: '📑',
      iconData: Icons.history_edu,
      accentColor: const Color(0xFF8338EC),
      category: SanctumCategory.grimoire,
      badgeText: 'DESTINY REPORT',
      searchKeywords: ['chronicle', 'weekly report', 'monthly report', 'destiny', 'chapter', 'synthesis'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SeekersChronicleScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_custom_spreads',
      title: "Seeker's Grimoire (Spread Builder)",
      subtitle: 'Forge custom 1-10 card layouts with personalized intentions',
      iconGlyph: '🖋️',
      iconData: Icons.dashboard_customize_outlined,
      accentColor: const Color(0xFFFFB703),
      category: SanctumCategory.grimoire,
      badgeText: 'SPREAD FORGE',
      searchKeywords: ['spreads', 'builder', 'grimoire', 'custom spread', 'layout', 'intentions'],
      onOpen: (context, ref) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CustomSpreadBuilderScreen()),
        );
      },
    ),
    SanctumItem(
      id: 'sanctuary_wallpaper_studio',
      title: 'Sacred 4K Wallpaper Studio',
      subtitle: 'Ultra-high-resolution lock screen generator with live ephemeris badges',
      iconGlyph: '📱',
      iconData: Icons.wallpaper,
      accentColor: const Color(0xFF3A86FF),
      category: SanctumCategory.grimoire,
      badgeText: '4K WALLPAPERS',
      searchKeywords: ['wallpaper', 'lock screen', '4k', 'background', 'export', 'artwork'],
      onOpen: (context, ref) {
        WallpaperStudioScreen.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_home_widget',
      title: 'Daily Mystic Home Widget',
      subtitle: 'Live Card of the Day, lunar ephemeris & daily affirmation for phone home screen',
      iconGlyph: '📱',
      iconData: Icons.widgets,
      accentColor: const Color(0xFFE0C068),
      category: SanctumCategory.grimoire,
      badgeText: 'HOME WIDGET',
      searchKeywords: ['widget', 'home screen', 'card of the day', 'daily card', 'appwidget', 'android', 'ios', 'quick access'],
      onOpen: (context, ref) {
        MysticWidgetHubModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_deck_styles',
      title: 'Deck Sanctuary & Aesthetics',
      subtitle: '5 collectible visual decks: Whispers & Warnings, Sapphire, Vintage 1909',
      iconGlyph: '🎨',
      iconData: Icons.auto_awesome,
      accentColor: const Color(0xFFD4AF37),
      category: SanctumCategory.grimoire,
      badgeText: '5 ART STYLES',
      searchKeywords: ['deck styles', 'themes', 'art', 'whispers and warnings', 'sapphire', 'vintage', 'luminary'],
      onOpen: (context, ref) {
        DeckSwitcherModal.show(context);
      },
    ),
    SanctumItem(
      id: 'sanctuary_live_reader',
      title: 'Consult a Live Mystic Reader',
      subtitle: 'Connect with a certified human tarot master or astrologer',
      iconGlyph: '🔮',
      iconData: Icons.support_agent,
      accentColor: const Color(0xFFFF006E),
      category: SanctumCategory.grimoire,
      badgeText: 'LIVE HUMAN',
      searchKeywords: ['live reader', 'human psychic', 'tarot master', 'astrologer', 'consultation'],
      onOpen: (context, ref) {
        ExternalLaunchService.openLiveReader(context);
      },
    ),
  ];

  /// Returns all core sanctuaries belonging to a specific quadrant category.
  static List<SanctumItem> getCategoryItems(SanctumCategory category) {
    return allSanctuaries.where((item) => item.category == category).toList();
  }

  /// High-performance universal Omni-Search indexing:
  /// 1. All Sanctuaries & Tools
  /// 2. All 78 Tarot Cards (Codex direct jump)
  /// 3. All 24 Elder Futhark Runes (Rune casting jump)
  /// 4. All 64 I Ching Hexagrams (I Ching jump)
  /// 5. Jungian Dream Symbols (Dream Journal jump)
  /// 6. Wheel of the Year Sabbats (Lunar Almanac jump)
  /// 7. Archetypal Pathworkings (Meditation sanctuary jump)
  static List<SanctumItem> omniSearch(String rawQuery, {int limit = 30}) {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) return const [];

    final List<SanctumItem> results = [];

    // 1. Search core sanctuaries first
    for (final item in allSanctuaries) {
      if (item.matches(query)) {
        results.add(item);
      }
    }

    // 2. Search 78 Tarot Cards
    for (final card in TarotCardData.allCards) {
      final nameMatch = card.name.toLowerCase().contains(query);
      final elementMatch = card.element?.toLowerCase().contains(query) ?? false;
      final astrologyMatch = card.astrology?.toLowerCase().contains(query) ?? false;
      final keywordMatch = card.keywords.any((k) => k.toLowerCase().contains(query));
      final meaningMatch = card.meaningUpright.toLowerCase().contains(query);

      if (nameMatch || elementMatch || astrologyMatch || keywordMatch || meaningMatch) {
        results.add(
          SanctumItem(
            id: 'card_${card.id}',
            title: card.name,
            subtitle: '${card.arcana.toUpperCase()} ARCANA · ${card.element ?? "COSMIC"} · ${card.keywords.take(3).join(", ")}',
            iconGlyph: card.arcana == 'major' ? '🎴' : '🃏',
            iconData: Icons.style,
            accentColor: const Color(0xFFD4AF37),
            category: SanctumCategory.grimoire,
            type: SanctumResultType.tarotCard,
            badgeText: card.arcana == 'major' ? 'MAJOR ARCANA' : 'MINOR ARCANA',
            searchKeywords: [
              card.name,
              card.arcana,
              if (card.element != null) card.element!,
              if (card.astrology != null) card.astrology!,
              ...card.keywords,
            ],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              TarotCodexScreen.showCardInspection(context, ref, card);
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    // 3. Search 24 Elder Futhark Runes
    for (final rune in RuneData.allRunes) {
      final nameMatch = rune.name.toLowerCase().contains(query);
      final englishMatch = rune.englishMeaning.toLowerCase().contains(query);
      final symbolMatch = rune.symbol.contains(query);
      final meaningMatch = rune.uprightMeaning.toLowerCase().contains(query);

      if (nameMatch || englishMatch || symbolMatch || meaningMatch) {
        results.add(
          SanctumItem(
            id: 'rune_${rune.id}',
            title: '${rune.symbol} ${rune.name}',
            subtitle: '${rune.englishMeaning} · ${rune.aett}',
            iconGlyph: rune.symbol,
            iconData: Icons.brightness_high,
            accentColor: const Color(0xFFE2B770),
            category: SanctumCategory.divination,
            type: SanctumResultType.rune,
            badgeText: 'ELDER RUNE',
            searchKeywords: [rune.name, rune.englishMeaning, rune.aett, rune.symbol],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RuneCastingScreen()),
              );
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    // 4. Search I Ching Hexagrams
    for (final hex in IChingData.primaryHexagrams) {
      final nameMatch = hex.name.toLowerCase().contains(query);
      final titleMatch = hex.englishTitle.toLowerCase().contains(query);
      final numMatch = hex.number.toString() == query;
      final charMatch = hex.chineseCharacter.contains(query);

      if (nameMatch || titleMatch || numMatch || charMatch) {
        results.add(
          SanctumItem(
            id: 'iching_${hex.number}',
            title: '${hex.chineseCharacter} Hexagram ${hex.number}: ${hex.name}',
            subtitle: '${hex.englishTitle} · ${hex.upperTrigram} over ${hex.lowerTrigram}',
            iconGlyph: '☯',
            iconData: Icons.change_circle_outlined,
            accentColor: const Color(0xFFD4AF37),
            category: SanctumCategory.divination,
            type: SanctumResultType.hexagram,
            badgeText: 'I CHING',
            searchKeywords: [hex.name, hex.englishTitle, hex.upperTrigram, hex.lowerTrigram, hex.number.toString()],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const IChingScreen()),
              );
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    // 5. Search Jungian Dream Symbols
    for (final sym in JungianArchetypes.allSymbols) {
      final nameMatch = sym.name.toLowerCase().contains(query);
      final archMatch = sym.archetype.toLowerCase().contains(query);
      final cardMatch = sym.tarotCardName.toLowerCase().contains(query);
      final meaningMatch = sym.meaning.toLowerCase().contains(query);

      if (nameMatch || archMatch || cardMatch || meaningMatch) {
        results.add(
          SanctumItem(
            id: 'dream_${sym.key}',
            title: '${sym.icon} ${sym.name}',
            subtitle: '${sym.archetype} · Channels ${sym.tarotCardName}',
            iconGlyph: sym.icon,
            iconData: Icons.bedtime_outlined,
            accentColor: const Color(0xFFC5A3FF),
            category: SanctumCategory.inner,
            type: SanctumResultType.dreamSymbol,
            badgeText: 'DREAM SYMBOL',
            searchKeywords: [sym.name, sym.archetype, sym.tarotCardName, sym.key],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DreamJournalScreen()),
              );
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    // 6. Search Wheel of the Year Sabbats
    for (final sab in SabbatCalendar.sabbats) {
      final nameMatch = sab.name.toLowerCase().contains(query);
      final themeMatch = sab.seasonalTheme.toLowerCase().contains(query);
      final ritualMatch = sab.ritualFocus.toLowerCase().contains(query);

      if (nameMatch || themeMatch || ritualMatch) {
        results.add(
          SanctumItem(
            id: 'sabbat_${sab.name.toLowerCase()}',
            title: '✦ Sabbat: ${sab.name}',
            subtitle: '${sab.dateDescription} · ${sab.seasonalTheme}',
            iconGlyph: '🌿',
            iconData: Icons.nature,
            accentColor: const Color(0xFF8AB4F8),
            category: SanctumCategory.celestial,
            type: SanctumResultType.sabbat,
            badgeText: 'SABBAT',
            searchKeywords: [sab.name, sab.seasonalTheme, sab.dateDescription, sab.recommendedSpreadTitle],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LunarAlmanacScreen()),
              );
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    // 7. Search Archetypal Pathworkings
    for (final pw in ArchetypalPathworking.allPathworkings) {
      final titleMatch = pw.title.toLowerCase().contains(query);
      final cardMatch = pw.cardName.toLowerCase().contains(query);
      final archMatch = pw.archetype.toLowerCase().contains(query);

      if (titleMatch || cardMatch || archMatch) {
        results.add(
          SanctumItem(
            id: 'pathworking_${pw.id}',
            title: pw.title,
            subtitle: '${pw.cardName} · ${pw.archetype} · ${pw.soundscapeName}',
            iconGlyph: '🧘',
            iconData: Icons.self_improvement,
            accentColor: const Color(0xFF70E000),
            category: SanctumCategory.inner,
            type: SanctumResultType.pathworking,
            badgeText: 'PATHWORKING',
            searchKeywords: [pw.title, pw.cardName, pw.archetype, pw.soundscapeName],
            onOpen: (context, ref) {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PathworkingSanctuaryScreen(
                    onIntentionAnchored: (intention) {
                      ref.read(readingNotifierProvider.notifier).setQuestion(intention);
                    },
                  ),
                ),
              );
            },
          ),
        );
      }
      if (results.length >= limit) return results;
    }

    return results;
  }
}
