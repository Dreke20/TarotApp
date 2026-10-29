import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_config.dart';
import '../../tarot/data/tarot_card_data.dart';
import '../../tarot/domain/tarot_card.dart';
import '../domain/tarot_lens_scan_result.dart';

/// What Gemini recognized in a card photo.
class TarotLensIdentification {
  final TarotCard card;
  final bool isReversed;
  final int confidencePercent;
  final List<String> visibleSymbols;

  const TarotLensIdentification({
    required this.card,
    required this.isReversed,
    required this.confidencePercent,
    this.visibleSymbols = const [],
  });
}

/// About 1.5 MB (1.5 * 1024 * 1024). Photos are compressed before this check.
const int kMaxLensImageBytes = 1572864;

bool lensImageWithinCap(int byteLength) =>
    byteLength >= 0 && byteLength <= kMaxLensImageBytes;

/// Service responsible for real-world photo capture and multimodal card scrying.
class TarotLensService {
  /// Confidence used when the seeker picked the card themselves.
  static const int manualSelectionConfidence = 100;

  /// Confidence used when the photo could not be recognized.
  static const int unrecognizedConfidence = 0;

  /// Below this, the Lens asks the seeker to confirm the card.
  static const int highConfidenceThreshold = 75;

  final ImagePicker _picker;
  final SupabaseClient? client;

  TarotLensService({ImagePicker? picker, this.client})
      : _picker = picker ?? ImagePicker();

  /// Sends the photo to the `tarot-reader` Edge Function, which asks Gemini
  /// which card it shows. Returns null when recognition is unavailable or
  /// the card could not be identified, so the seeker can pick it manually.
  Future<TarotLensIdentification?> identifyCard(String imagePath) async {
    if (!SupabaseConfig.isConfigured) return null;
    SupabaseClient supabase;
    try {
      supabase = client ?? Supabase.instance.client;
    } catch (_) {
      return null;
    }

    try {
      final bytes = await XFile(imagePath).readAsBytes();
      if (!lensImageWithinCap(bytes.length)) {
        debugPrint('Tarot Lens photo is over 1.5 MB after compression.');
        return null;
      }
      final lower = imagePath.toLowerCase();
      final mimeType = lower.endsWith('.png')
          ? 'image/png'
          : lower.endsWith('.webp')
              ? 'image/webp'
              : lower.endsWith('.heic')
                  ? 'image/heic'
                  : 'image/jpeg';

      final response = await supabase.functions.invoke(
        'tarot-reader',
        body: {
          'lens_image_base64': base64Encode(bytes),
          'lens_mime_type': mimeType,
          'card_catalog': TarotCardData.allCards
              .map((c) => {'id': c.id, 'name': c.name})
              .toList(),
        },
      );
      if (response.status != 200 || response.data == null) return null;

      final data = response.data is String
          ? jsonDecode(response.data as String)
          : response.data;
      if (data is! Map) return null;

      final id = data['card_id'];
      if (id is! String) return null;
      final matches = TarotCardData.allCards.where((c) => c.id == id);
      if (matches.isEmpty) return null;

      final rawConfidence = data['confidence'];
      final confidence = rawConfidence is num
          ? rawConfidence.round().clamp(1, 99)
          : 50;
      final symbols = data['visible_symbols'] is List
          ? (data['visible_symbols'] as List).whereType<String>().toList()
          : <String>[];

      return TarotLensIdentification(
        card: matches.first,
        isReversed: data['is_reversed'] == true,
        confidencePercent: confidence,
        visibleSymbols: symbols,
      );
    } catch (e) {
      debugPrint('Tarot Lens recognition failed: $e');
      return null;
    }
  }

