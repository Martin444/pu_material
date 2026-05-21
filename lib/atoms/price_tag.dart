import 'package:flutter/material.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';

class PriceTag extends StatelessWidget {
  final double price;

  const PriceTag(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(price.toCurrency(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }
}
