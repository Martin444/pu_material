import 'package:flutter/material.dart';

/// Widget atómico para celdas de tabla con padding y alineación configurables
class TableCellAtom extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Alignment alignment;

  const TableCellAtom({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
