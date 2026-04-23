import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/pu_colors.dart';
import '../../../../utils/style/pu_style_fonts.dart';
import '../../models/order.dart';
import '../../utils/time_ago.dart';
import '../atoms/cell_text.dart';
import '../atoms/currency_text.dart';
import '../atoms/table_cell_atom.dart';
import '../molecules/status_badge.dart';
import '../molecules/order_compact_card.dart';
import '../molecules/receipt_dialog.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Descriptor para configurar columnas de la tabla
class ColumnDescriptor<T> {
  final String id;
  final String label;
  final Alignment alignment;
  final int flex;
  final double? minWidth;
  final Widget Function(BuildContext, T) cellBuilder;

  const ColumnDescriptor({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.alignment = Alignment.centerLeft,
    this.flex = 1,
    this.minWidth,
  });
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
      final isMobile = w < 768; // Ajustado breakpoint

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
      final requiredWidth = columns.fold<double>(0.0, (acc, c) => acc + (c.minWidth ?? 0.0)) + 32;
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
    // Número de orden
    yield ColumnDescriptor<Order>(
      id: 'numero',
      label: 'Nº',
      flex: 1,
      minWidth: 80,
      cellBuilder: (context, order) => CellText(
        '#${order.numero}',
        style: PuTextStyle.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: PUColors.primaryBlue,
        ),
      ),
    );

    // Estado
    yield ColumnDescriptor<Order>(
      id: 'estado',
      label: 'Estado',
      flex: 2,
      minWidth: 110,
      cellBuilder: (context, order) => StatusBadge(order.estado),
    );

    // Cliente - visible en tablet y desktop
    if (width >= 850) {
      yield ColumnDescriptor<Order>(
        id: 'cliente',
        label: 'Cliente',
        flex: 3,
        minWidth: 140,
        cellBuilder: (context, order) => CellText(
          order.idCliente,
          style: PuTextStyle.bodySmall,
        ),
      );
    }

    // Detalle
    yield ColumnDescriptor<Order>(
      id: 'detalle',
      label: 'Detalle',
      flex: 4,
      minWidth: 180,
      cellBuilder: (context, order) => CellText(
        order.detalle,
        maxLines: 1,
        style: PuTextStyle.bodySmall,
      ),
    );

    // Creado
    if (width >= 1024) {
      yield ColumnDescriptor<Order>(
        id: 'creado',
        label: 'Creado',
        flex: 1,
        minWidth: 80,
        cellBuilder: (context, order) => CellText(
          TimeAgo.formatShort(order.creado),
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      );
    }

    // Total
    yield ColumnDescriptor<Order>(
      id: 'total',
      label: 'Total',
      flex: 2,
      minWidth: 100,
      alignment: Alignment.centerRight,
        cellBuilder: (context, order) => CurrencyText(
          order.totalCentavos,
          align: TextAlign.right,
          style: PuTextStyle.bodyMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: PUColors.textColorRich,
          ),
        ),
    );

    // Acciones
    yield ColumnDescriptor<Order>(
      id: 'acciones',
      label: 'Acciones',
      flex: 2,
      minWidth: 100,
      alignment: Alignment.centerRight,
      cellBuilder: (context, order) => _buildActions(context, order),
    );
  }

  Widget _buildActions(BuildContext context, Order order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => _showReceipt(context, order),
          icon: const Icon(FluentIcons.receipt_24_regular),
          tooltip: 'Ver Comprobante',
          iconSize: 20,
          color: PUColors.primaryBlue,
        ),
        if (order.estado.toLowerCase() == 'pendiente' && order.paymentUrl != null)
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: order.paymentUrl!));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link de pago copiado')),
              );
            },
            icon: const Icon(FluentIcons.share_24_regular),
            tooltip: 'Compartir Link de Pago',
            iconSize: 20,
            color: const Color(0xFF2563EB),
          ),
      ],
    );
  }

  void _showReceipt(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => ReceiptDialog(order: order),
    );
  }
}

/// Vista interna de la tabla
class _TableView extends StatefulWidget {
  final List<ColumnDescriptor<Order>> columns;
  final List<Order> rows;

  const _TableView({required this.columns, required this.rows});

  @override
  State<_TableView> createState() => _TableViewState();
}

class _TableViewState extends State<_TableView> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = PuTextStyle.bodySmall.copyWith(
          color: PUColors.textColorMuted.withValues(alpha: 0.8),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 11,
        );

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Header
            Material(
              color: PUColors.primaryBlue.withValues(alpha: 0.04),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: widget.columns
                      .map((c) => Expanded(
                            flex: c.flex,
                            child: TableCellAtom(
                              alignment: c.alignment,
                              child: Text(c.label, style: headerStyle),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            // Rows
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.rows.length,
              itemBuilder: (context, index) {
                final o = widget.rows[index];
                final isHovered = _hoveredIndex == index;

                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isHovered ? PUColors.primaryBlue.withValues(alpha: 0.05) : null,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.dividerColor.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: widget.columns
                          .map((c) => Expanded(
                                flex: c.flex,
                                child: TableCellAtom(
                                  alignment: c.alignment,
                                  child: c.cellBuilder(context, o),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
