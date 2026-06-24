import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class McOptionBtnTile<T> extends StatelessWidget {
  const McOptionBtnTile({
    super.key,
    required this.actionSelected,
    required this.item,
    this.showEditAction = true,
    this.showDeleteAction = true,
  });

  final Function(T p1, String p2) actionSelected;
  final T item;
  final bool showEditAction;
  final bool showDeleteAction;

  @override
  Widget build(BuildContext context) {
    if (!showEditAction && !showDeleteAction) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == 'settings') {
          actionSelected(item, 'edit');
        } else if (result == 'info') {
          actionSelected(item, 'delete');
        }
      },
      offset: const Offset(-140, 30),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (showEditAction)
          const PopupMenuItem<String>(
            value: 'settings',
            child: ListTile(
              leading: Icon(FluentIcons.edit_24_regular),
              title: Text('Editar'),
            ),
          ),
        if (showDeleteAction)
          const PopupMenuItem<String>(
            value: 'info',
            child: ListTile(
              leading: Icon(FluentIcons.delete_24_regular),
              title: Text('Eliminar'),
            ),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          FluentIcons.more_vertical_24_regular,
          color: PUColors.iconColor,
        ),
      ),
    );
  }
}
