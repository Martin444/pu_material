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
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        final textScaleFactor = isDesktop ? 1.1 : (isTablet ? 1.0 : 0.95);
        final baseFontSize = fontSize ?? PuTextStyle.nameProductStyle.fontSize ?? 16;

        return Text(
          title,
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
