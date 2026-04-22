import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';

/// Átomo: Precio del producto
class ProductPrice extends StatelessWidget {
  final double price;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const ProductPrice({
    super.key,
    required this.price,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      price.toString().convertToCorrency(),
      textAlign: textAlign ?? TextAlign.start,
      style: PuTextStyle.title3.copyWith(
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? PUColors.accentColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
