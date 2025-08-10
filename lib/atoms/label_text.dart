import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TextLabel(this.text, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style ?? const TextStyle(fontSize: 16));
  }
}
