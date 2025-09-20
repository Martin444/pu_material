import 'package:flutter/material.dart';
import '../atoms/info_badge.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        if (badgeText != null)
          InfoBadge(
            text: badgeText!,
            backgroundColor: badgeBackgroundColor ?? const Color(0xFFe3f2fd),
            textColor: badgeTextColor ?? const Color(0xFF1976d2),
          ),
      ],
    );
  }
}
