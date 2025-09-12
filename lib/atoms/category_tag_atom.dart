import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

/// Átomo reutilizable para representar un tag/chip de categoría.
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Estado visual (seleccionado/no seleccionado)
/// - Interacciones básicas (tap, hover)
/// - Información visual (texto, ícono, contador)
///
/// Este átomo es completamente agnóstico del dominio y puede
/// reutilizarse para cualquier tipo de categorización.
class CategoryTagAtom extends StatelessWidget {
  const CategoryTagAtom({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.itemCount,
    this.icon,
    this.isSmallScreen = false,
  });

  /// Texto principal del tag
  final String label;

  /// Si el tag está seleccionado actualmente
  final bool isSelected;

  /// Callback cuando se toca el tag
  final VoidCallback onTap;

  /// Número opcional de items en esta categoría
  final int? itemCount;

  /// Ícono opcional para mostrar junto al texto
  final IconData? icon;

  /// Si se debe usar el diseño compacto para pantallas pequeñas
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16,
            vertical: isSmallScreen ? 8 : 10,
          ),
          decoration: BoxDecoration(
            color: isSelected ? PUColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? PUColors.primaryColor : PUColors.borderInputColor.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: PUColors.primaryColor.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícono opcional
              if (icon != null) ...[
                Icon(
                  icon,
                  size: isSmallScreen ? 14 : 16,
                  color: isSelected ? Colors.white : PUColors.iconColor,
                ),
                SizedBox(width: isSmallScreen ? 4 : 6),
              ],

              // Texto principal
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : PUColors.textColor3,
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Contador de items opcional
              if (itemCount != null && itemCount! > 0) ...[
                SizedBox(width: isSmallScreen ? 4 : 6),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 4 : 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white.withOpacity(0.2) : PUColors.bgItem.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : PUColors.textColor3,
                      fontSize: isSmallScreen ? 10 : 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
