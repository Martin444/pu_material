import 'package:flutter/material.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';

class CurrencyText extends StatelessWidget {
  final int centavos;
  final String currency;

  const CurrencyText(this.centavos, {this.currency = 'ARS'});

  @override
  Widget build(BuildContext context) {
    final value = centavos / 100;
    return Text(value.toCurrency(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
  }
}