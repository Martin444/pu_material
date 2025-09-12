import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';
import '../atoms/category_tag_atom.dart';

/// Organismo genérico para secciones de categorías que combina:
/// - Header con título y acciones
/// - Grid/Lista de tags para selección rápida
/// - Área de contenido personalizable
///
/// Este organismo implementa patrones comunes de UI para manejo de categorías
/// y puede reutilizarse en diferentes contextos (menús, guardarropas, etc.)
class CategorySectionOrganism<T> extends StatelessWidget {
  const CategorySectionOrganism({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.labelBuilder,
    this.itemCountBuilder,
    this.iconBuilder,
    this.onEditSelected,
    this.onDeleteSelected,
    this.headerActions = const [],
    this.emptyStateWidget,
    this.emptyMessage = 'No hay elementos disponibles',
    this.maxTagsToShow = 10,
    this.showAsGrid = true,
    this.constrains,
  });

  /// Título de la sección
  final String title;

  /// Lista de items disponibles
  final List<T> items;

  /// Item actualmente seleccionado
  final T? selectedItem;

  /// Callback cuando se selecciona un item
  final ValueChanged<T> onItemSelected;

  /// Constructor para obtener el label de un item
  final String Function(T item) labelBuilder;

  /// Constructor opcional para obtener el contador de items
  final int Function(T item)? itemCountBuilder;

  /// Constructor opcional para obtener el ícono de un item
  final IconData Function(T item)? iconBuilder;

  /// Callback para editar el item seleccionado
  final VoidCallback? onEditSelected;

  /// Callback para eliminar el item seleccionado
  final VoidCallback? onDeleteSelected;

  /// Acciones adicionales para el header
  final List<Widget> headerActions;

  /// Widget personalizado para estado vacío
  final Widget? emptyStateWidget;

  /// Mensaje cuando no hay items
  final String emptyMessage;

  /// Máximo número de tags a mostrar antes de scroll
  final int maxTagsToShow;

  /// Si mostrar como grid o lista vertical
  final bool showAsGrid;

  /// Constraints del contenedor padre para responsividad
  final BoxConstraints? constrains;

  bool get _isSmallScreen => constrains != null ? constrains!.maxWidth < 600 : false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PUColors.bgItem,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PUColors.borderInputColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con título y acciones
          _buildHeader(),

          // Separador
          if (items.isNotEmpty) const SizedBox(height: 16),

          // Contenido principal
          if (items.isEmpty) _buildEmptyState() else _buildTagsSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título
        Expanded(
          child: Text(
            title,
            style: PuTextStyle.title3.copyWith(
              fontSize: _isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: PUColors.textColor3,
            ),
          ),
        ),

        // Acciones del item seleccionado
        if (selectedItem != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botón de editar
              if (onEditSelected != null)
                _HeaderActionButton(
                  icon: FluentIcons.edit_24_regular,
                  color: PUColors.primaryColor,
                  onTap: onEditSelected!,
                  tooltip: 'Editar seleccionado',
                ),

              // Espaciado
              if (onEditSelected != null && onDeleteSelected != null) const SizedBox(width: 8),

              // Botón de eliminar
              if (onDeleteSelected != null)
                _HeaderActionButton(
                  icon: FluentIcons.delete_24_regular,
                  color: Colors.red,
                  onTap: onDeleteSelected!,
                  tooltip: 'Eliminar seleccionado',
                ),

              // Separador si hay acciones adicionales
              if (headerActions.isNotEmpty && (onEditSelected != null || onDeleteSelected != null))
                Container(
                  height: 20,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: PUColors.borderInputColor.withOpacity(0.5),
                ),
            ],
          ),
        ],

        // Acciones adicionales personalizadas
        ...headerActions,
      ],
    );
  }

  Widget _buildEmptyState() {
    if (emptyStateWidget != null) {
      return emptyStateWidget!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            FluentIcons.folder_24_regular,
            size: 48,
            color: PUColors.iconColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            emptyMessage,
            style: PuTextStyle.description1.copyWith(
              color: PUColors.textColor3.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    if (showAsGrid) {
      return Wrap(
        spacing: _isSmallScreen ? 8 : 12,
        runSpacing: _isSmallScreen ? 8 : 12,
        children: items.take(maxTagsToShow).map((item) {
          return CategoryTagAtom(
            label: labelBuilder(item),
            isSelected: selectedItem == item,
            onTap: () => onItemSelected(item),
            itemCount: itemCountBuilder?.call(item),
            icon: iconBuilder?.call(item),
            isSmallScreen: _isSmallScreen,
          );
        }).toList(),
      );
    } else {
      // Lista vertical para muchos items
      return Column(
        children: items.take(maxTagsToShow).map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CategoryTagAtom(
              label: labelBuilder(item),
              isSelected: selectedItem == item,
              onTap: () => onItemSelected(item),
              itemCount: itemCountBuilder?.call(item),
              icon: iconBuilder?.call(item),
              isSmallScreen: _isSmallScreen,
            ),
          );
        }).toList(),
      );
    }
  }
}

/// Átomo interno para botones de acción del header
class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
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
