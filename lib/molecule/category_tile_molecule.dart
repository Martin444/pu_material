import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

/// Molécula reutilizable para representar un tile de categoría en listas.
///
/// Combina átomos básicos (texto, iconos, botones) para crear una unidad
/// funcional que maneja:
/// - Visualización del item
/// - Estado de selección
/// - Acciones principales (editar, eliminar, seleccionar)
///
/// Generic parameter T permite reutilización con cualquier tipo de modelo.
class CategoryTileMolecule<T> extends StatelessWidget {
  const CategoryTileMolecule({
    super.key,
    required this.item,
    required this.label,
    required this.isSelected,
    required this.onSelect,
    this.onEdit,
    this.onDelete,
    this.showEditAction = true,
    this.showDeleteAction = false,
    this.trailing,
  });

  /// El item de datos que representa este tile
  final T item;

  /// Texto principal a mostrar
  final String label;

  /// Si este tile está seleccionado
  final bool isSelected;

  /// Callback cuando se selecciona el item
  final ValueChanged<T> onSelect;

  /// Callback opcional para editar el item
  final ValueChanged<T>? onEdit;

  /// Callback opcional para eliminar el item
  final ValueChanged<T>? onDelete;

  /// Si mostrar el botón de editar
  final bool showEditAction;

  /// Si mostrar el botón de eliminar
  final bool showDeleteAction;

  /// Widget opcional para mostrar al final del tile
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(item),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? PUColors.bgCategorySelected : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: PUColors.primaryColor.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            // Indicador de selección
            if (isSelected) ...[
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: PUColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
            ],

            // Contenido principal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: PuTextStyle.textbtnStyle.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? PUColors.primaryColor : PUColors.textColor3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Widget personalizado al final
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
              const SizedBox(width: 8),
            ],

            // Acciones
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón de editar
                if (showEditAction && onEdit != null)
                  _ActionButton(
                    icon: FluentIcons.edit_24_regular,
                    color: PUColors.primaryColor,
                    onTap: () => onEdit!(item),
                    tooltip: 'Editar',
                  ),

                // Espaciado entre botones
                if (showEditAction && showDeleteAction && onEdit != null && onDelete != null) const SizedBox(width: 8),

                // Botón de eliminar
                if (showDeleteAction && onDelete != null)
                  _ActionButton(
                    icon: FluentIcons.delete_24_regular,
                    color: Colors.red,
                    onTap: () => onDelete!(item),
                    tooltip: 'Eliminar',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Átomo interno para botones de acción del tile
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 18,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
