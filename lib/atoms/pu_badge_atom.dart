import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

enum PuBadgeColor { success, warning, error, info, neutral }

class PuBadge extends StatelessWidget {
  final String label;
  final PuBadgeColor color;

  const PuBadge({
    super.key,
    required this.label,
    this.color = PuBadgeColor.info,
  });

  Color get _backgroundColor {
    switch (color) {
      case PuBadgeColor.success:
        return PUColors.successColor.withOpacity(0.15);
      case PuBadgeColor.warning:
        return PUColors.warningColor.withOpacity(0.15);
      case PuBadgeColor.error:
        return PUColors.errorColor.withOpacity(0.15);
      case PuBadgeColor.info:
        return PUColors.primaryColor.withOpacity(0.15);
      case PuBadgeColor.neutral:
        return PUColors.bgInput;
    }
  }

  Color get _foregroundColor {
    switch (color) {
      case PuBadgeColor.success:
        return PUColors.successColor;
      case PuBadgeColor.warning:
        return PUColors.warningColor;
      case PuBadgeColor.error:
        return PUColors.errorColor;
      case PuBadgeColor.info:
        return PUColors.primaryColor;
      case PuBadgeColor.neutral:
        return PUColors.textColor1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: PuTextStyle.description2.copyWith(
          color: _foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}