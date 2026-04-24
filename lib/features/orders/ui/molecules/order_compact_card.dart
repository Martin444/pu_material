import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';

class OrderCompactCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;

  const OrderCompactCard(this.order, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(order.numero),
        subtitle: Text(order.detalle),
        trailing: Text('\$${(order.totalCentavos / 100).toStringAsFixed(2)}'),
        onTap: onTap,
      ),
    );
  }
}