import 'package:flutter/material.dart';
import 'package:pu_material/atoms/label_text.dart';
import 'package:pu_material/atoms/price_tag.dart';

class OrderItemCard extends StatelessWidget {
  final String title;
  final int quantity;
  final double price;

  const OrderItemCard({
    required this.title,
    required this.quantity,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextLabel(title),
      subtitle: TextLabel('Cantidad: $quantity'),
      trailing: PriceTag(price),
    );
  }
}
