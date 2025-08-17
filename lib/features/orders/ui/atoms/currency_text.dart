import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget atómico para mostrar moneda formateada
class CurrencyText extends StatelessWidget {
  final int centavos; // e.g., 3823200
  final TextStyle? style;
  final TextAlign? align;

  const CurrencyText(
    this.centavos, {
    super.key,
    this.style,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: 'es_AR');
    return Text(
      formatter.format(centavos / 100.0),
      textAlign: align,
      style: style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
    );
  }
}
