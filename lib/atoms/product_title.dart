import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

/// Átomo: Título del producto
class ProductTitle extends StatelessWidget {
  final String title;
  final int maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const ProductTitle({
    super.key,
    required this.title,
    this.maxLines = 2,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

        final textScaleFactor = isDesktop ? 1.1 : (isTablet ? 1.0 : 0.95);
        final baseFontSize = fontSize ?? PuTextStyle.nameProductStyle.fontSize ?? 16;

        return Text(
          title.toUpperCase(),
          style: PuTextStyle.nameProductStyle.copyWith(
            fontSize: baseFontSize * textScaleFactor,
            fontWeight: fontWeight,
            color: color,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
