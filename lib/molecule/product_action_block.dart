import 'package:flutter/material.dart';
import 'package:pu_material/atoms/product_price.dart';
import 'package:pu_material/atoms/cart_icon_button.dart';
import 'package:pu_material/atoms/product_badge.dart';

/// Molécula: Bloque de acción del producto (precio + botón)
class ProductActionBlock extends StatelessWidget {
  final double price;
  final VoidCallback onAddToCart;
  final bool isSelected;
  final String? additionalBadge;
  final Color? additionalBadgeColor;
  final Color? additionalBadgeBackgroundColor;
  final String? selectedIcon;
  final String? unselectedIcon;
  final Color? selectedButtonColor;
  final Color? unselectedButtonColor;

  const ProductActionBlock({
    super.key,
    required this.price,
    required this.onAddToCart,
    this.isSelected = false,
    this.additionalBadge,
    this.additionalBadgeColor,
    this.additionalBadgeBackgroundColor,
    this.selectedIcon,
    this.unselectedIcon,
    this.selectedButtonColor,
    this.unselectedButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

        final spacing = isDesktop ? 8.0 : (isTablet ? 6.0 : 4.0);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Precio y badge adicional
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductPrice(
                    price: price,
                    textAlign: TextAlign.start,
                  ),
                  if (additionalBadge != null) ...[
                    SizedBox(height: spacing / 2),
                    ProductBadge(
                      text: additionalBadge!,
                      textColor: additionalBadgeColor,
                      backgroundColor: additionalBadgeBackgroundColor,
                    ),
                  ],
                ],
              ),
            ),

            // Botón de carrito
            CartIconButton(
              onPressed: onAddToCart,
              isSelected: isSelected,
              selectedIcon: selectedIcon,
              unselectedIcon: unselectedIcon,
              selectedColor: selectedButtonColor,
              unselectedColor: unselectedButtonColor,
            ),
          ],
        );
      },
    );
  }
}
