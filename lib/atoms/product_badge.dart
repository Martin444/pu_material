import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

/// Átomo: Badge o etiqueta informativa
class ProductBadge extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;

  const ProductBadge({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? PUColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: PuTextStyle.bodySmall.copyWith(
          fontSize: fontSize ?? 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: textColor ?? PUColors.primaryColor,
        ),
      ),
    );
  }
}
