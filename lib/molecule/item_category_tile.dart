import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';

class ItemCategoryTile<T> extends StatelessWidget {
  final T? item;
  final Function(T)? onEdit;
  final Function(T)? onDelete;
  final Function(T)? onSelect;
  final bool? isSelected;
  final String Function(T)? descriptionBuilder;

  const ItemCategoryTile({
    super.key,
    required this.item,
    required this.descriptionBuilder,
    this.onEdit,
    this.onSelect,
    this.isSelected,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currentItem = item;
    final currentDescriptionBuilder = descriptionBuilder;

    if (currentItem == null || currentDescriptionBuilder == null) {
      return const SizedBox.shrink();
    }

    return CategoryTileMolecule<T>(
      item: currentItem,
      label: currentDescriptionBuilder(currentItem),
      isSelected: isSelected ?? false,
      onSelect: (selectedItem) {
        if (onSelect != null) {
          onSelect!(selectedItem);
        }
      },
      onEdit: onEdit != null ? (selectedItem) => onEdit!(selectedItem) : null,
      onDelete:
          onDelete != null ? (selectedItem) => onDelete!(selectedItem) : null,
      showEditAction: onEdit != null,
      showDeleteAction: onDelete != null,
    );
  }
}
