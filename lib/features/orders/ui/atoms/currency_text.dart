import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final int centavos;
  final String currency;

  const CurrencyText(this.centavos, {this.currency = 'ARS'});

  @override
  Widget build(BuildContext context) {
    final value = centavos / 100;
    return Text('\$${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
  }
}