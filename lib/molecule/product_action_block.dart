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
  final IconData? selectedIcon;
  final IconData? unselectedIcon;
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
        final maxHeight = constraints.maxHeight;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

        final spacing = isDesktop ? 8.0 : (isTablet ? 6.0 : 4.0);

        // Si el espacio vertical es muy limitado, usar layout compacto
        final hasLimitedHeight = maxHeight != double.infinity && maxHeight < 40;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Precio y badge adicional
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Evitar expansion innecesaria
                children: [
                  // Precio - siempre visible
                  ProductPrice(
                    price: price,
                    textAlign: TextAlign.start,
                  ),
                  // Badge adicional - solo si hay espacio y no estamos en modo compacto
                  if (additionalBadge != null && !hasLimitedHeight) ...[
                    SizedBox(height: spacing / 2),
                    Flexible(
                      child: ProductBadge(
                        text: additionalBadge!,
                        textColor: additionalBadgeColor,
                        backgroundColor: additionalBadgeBackgroundColor,
                      ),
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
