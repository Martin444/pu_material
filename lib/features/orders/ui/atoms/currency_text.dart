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
    // Detectar moneda basada en locale o usar una genérica si no se especifica
    final formatter = NumberFormat.currency(
      symbol: '€', // El usuario parece estar usando euros según el screenshot
      decimalDigits: 2,
      locale: 'es_ES',
    );
    
    return Text(
      formatter.format(centavos / 100.0),
      textAlign: align,
      style: style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
    );
  }
}
