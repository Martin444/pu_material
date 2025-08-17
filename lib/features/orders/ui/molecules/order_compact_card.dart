import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../atoms/cell_text.dart';
import '../atoms/currency_text.dart';
import '../molecules/status_badge.dart';

/// Widget molecular para mostrar una orden de forma compacta en vista móvil
class OrderCompactCard extends StatelessWidget {
  final Order order;

  const OrderCompactCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ExpansionTile(
        title: Row(
          children: [
            Text(
              '#${order.numero}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 8),
            StatusBadge(order.estado),
            const Spacer(),
            CurrencyText(
              order.totalCentavos,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        subtitle: CellText(order.detalle, maxLines: 1),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  context,
                  'Cliente',
                  order.idCliente,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  'Alias',
                  order.alias,
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  'Creado',
                  _formatRelative(order.creado),
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  'Detalle completo',
                  order.detalle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  String _formatRelative(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} horas';
    return 'Hace ${diff.inDays} días';
  }
}
