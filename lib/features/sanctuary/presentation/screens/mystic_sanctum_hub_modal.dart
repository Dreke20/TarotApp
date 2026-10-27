import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../../tarot/presentation/widgets/mystic_background.dart';
import '../../data/sanctum_catalog.dart';
import '../../domain/sanctum_item.dart';
import '../widgets/sanctum_item_card.dart';

/// The unified Mystic Sanctum Hub & Omni-Portal Modal.
///
/// Provides instant categorized discovery across all 25+ sanctuaries, tools,
/// and live omni-search across the entire esoteric canon (78 Tarot Cards,
/// 24 Elder Runes, 64 Hexagrams, Dream Symbols, Sabbats & Pathworkings).
class MysticSanctumHubModal extends ConsumerStatefulWidget {
  const MysticSanctumHubModal({super.key});

  /// Presents the full-height sacred sanctum hub.
  static Future<void> show(BuildContext context) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (_) => const MysticSanctumHubModal(),
    );
  }

  @override
  ConsumerState<MysticSanctumHubModal> createState() =>
      _MysticSanctumHubModalState();
}

class _MysticSanctumHubModalState extends ConsumerState<MysticSanctumHubModal> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  SanctumCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final text = _searchController.text;
      if (text != _query) {
        setState(() {
          _query = text;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isSearching = _query.trim().isNotEmpty;
    final searchResults = isSearching ? SanctumCatalog.omniSearch(_query) : const <SanctumItem>[];

    return Container(
      height: media.size.height * 0.92,
      decoration: const BoxDecoration(
        color: AppColors.backgroundMidnight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: Stack(
          children: [
            // Ethereal Mystic Nebula Backdrop
            const Positioned.fill(
              child: Opacity(
                opacity: 0.35,
                child: MysticBackground(child: SizedBox.expand()),
              ),
            ),

            SafeArea(
              top: false,
              child: Column(
                children: [
                  // Drag Handle
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.goldBright.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Header Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.goldBright.withValues(alpha: 0.15),
                                border: Border.all(
                                  color: AppColors.goldBright.withValues(alpha: 0.6),
                                  width: 1.2,
                                ),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                size: 16,
                                color: AppColors.goldBright,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MYSTIC SANCTUM',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.goldBright,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                Text(
                                  'SACRED REALMS & ESOTERIC OMNI-PORTAL',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textMuted,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                            size: 22,
                          ),
                          tooltip: 'Close Sanctum',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Omni-Search Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GlassContainer(
                      borderRadius: 18,
                      fillColor: AppColors.cosmicSurface.withValues(alpha: 0.85),
                      borderColor: _query.isNotEmpty
                          ? AppColors.goldBright
                          : AppColors.glassBorder,
                      borderWidth: _query.isNotEmpty ? 1.4 : 1.0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 20,
                            color: _query.isNotEmpty
                                ? AppColors.goldBright
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.5,
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Seek any card, rune, hexagram, or sanctuary...',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5,
                                  color: AppColors.textMuted,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              key: const Key('omni_search_clear_button'),
                              onTap: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Main View: Search Results OR Categorized Sanctuary Quadrants
                  Expanded(
                    child: isSearching
                        ? _buildSearchResults(searchResults)
                        : _buildCategorizedSanctuaryView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// View displayed when seeker is typing in the Omni-Portal search bar.
  Widget _buildSearchResults(List<SanctumItem> results) {
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.goldBright.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppColors.goldBright.withValues(alpha: 0.35),
                  ),
                ),
                child: const Center(
                  child: Text('🌌', style: TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'NO RESONANCES DISCOVERED',
                style: GoogleFonts.cinzel(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'The cosmic ether reveals no matches for "$_query". Try seeking by name, archetype, or element:',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildSearchSuggestionChip('The Star'),
                  _buildSearchSuggestionChip('Fehu'),
                  _buildSearchSuggestionChip('I Ching'),
                  _buildSearchSuggestionChip('Samhain'),
                  _buildSearchSuggestionChip('Water'),
                  _buildSearchSuggestionChip('AR Altar'),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '✦ ${results.length} ESOTERIC RESONANCES DISCOVERED ✦',
                style: GoogleFonts.cinzel(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldBright,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'TAP TO ENTER',
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            physics: const BouncingScrollPhysics(),
            itemCount: results.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return SanctumItemCard(item: results[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        SensoryService().cardSelectionHaptic();
        _searchController.text = text;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.glassFillStrong,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.goldBright.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: AppColors.goldBright,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Default view organized across the 4 sacred quadrants when not searching.
  Widget _buildCategorizedSanctuaryView() {
    final categories = _selectedCategory != null
        ? [_selectedCategory!]
        : SanctumCategory.values;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildCategoryTab(
                  label: 'ALL REALMS',
                  isSelected: _selectedCategory == null,
                  onTap: () => setState(() => _selectedCategory = null),
                ),
                ...SanctumCategory.values.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildCategoryTab(
                      label: '${cat.iconGlyph} ${cat.shortTitle.toUpperCase()}',
                      isSelected: _selectedCategory == cat,
                      accentColor: cat.accentColor,
                      onTap: () => setState(() => _selectedCategory = cat),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Quadrant Sections
          for (final cat in categories) ...[
            _buildQuadrantHeader(cat),
            const SizedBox(height: 10),
            ...SanctumCatalog.getCategoryItems(cat).map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SanctumItemCard(item: item),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryTab({
    required String label,
    required bool isSelected,
    Color? accentColor,
    required VoidCallback onTap,
  }) {
    final color = accentColor ?? AppColors.goldBright;
    return GestureDetector(
      onTap: () {
        SensoryService().cardSelectionHaptic();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.22)
              : AppColors.glassFillStrong,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? color : AppColors.glassBorder,
            width: isSelected ? 1.4 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.25),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.cinzel(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            color: isSelected ? color : AppColors.textSecondary,
            letterSpacing: 0.9,
          ),
        ),
      ),
    );
  }

  Widget _buildQuadrantHeader(SanctumCategory category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: category.accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: category.accentColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                category.iconGlyph,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                category.title.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: category.accentColor,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
            decoration: BoxDecoration(
              color: category.accentColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${SanctumCatalog.getCategoryItems(category).length} REALMS',
              style: GoogleFonts.cinzel(
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
                color: category.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
