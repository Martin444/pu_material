import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';

class ReceiptDialog extends StatelessWidget {
  final Order order;

  const ReceiptDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Order ${order.numero}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cliente: ${order.alias}'),
          Text('Estado: ${order.estado}'),
          Text('Total: \$${(order.totalCentavos / 100).toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          const Text('Detalles:'),
          Text(order.detalle),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
      ],
    );
  }
}