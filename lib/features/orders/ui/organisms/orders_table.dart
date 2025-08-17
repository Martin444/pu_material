import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../utils/time_ago.dart';
import '../atoms/cell_text.dart';
import '../atoms/currency_text.dart';
import '../atoms/table_cell_atom.dart';
import '../molecules/status_badge.dart';
import '../molecules/order_compact_card.dart';

/// Descriptor para configurar columnas de la tabla
class ColumnDescriptor<T> {
  final String id;
  final String label;
  final Alignment alignment;
  final double minWidth; // ancho sugerido
  final bool Function(double w) visible; // visibilidad por breakpoint
  final Widget Function(BuildContext, T) cellBuilder;

  const ColumnDescriptor({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.alignment = Alignment.centerLeft,
    this.minWidth = 120,
    this.visible = _always,
  });

  static bool _always(double _) => true;
}

/// Organismo principal que maneja la tabla de órdenes con responsividad
class OrdersTable extends StatelessWidget {
  final List<Order> data;
  final EdgeInsets padding;

  const OrdersTable({
    super.key,
    required this.data,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;

      // Breakpoints
      final isMobile = w < 600;

      if (isMobile) {
        // Lista compacta de tarjetas
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, i) => OrderCompactCard(order: data[i]),
        );
      }

      // Definición de columnas (desktop y tablet)
      final columns = _getColumns(w).toList();

      // Tabla con scroll horizontal si el total de minWidth supera el ancho
      final requiredWidth = columns.fold<double>(0, (acc, c) => acc + c.minWidth) + 32;
      final table = _TableView(columns: columns, rows: data);

      if (requiredWidth > w) {
        return Padding(
          padding: padding,
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: requiredWidth),
                child: table,
              ),
            ),
          ),
        );
      }

      return Padding(padding: padding, child: table);
    });
  }

  /// Define las columnas según el ancho disponible
  Iterable<ColumnDescriptor<Order>> _getColumns(double width) sync* {
    // Número de orden - siempre visible
    yield ColumnDescriptor<Order>(
      id: 'numero',
      label: 'Nº',
      minWidth: 80,
      cellBuilder: (context, order) => CellText('#${order.numero}'),
    );

    // Estado - siempre visible
    yield ColumnDescriptor<Order>(
      id: 'estado',
      label: 'Estado',
      minWidth: 120,
      cellBuilder: (context, order) => StatusBadge(order.estado),
    );

    // Cliente - visible en tablet y desktop
    if (width >= 600) {
      yield ColumnDescriptor<Order>(
        id: 'cliente',
        label: 'Cliente',
        minWidth: 120,
        cellBuilder: (context, order) => CellText(order.idCliente),
      );
    }

    // Alias - visible solo en desktop
    if (width >= 1024) {
      yield ColumnDescriptor<Order>(
        id: 'alias',
        label: 'Alias',
        minWidth: 150,
        cellBuilder: (context, order) => CellText(order.alias),
      );
    }

    // Detalle - visible en tablet y desktop
    if (width >= 600) {
      yield ColumnDescriptor<Order>(
        id: 'detalle',
        label: 'Detalle',
        minWidth: 200,
        cellBuilder: (context, order) => CellText(
          order.detalle,
          maxLines: 2,
        ),
      );
    }

    // Creado - visible solo en desktop
    if (width >= 1024) {
      yield ColumnDescriptor<Order>(
        id: 'creado',
        label: 'Creado',
        minWidth: 100,
        cellBuilder: (context, order) => CellText(
          TimeAgo.formatShort(order.creado),
        ),
      );
    }

    // Total - siempre visible
    yield ColumnDescriptor<Order>(
      id: 'total',
      label: 'Total',
      minWidth: 120,
      alignment: Alignment.centerRight,
      cellBuilder: (context, order) => CurrencyText(
        order.totalCentavos,
        align: TextAlign.right,
      ),
    );
  }
}

/// Vista interna de la tabla
class _TableView extends StatelessWidget {
  final List<ColumnDescriptor<Order>> columns;
  final List<Order> rows;

  const _TableView({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          fontWeight: FontWeight.w600,
        );

    return Column(
      children: [
        // Header
        Material(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: columns
                .map((c) => SizedBox(
                      width: c.minWidth,
                      child: TableCellAtom(
                        alignment: c.alignment,
                        child: Text(c.label, style: headerStyle),
                      ),
                    ))
                .toList(),
          ),
        ),
        // Rows
        ...rows.map((o) => Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: columns
                    .map((c) => SizedBox(
                          width: c.minWidth,
                          child: TableCellAtom(
                            alignment: c.alignment,
                            child: c.cellBuilder(context, o),
                          ),
                        ))
                    .toList(),
              ),
            )),
      ],
    );
  }
}
