import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';
import 'package:pu_material/features/orders/ui/molecules/status_badge.dart';
import 'package:pu_material/molecule/admin_data_table_molecule.dart';

class OrdersTable extends StatelessWidget {
  final List<Order> data;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;
  final void Function(Order order)? onTap;

  const OrdersTable({
    required this.data,
    this.currentPage = 1,
    this.totalPages = 1,
    this.onPageChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No hay órdenes'));
    }

    return AdminDataTableMolecule(
      headers: const ['Orden', 'Cliente', 'Contacto', 'Estado', 'Items', 'Total', 'Fecha'],
      rows: data.map((order) {
        return AdminTableRow([
          WidgetTableCell(Text(order.numero, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          WidgetTableCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(order.alias, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                if (order.idCliente.isNotEmpty)
                  Text(order.idCliente, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          WidgetTableCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (order.customerEmail != null)
                  Text(order.customerEmail!, style: const TextStyle(fontSize: 12)),
                if (order.customerPhone != null)
                  Text(order.customerPhone!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          WidgetTableCell(StatusBadge(order.estado)),
          WidgetTableCell(Text('${order.fullItems.length} productos', style: const TextStyle(fontSize: 14))),
          WidgetTableCell(Text(
            '\$${(order.totalCentavos / 100).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          )),
          WidgetTableCell(Text(_formatDate(order.created), style: const TextStyle(fontSize: 13, color: Colors.grey))),
        ]);
      }).toList(),
      showPagination: totalPages > 1,
      currentPage: currentPage,
      totalPages: totalPages,
      onPageChanged: onPageChanged,
      onRowTap: onTap != null
          ? (index) => onTap!(data[index])
          : null,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}