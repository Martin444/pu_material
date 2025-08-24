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
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

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
