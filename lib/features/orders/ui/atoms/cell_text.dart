import 'package:flutter/material.dart';

class CellText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CellText(this.text, {this.style});

  @override
  Widget build(BuildContext context) => Text(text, style: style ?? const TextStyle(fontSize: 14));
}