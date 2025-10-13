import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

        final iconSize = size ?? (isDesktop ? 35.0 : (isTablet ? 22.0 : 20.0));
        final buttonPadding = isDesktop ? 3.0 : (isTablet ? 5.0 : 2.0);

        return GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(buttonPadding),
            decoration: BoxDecoration(
              color: isSelected ? (selectedColor ?? Colors.green) : (unselectedColor ?? Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isSelected
                  ? (selectedIcon ?? FluentIcons.checkmark_24_regular)
                  : (unselectedIcon ?? FluentIcons.shopping_bag_24_regular),
              size: iconSize,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
