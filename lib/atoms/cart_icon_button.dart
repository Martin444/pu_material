import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:pu_material/utils/pu_assets.dart';

/// Átomo: Botón de carrito
class CartIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;
  final String? selectedIcon;
  final String? unselectedIcon;
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
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        final iconSize = size ?? (isDesktop ? 40.0 : (isTablet ? 35.0 : 30.0));
        final buttonPadding = isDesktop ? 10.0 : (isTablet ? 9.0 : 8.0);

        return GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(buttonPadding),
            decoration: BoxDecoration(
              color: isSelected ? (selectedColor ?? Colors.green) : (unselectedColor ?? Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              isSelected ? (selectedIcon ?? PUIcons.iconCheck) : (unselectedIcon ?? PUIcons.iconCart),
              height: iconSize,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }
}
