import 'package:flutter/material.dart';
import '../atoms/info_badge.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

/// Section Header Molecule - A header with title and optional badge
class SectionHeader extends StatelessWidget {
  final String title;
  final String? badgeText;
  final TextStyle? titleStyle;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.badgeText,
    this.titleStyle,
    this.badgeBackgroundColor,
    this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ?? PuTextStyle.title2.copyWith(
              fontSize: 22,
              color: PUColors.textColorRich,
            ),
          ),
          if (badgeText != null)
            InfoBadge(
              text: badgeText!,
              backgroundColor: badgeBackgroundColor ?? PUColors.accentColor.withValues(alpha: 0.1),
              textColor: badgeTextColor ?? PUColors.accentColor,
            ),
        ],
      ),
    );
  }
}
