import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/sensory_service.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';
import '../../domain/sanctum_item.dart';

/// An atomic luxury card widget representing a sanctuary or search result.
class SanctumItemCard extends ConsumerWidget {
  final SanctumItem item;
  final VoidCallback? onCustomTap;

  const SanctumItemCard({
    super.key,
    required this.item,
    this.onCustomTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: item.accentColor.withValues(alpha: 0.15),
        highlightColor: item.accentColor.withValues(alpha: 0.08),
        onTap: () {
          SensoryService().cardSelectionHaptic();
          if (onCustomTap != null) {
            onCustomTap!();
          } else {
            Navigator.of(context).pop(); // dismiss sanctum modal
            item.onOpen(context, ref);
          }
        },
        child: GlassContainer(
          borderRadius: 16,
          fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.85),
          borderColor: item.accentColor.withValues(alpha: 0.35),
          borderWidth: 1.1,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Glyph Avatar
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.accentColor.withValues(alpha: 0.12),
                  border: Border.all(
                    color: item.accentColor.withValues(alpha: 0.55),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: item.accentColor.withValues(alpha: 0.25),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: item.iconData != null
                      ? Icon(item.iconData, color: item.accentColor, size: 20)
                      : Text(
                          item.iconGlyph,
                          style: TextStyle(
                            fontSize: 20,
                            color: item.accentColor,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Title, Subtitle & Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cinzel(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        if (item.badgeText != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: item.accentColor.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: item.accentColor.withValues(alpha: 0.6),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              item.badgeText!,
                              style: GoogleFonts.cinzel(
                                fontSize: 8.5,
                                fontWeight: FontWeight.bold,
                                color: item.accentColor,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Action Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: item.accentColor.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
