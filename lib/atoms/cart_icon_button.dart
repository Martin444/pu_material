import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

/// Átomo: Botón de carrito
class CartIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;
  final IconData? selectedIcon;
  final IconData? unselectedIcon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? size;

  const CartIconButton({
    super.key,
    required this.onPressed,
    this.isSelected = false,
    this.selectedIcon,
    this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = size ?? 20.0;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    isSelected ? (selectedColor ?? PUColors.accentColor) : (unselectedColor ?? PUColors.primaryColor),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (selectedColor ?? PUColors.accentColor).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
              child: Icon(
                isSelected
                    ? (selectedIcon ?? Icons.check_rounded)
                    : (unselectedIcon ?? Icons.add_shopping_cart_rounded),
                size: iconSize,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
