import 'package:flutter/material.dart';

/// Widget atómico para mostrar texto en celdas de tabla
class CellText extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final TextStyle? style;
  final int maxLines;

  const CellText(
    this.text, {
    super.key,
    this.align,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
