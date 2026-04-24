import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';
import 'package:pu_material/features/orders/ui/atoms/cell_text.dart';
import 'package:pu_material/features/orders/ui/atoms/currency_text.dart';
import 'package:pu_material/features/orders/ui/molecules/status_badge.dart';

class OrdersTable extends StatelessWidget {
  final List<Order> data;
  final EdgeInsets? padding;

  const OrdersTable({required this.data, this.padding});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No hay órdenes'));
    }

    return ListView.builder(
      padding: padding ?? EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final order = data[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Row(
              children: [
                Text(order.numero, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                StatusBadge(order.estado),
              ],
            ),
            subtitle: Text(order.detalle),
            trailing: CurrencyText(order.totalCentavos),
          ),
        );
      },
    );
  }
}