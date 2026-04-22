import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

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
    return Text(
      title,
      style: PuTextStyle.nameProductStyle.copyWith(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? PUColors.textColorRich,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}
