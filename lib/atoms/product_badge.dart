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
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

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
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: PuTextStyle.ingredientsListStyle.copyWith(
              fontSize: baseFontSize * textScaleFactor,
              color: textColor ?? Colors.grey[700],
            ),
            textAlign: TextAlign.start,
          ),
        );
      },
    );
  }
}
