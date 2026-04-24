import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';
import 'package:pu_material/features/orders/ui/organisms/orders_table.dart';

class OrdersTemplate extends StatelessWidget {
  final List<Order> orders;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;

  const OrdersTemplate({
    required this.orders,
    this.isLoading = false,
    this.hasMore = false,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OrdersTable(data: orders)),
        if (isLoading) const CircularProgressIndicator(),
        if (hasMore)
          TextButton(
            onPressed: onLoadMore,
            child: const Text('Cargar más'),
          ),
      ],
    );
  }
}