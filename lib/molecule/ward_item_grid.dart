import 'package:flutter/material.dart';
import 'package:pu_material/atoms/grid_layout_atom.dart';
import 'package:pu_material/atoms/empty_state_atom.dart';

/// Ward Item Grid Molecule - Molécula para mostrar una grilla de elementos
class WardItemGrid<T> extends StatelessWidget {
  final List<T> items;
  final BoxConstraints constraints;
  final Widget Function(T item, int index) itemBuilder;
  final String? emptyTitle;
  final String? emptyImagePath;
  final String? emptyButtonText;
  final VoidCallback? onEmptyButtonPressed;
  final bool isLoading;

  const WardItemGrid({
    super.key,
    required this.items,
    required this.constraints,
    required this.itemBuilder,
    this.emptyTitle,
    this.emptyImagePath,
    this.emptyButtonText,
    this.onEmptyButtonPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return EmptyStateAtom(
        imagePath: emptyImagePath,
        title: emptyTitle ?? 'No hay elementos disponibles',
        buttonText: emptyButtonText,
        onButtonPressed: onEmptyButtonPressed,
        isLoading: isLoading,
      );
    }

    return GridLayoutAtom(
      constraints: constraints,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisExtent: 360, // Ajuste para evitar overflow
      children: items.asMap().entries.map((entry) {
        return itemBuilder(entry.value, entry.key);
      }).toList(),
    );
  }
}
