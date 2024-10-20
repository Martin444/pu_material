import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';

class McOptionBtnTile<T> extends StatelessWidget {
  const McOptionBtnTile({
    super.key,
    required this.actionSelected,
    required this.item,
  });

  final Function(T p1, String p2) actionSelected;
  final T item;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: PopupMenuButton<String>(
        onSelected: (String result) {
          if (result == 'settings') {
            actionSelected(item, 'edit');
          } else if (result == 'info') {
            actionSelected(item, 'delete');
          }
        },
        offset: const Offset(-140, 30),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'settings',
            child: ListTile(
              leading: Icon(Icons.edit_rounded),
              title: Text('Editar'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'info',
            child: ListTile(
              leading: Icon(Icons.delete_outline_rounded),
              title: Text('Eliminar'),
            ),
          ),
        ],
        child: Icon(
          Icons.more_vert_rounded,
          color: PUColors.iconColor,
        ),
      ),
    );
  }
}
