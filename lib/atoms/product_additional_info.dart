import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

/// Átomo: Información adicional del producto (tiempo de entrega, marca, etc.)
class ProductAdditionalInfo extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final String? prefix;
  final int maxLines;
  final bool showBackground;

  const ProductAdditionalInfo({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.prefix,
    this.maxLines = 1,
    this.showBackground = false,
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
        final baseFontSize = PuTextStyle.ingredientsListStyle.fontSize ?? 12;
        final horizontalPadding = isDesktop ? 8.0 : 6.0;
        final verticalPadding = isDesktop ? 3.0 : 2.0;

        final displayText = '${prefix ?? ''}$text';

        Widget textWidget = Text(
          displayText.toUpperCase(),
          style: PuTextStyle.ingredientsListStyle.copyWith(
            fontSize: baseFontSize * textScaleFactor,
            color: textColor,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        );

        if (showBackground && backgroundColor != null) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: textWidget,
          );
        }

        return textWidget;
      },
    );
  }
}
