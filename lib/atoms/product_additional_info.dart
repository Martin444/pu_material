import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:pu_material/utils/pu_colors.dart';

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
    final displayText = '${prefix ?? ''}$text';

    Widget textWidget = Text(
      displayText.toUpperCase(),
      style: PuTextStyle.bodySmall.copyWith(
        fontSize: 10,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
        color: textColor ?? PUColors.textColorMuted,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );

    if (showBackground) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor ?? PUColors.accentColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: textWidget,
      );
    }

    return textWidget;
  }
}
