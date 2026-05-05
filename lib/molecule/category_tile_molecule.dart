import 'package:flutter/material.dart';
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
class CategoryTileMolecule<T> extends StatefulWidget {
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
  State<CategoryTileMolecule<T>> createState() => _CategoryTileMoleculeState<T>();
}

class _CategoryTileMoleculeState<T> extends State<CategoryTileMolecule<T>> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onSelect(widget.item),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? PUColors.bgCategorySelected
                : (_isHovering ? PUColors.primaryColor.withValues(alpha: 0.05) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border: widget.isSelected
                ? Border.all(
                    color: PUColors.primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  )
                : Border.all(
                    color: _isHovering ? PUColors.primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                    width: 1.5,
                  ),
            boxShadow: _isHovering && !widget.isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Indicador de selección
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isSelected ? 4 : (_isHovering ? 2 : 0),
                height: 20,
                decoration: BoxDecoration(
                  color: widget.isSelected ? PUColors.primaryColor : PUColors.primaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(width: 8),

              // Texto con tipografía premium
              Expanded(
                child: Text(
                  widget.label,
                  style: PuTextStyle.bodyMedium.copyWith(
                    fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: widget.isSelected ? PUColors.accentColor : PUColors.textColorMuted,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Acciones
              if (widget.isSelected || _isHovering)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: 1.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showEditAction && widget.onEdit != null)
                        _ActionButton(
                          icon: Icons.edit_outlined,
                          color: Colors.white70,
                          onTap: () => widget.onEdit!(widget.item),
                          tooltip: 'Editar',
                        ),
                      if (widget.showDeleteAction && widget.onDelete != null) ...[
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.delete_outline,
                          color: Colors.redAccent.withOpacity(0.8),
                          onTap: () => widget.onDelete!(widget.item),
                          tooltip: 'Eliminar',
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
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
              color: color.withValues(alpha: 0.1),
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
