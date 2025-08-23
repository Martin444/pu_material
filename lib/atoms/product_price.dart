import 'package:flutter/material.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        final textScaleFactor = isDesktop ? 1.1 : (isTablet ? 1.0 : 0.95);
        final baseFontSize = fontSize ?? PuTextStyle.namePriceCardStyle.fontSize ?? 14;

        return Text(
          price.toString().convertToCorrency(),
          textAlign: textAlign ?? TextAlign.start,
          style: PuTextStyle.namePriceCardStyle.copyWith(
            fontSize: baseFontSize * textScaleFactor,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: color ?? Colors.green[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
