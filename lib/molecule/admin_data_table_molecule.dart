import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../utils/pu_colors.dart';

class AdminDataTableMolecule extends StatefulWidget {
  final List<String> headers;
  final List<AdminTableRow> rows;
  final double? columnSpacing;
  final double? horizontalMargin;
  final bool showPagination;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onRowTap;

  const AdminDataTableMolecule({
    super.key,
    required this.headers,
    required this.rows,
    this.columnSpacing,
    this.horizontalMargin,
    this.showPagination = false,
    this.currentPage = 1,
    this.totalPages = 1,
    this.onPageChanged,
    this.onRowTap,
  });

  @override
  State<AdminDataTableMolecule> createState() => _AdminDataTableMoleculeState();
}

class _AdminDataTableMoleculeState extends State<AdminDataTableMolecule> {
  int? _hoveredRowIndex;

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.card,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(PUColors.bgInput),
                    border: TableBorder(
                      horizontalInside: BorderSide(color: PUColors.borderInputColor.withValues(alpha: 0.5)),
                    ),
                    columnSpacing: widget.columnSpacing ?? 24,
                    horizontalMargin: widget.horizontalMargin ?? 16,
                    headingRowHeight: 56,
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    columns: widget.headers
                        .map((h) => DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  h,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: PUColors.textColorMuted,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    rows: List.generate(widget.rows.length, (index) {
                      final row = widget.rows[index];
                      return DataRow(
                        onSelectChanged: widget.onRowTap != null
                            ? (selected) => widget.onRowTap!(index)
                            : null,
                        color: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered) || _hoveredRowIndex == index) {
                            return PUColors.primaryBlueLight.withValues(alpha: 0.3);
                          }
                          return index.isEven
                              ? PUColors.bgItem
                              : Colors.transparent;
                        }),
                        cells: row.cells
                            .map((cell) => DataCell(
                                  cell.build(),
                                ))
                            .toList(),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
          if (widget.showPagination && widget.totalPages > 1) _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Página ${widget.currentPage} de ${widget.totalPages}',
            style: const TextStyle(
              fontSize: 13,
              color: PUColors.textColorMuted,
            ),
          ),
          Row(
            children: [
              _PaginationButton(
                icon: Icons.chevron_left,
                onTap: widget.currentPage > 1
                    ? () => widget.onPageChanged?.call(widget.currentPage - 1)
                    : null,
              ),
              const SizedBox(width: 8),
              _PaginationButton(
                icon: Icons.chevron_right,
                onTap: widget.currentPage < widget.totalPages
                    ? () => widget.onPageChanged?.call(widget.currentPage + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _PaginationButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerAtom(
        variant: ContainerVariant.minimal,
        padding: const EdgeInsets.all(8),
        backgroundColor: onTap != null ? PUColors.bgInput : PUColors.bgItem,
        borderColor: onTap != null ? PUColors.borderInputColor : Colors.transparent,
        borderWidth: 1,
        child: IconAtom(
          icon: icon,
          color: onTap != null ? PUColors.textColorRich : PUColors.textColorLight,
          size: 20,
        ),
      ),
    );
  }
}

abstract class AdminTableCell {
  Widget build();
}

class TextTableCell extends AdminTableCell {
  final String text;
  final TextStyle? style;
  final int? maxLines;

  TextTableCell(this.text, {this.style, this.maxLines});

  @override
  Widget build() {
    return Text(
      text,
      style: style ?? const TextStyle(fontSize: 14),
      maxLines: maxLines,
    );
  }
}

class PriceTableCell extends AdminTableCell {
  final double price;

  PriceTableCell(this.price);

  @override
  Widget build() {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}

class BadgeTableCell extends AdminTableCell {
  final String text;
  final Color color;

  BadgeTableCell(this.text, this.color);

  @override
  Widget build() {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: color.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class SwitchTableCell extends AdminTableCell {
  final bool value;
  final ValueChanged<bool>? onChanged;

  SwitchTableCell(this.value, {this.onChanged});

  @override
  Widget build() {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: PUColors.primaryBlue,
    );
  }
}

class ActionTableCell extends AdminTableCell {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  ActionTableCell({required this.icon, required this.onTap, this.color});

  @override
  Widget build() {
    return IconButton(
      icon: Icon(icon, color: color, size: 20),
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}

class WidgetTableCell extends AdminTableCell {
  final Widget widget;

  WidgetTableCell(this.widget);

  @override
  Widget build() {
    return widget;
  }
}

class AdminTableRow {
  final List<AdminTableCell> cells;

  const AdminTableRow(this.cells);
}