  /// Captures a card photo using the device camera
  Future<String?> captureFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 1024,
        maxHeight: 1365,
      );
      return file?.path;
    } catch (_) {
      return null;
    }
  }

  /// Selects an existing card photo from device gallery
  Future<String?> selectFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxWidth: 1024,
        maxHeight: 1365,
      );
      return file?.path;
    } catch (_) {
      return null;
    }
  }

  /// Analyzes a physical card image or card selection and generates deep optical scrying analysis
  Future<TarotLensScanResult> analyzeCard({
    String? imagePath,
    TarotCard? preferredCard,
    bool isReversed = false,
    int confidencePercent = manualSelectionConfidence,
    List<String> visibleSymbols = const [],
  }) async {
    // If a card is explicitly selected or preferred, match it
    final card = preferredCard ?? TarotCardData.allCards.first;

    // Real confidence comes from Gemini; manual picks are certain by definition.
    final confidence = confidencePercent;

    // Prefer symbols Gemini actually saw in the photo, else the card's canon.
    final symbols =
        visibleSymbols.isNotEmpty ? visibleSymbols : _extractCardSymbols(card);

    // Generate physical altar practice
    final ritual = _generateAltarPractice(card, isReversed);

    // Generate deep scrying analysis
    final scrying = _generateScryingAnalysis(card, isReversed);

    return TarotLensScanResult(
      card: card.copyWith(isReversed: isReversed),
      confidencePercent: confidence,
      isReversed: isReversed,
      detectedSymbols: symbols,
      scryingAnalysis: scrying,
      physicalAltarRitual: ritual,
      capturedImagePath: imagePath,
      isHighConfidence: confidence >= highConfidenceThreshold,
    );
  }

  List<String> _extractCardSymbols(TarotCard card) {
    final name = card.name.toLowerCase();
    final suit = card.suit?.toLowerCase() ?? '';

    if (name.contains('fool')) {
      return const ['White Rose of Purity', 'Feathered Cap', 'Precipice Threshold', 'Faithful White Dog'];
    } else if (name.contains('magician')) {
      return const ['Infinity Lemniscate', 'Wand Raised to Heaven', 'Four Altar Elements', 'Ouroboros Girdle'];
    } else if (name.contains('priestess')) {
      return const ['Twin Pillars of Boaz & Jachin', 'Crescent Moon at Feet', 'Pomegranate Veil', 'Scroll of Hidden Law'];
    } else if (name.contains('empress')) {
      return const ['Twelve-Star Crown', 'Venusian Shield', 'Golden Wheat Field', 'Flowing Waterfall'];
    } else if (name.contains('emperor')) {
      return const ['Ram-Headed Stone Throne', 'Imperial Golden Scepter', 'Fiery Armor', 'Barren Mountain Fortress'];
    } else if (name.contains('hierophant')) {
      return const ['Triple Papal Cross', 'Two Sacred Keys of Heaven', 'Twin Acolytes', 'Temple Pillars'];
    } else if (name.contains('lovers')) {
      return const ['Angel Raphael in Radiance', 'Tree of Life & Tree of Knowledge', 'Mountain of Aspiration', 'Sacred Union'];
    } else if (name.contains('chariot')) {
      return const ['Black & White Sphinxes', 'Starry Canopy Mantle', 'Golden Armor of Victory', 'Walled Castle Moat'];
    } else if (name.contains('strength')) {
      return const ['Golden Lemniscate Crown', 'Gentle Tamed Lion', 'Garland of Fresh Roses', 'Pure White Robe'];
    } else if (name.contains('hermit')) {
      return const ['Six-Pointed Star Lantern', 'Golden Staff of Authority', 'Snowy Mountain Peak', 'Mantle of Solitude'];
    } else if (name.contains('wheel')) {
      return const ['Sphinx of Equilibrium', 'Hebrew Tetragrammaton', 'Anubis & Typhon', 'Four Winged Creatures'];
    } else if (name.contains('death')) {
      return const ['Mystic White Rose Banner', 'Pale Horse of Transition', 'Rising Sun Between Towers', 'River of Rebirth'];
    } else if (name.contains('star')) {
      return const ['Eight-Pointed Guiding Star', 'Twin Pitchers of Life', 'Ibis Bird in Sacred Tree', 'Pool of Pure Subconscious'];
    } else if (name.contains('moon')) {
      return const ['Twin Watchtowers', 'Howling Wolf & Dog', 'Crawling Crayfish of Primal Mind', 'Yod Droplets of Divine Dew'];
    } else if (name.contains('sun')) {
      return const ['Radiant Solar Disk', 'Joyful Child on White Horse', 'Four Golden Sunflowers', 'Crimson Banner of Life'];
    } else if (name.contains('world')) {
      return const ['Laurel Wreath of Wholeness', 'Twin Golden Wands', 'Four Cherubic Guardians', 'Cosmic Dancer'];
    }

    // Minor Arcana symbol extraction by suit
    if (suit == 'wands') {
      return [
        'Living Sprouting Wand (${card.keywords.take(1).firstOrNull ?? "Willpower"})',
        'Flaring Solar Fire Element',
        'Salamander of Alchemical Will',
        'Golden Filigree of Action',
      ];
    } else if (suit == 'cups') {
      return [
        'Sacred Chalice of Emotion (${card.keywords.take(1).firstOrNull ?? "Intuition"})',
        'Ethereal Water Current',
        'Lotus & Water Lily Petals',
        'Silver Ocean Light',
      ];
    } else if (suit == 'swords') {
      return [
        'Double-Edged Steel Blade (${card.keywords.take(1).firstOrNull ?? "Truth"})',
        'Billowing Wind & Cloud Tracery',
        'Piercing Mountain Sunbeam',
        'Gilded Hilt of Discrimination',
      ];
    } else {
      return [
        'Golden Pentagram Coin (${card.keywords.take(1).firstOrNull ?? "Abundance"})',
        'Fertile Earth & Grapevine Leaves',
        'Ancient Stone Sanctuary Arch',
        'Manifested Harvest of Form',
      ];
    }
  }

  String _generateScryingAnalysis(TarotCard card, bool isReversed) {
    final orientationText = isReversed ? 'in its reversed, inward shadow aspect' : 'in its upright, radiant manifestation';
    final meaning = isReversed ? card.meaningReversed : card.meaningUpright;

    return '${card.name} has entered your physical sanctum $orientationText. '
        'In physical cartomancy, this card arriving upon your real-world altar signals: $meaning. '
        'The ether surrounding you is aligning with the ${card.element ?? "Cosmic"} current. '
        'Take note of the room’s ambient light and the thoughts currently occupying your mind—they hold the golden key to this threshold.';
  }

  String _generateAltarPractice(TarotCard card, bool isReversed) {
    final suit = card.suit?.toLowerCase() ?? '';
    final isMajor = card.arcana.toLowerCase() == 'major';

    if (isMajor) {
      return 'Center Altar Practice: Place ${card.name} in the sacred center of your altar cloth. Light a deep violet or white beeswax candle and burn sacred Golden Copal or Frankincense. Anchor the card’s four corners with Clear Quartz and Amethyst to integrate its archetypal initiation.';
    }

    if (suit == 'wands') {
      return 'Southern Fire Gate: Prop ${card.name} facing South. Light a warm gold or crimson candle, burn sacred Palo Santo or Cedarwood, and place a sunlit Citrine or Carnelian stone upon the card to ignite creative willpower and swift momentum.';
    } else if (suit == 'cups') {
      return 'Western Water Gate: Prop ${card.name} facing West beside a bowl of fresh spring water. Light a seafoam or azure candle, burn gentle Lavender & Mugwort, and rest a Moonstone or Rose Quartz near the card to deepen intuitive healing.';
    } else if (suit == 'swords') {
      return 'Eastern Air Gate: Prop ${card.name} facing East where morning breeze or sunlight enters. Light a pale yellow or lavender candle, burn sacred White Sage or Rosemary, and place a Clear Quartz point aimed upward to slice through mental illusions.';
    } else {
      return 'Northern Earth Gate: Prop ${card.name} facing North upon bare wood, slate, or stone. Light a forest-green or beeswax candle, burn earthy Atlas Cedarwood or Patchouli, and anchor with Black Tourmaline or Pyrite to manifest enduring material stability.';
    }
  }
}
