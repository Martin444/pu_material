import 'package:flutter/material.dart';

/// Info Badge Atom - A small badge displaying information with customizable styling
class InfoBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const InfoBadge({
    super.key,
    required this.text,
    this.backgroundColor = const Color(0xFFe3f2fd),
    this.textColor = const Color(0xFF1976d2),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.fontSize = 12,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
