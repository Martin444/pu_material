import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../utils/pu_colors.dart';

class AdminDataTableMolecule extends StatelessWidget {
  final List<String> headers;
  final List<AdminTableRow> rows;
  final double? columnSpacing;
  final double? horizontalMargin;

  const AdminDataTableMolecule({
    super.key,
    required this.headers,
    required this.rows,
    this.columnSpacing,
    this.horizontalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.card,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(PUColors.bgInput),
          border: TableBorder.all(color: PUColors.borderInputColor),
          columnSpacing: columnSpacing ?? 24,
          horizontalMargin: horizontalMargin ?? 16,
          columns: headers
              .map((h) => DataColumn(
                    label: Text(
                      h,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ))
              .toList(),
          rows: rows
              .map((row) => DataRow(
                    cells: row.cells
                        .map((cell) => DataCell(
                              cell.build(),
                            ))
                        .toList(),
                  ))
              .toList(),
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

class AdminTableRow {
  final List<AdminTableCell> cells;

  const AdminTableRow(this.cells);
}