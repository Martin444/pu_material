import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;

  const PriceTag(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }
}
