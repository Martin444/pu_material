import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class CategoryTagsSection<T> extends StatelessWidget {
  const CategoryTagsSection({
    super.key,
    required this.title,
    required this.items,
    this.selectedItem,
    required this.onItemSelected,
    required this.descriptionBuilder,
    required this.itemCountBuilder,
    required this.constraints,
    this.onEditSelected,
    this.onDeleteSelected,
    this.actionButtons = const [],
    this.icon = FluentIcons.apps_24_regular,
    this.emptyMessage,
  });

  final String title;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onItemSelected;
  final String Function(T item) descriptionBuilder;
  final int Function(T item) itemCountBuilder;
  final BoxConstraints constraints;
  final VoidCallback? onEditSelected;
  final VoidCallback? onDeleteSelected;
  final List<Widget> actionButtons;
  final IconData icon;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return CategorySectionOrganism<T>(
      title: title,
      items: items,
      selectedItem: selectedItem,
      onItemSelected: onItemSelected,
      labelBuilder: descriptionBuilder,
      itemCountBuilder: itemCountBuilder,
      iconBuilder: (_) => icon,
      onEditSelected: onEditSelected,
      onDeleteSelected: onDeleteSelected,
      headerActions: actionButtons,
      emptyMessage: emptyMessage ?? 'No hay elementos disponibles',
      constraints: constraints,
      showAsGrid: true,
      maxTagsToShow: 15,
    );
  }
}
