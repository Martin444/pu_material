import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        final textScaleFactor = isDesktop ? 1.0 : (isTablet ? 0.95 : 0.9);
        final baseFontSize = fontSize ?? (PuTextStyle.ingredientsListStyle.fontSize ?? 12);
        final horizontalPadding = isDesktop ? 8.0 : 6.0;
        final verticalPadding = isDesktop ? 3.0 : 2.0;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: PuTextStyle.ingredientsListStyle.copyWith(
              fontSize: baseFontSize * textScaleFactor,
              color: textColor ?? Colors.grey[700],
            ),
          ),
        );
      },
    );
  }
}
