import 'package:flutter/material.dart';
import 'package:pu_material/atoms/label_text.dart';
import 'package:pu_material/atoms/price_tag.dart';
import 'package:pu_material/molecule/order_item_card.dart';

class OrderSummarySection extends StatelessWidget {
  final List<OrderItemCard> items;
  final double total;

  const OrderSummarySection({required this.items, required this.total, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map((item) => item.build(context)),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextLabel('Total'),
            PriceTag(total),
          ],
        ),
      ],
    );
  }
}
