import 'package:flutter/material.dart';
import 'package:pu_material/atoms/product_image.dart';
import 'package:pu_material/molecule/product_info_block.dart';
import 'package:pu_material/molecule/product_action_block.dart';
import 'package:pu_material/utils/style/pu_style_containers.dart';

/// Enum para el layout del card
enum ProductCardLayout {
  vertical, // Imagen arriba, información abajo
  horizontal, // Imagen a la izquierda, información a la derecha
}

/// Organismo: Card completa del producto
class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final double price;
  final VoidCallback onAddToCart;
  final bool isSelected;

  // Información adicional
  final String? primaryInfo;
  final List<String>? secondaryInfo;
  final String? badge;
  final String? actionBadge;

  // Configuración de colores
  final Color? primaryInfoColor;
  final Color? primaryInfoBackgroundColor;
  final Color? badgeColor;
  final Color? badgeBackgroundColor;
  final Color? actionBadgeColor;
  final Color? actionBadgeBackgroundColor;

  // Configuración de prefijos
  final String? primaryInfoPrefix;
  final String? secondaryInfoPrefix;

  // Configuración de layout
  final ProductCardLayout layout;
  final int maxTitleLines;
  final int maxSecondaryInfoLines;

  // Configuración de iconos
  final IconData? selectedIcon;
  final IconData? unselectedIcon;
  final Color? selectedButtonColor;
  final Color? unselectedButtonColor;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.price,
    required this.onAddToCart,
    this.isSelected = false,
    this.primaryInfo,
    this.secondaryInfo,
    this.badge,
    this.actionBadge,
    this.primaryInfoColor,
    this.primaryInfoBackgroundColor,
    this.badgeColor,
    this.badgeBackgroundColor,
    this.actionBadgeColor,
    this.actionBadgeBackgroundColor,
    this.primaryInfoPrefix,
    this.secondaryInfoPrefix,
    this.layout = ProductCardLayout.vertical,
    this.maxTitleLines = 2,
    this.maxSecondaryInfoLines = 1,
    this.selectedIcon,
    this.unselectedIcon,
    this.selectedButtonColor,
    this.unselectedButtonColor,
  });

  /// Factory constructor para productos de menú
  factory ProductCard.menu({
    required String title,
    required double price,
    required VoidCallback onAddToCart,
    String? imageUrl,
    int? deliveryTime,
    List<String>? ingredients,
    bool isSelected = false,
    ProductCardLayout layout = ProductCardLayout.vertical,
  }) {
    return ProductCard(
      imageUrl: imageUrl,
      title: title,
      price: price,
      onAddToCart: onAddToCart,
      isSelected: isSelected,
      primaryInfo: deliveryTime != null ? _formatDeliveryTime(deliveryTime) : null,
      secondaryInfo: ingredients,
      primaryInfoColor: Color(0xFF969696),
      primaryInfoBackgroundColor: Colors.transparent,
      layout: layout,
      maxTitleLines: layout == ProductCardLayout.vertical ? 2 : 3,
      maxSecondaryInfoLines: layout == ProductCardLayout.vertical ? 1 : 2,
    );
  }

  /// Factory constructor para productos de ropa
  factory ProductCard.clothing({
    required String title,
    required double price,
    required VoidCallback onAddToCart,
    String? imageUrl,
    String? brand,
    String? color,
    List<String>? sizes,
    int? quantity,
    bool isSelected = false,
    ProductCardLayout layout = ProductCardLayout.vertical,
  }) {
    return ProductCard(
      imageUrl: imageUrl,
      title: title,
      price: price,
      onAddToCart: onAddToCart,
      isSelected: isSelected,
      primaryInfo: brand,
      secondaryInfo: sizes,
      actionBadge: quantity != null && quantity > 0 ? 'Stock: $quantity' : null,
      primaryInfoColor: Color(0xFF969696),
      primaryInfoBackgroundColor: Colors.transparent,
      actionBadgeColor: Color(0xFF969696),
      secondaryInfoPrefix: 'Tallas: ',
      layout: layout,
      maxTitleLines: layout == ProductCardLayout.vertical ? 2 : 3,
      maxSecondaryInfoLines: layout == ProductCardLayout.vertical ? 1 : 2,
    );
  }

  static String _formatDeliveryTime(int deliveryTime) {
    if (deliveryTime < 60) {
      return 'Entrega en $deliveryTime minutos';
    } else if (deliveryTime < 1440) {
      int hours = deliveryTime ~/ 60;
      int minutes = deliveryTime % 60;
      return 'Entrega en $hours horas y $minutes minutos';
    } else {
      int days = deliveryTime ~/ 1440;
      int remainingMinutes = deliveryTime % 1440;
      int hours = remainingMinutes ~/ 60;
      int minutes = remainingMinutes % 60;
      return 'Entrega en $days días, $hours horas y $minutes minutos';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Usar constraints del LayoutBuilder para responsive más preciso
        final maxWidth = constraints.maxWidth;
        final isTablet = maxWidth >= 400;
        final isDesktop = maxWidth >= 600;

        return layout == ProductCardLayout.vertical
            ? _buildVerticalCard(context, isTablet, isDesktop)
            : _buildHorizontalCard(context, isTablet, isDesktop);
      },
    );
  }

  Widget _buildVerticalCard(BuildContext context, bool isTablet, bool isDesktop) {
    final verticalPadding = isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0);
    final horizontalPadding = isDesktop ? 10.0 : (isTablet ? 8.0 : 6.0);
    final spacing = isDesktop ? 8.0 : (isTablet ? 6.0 : 4.0);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: PuStyleContainers.borderAllContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Imagen del producto
          Expanded(
            flex: 3,
            child: ProductImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          SizedBox(height: spacing),

          // Información y acción
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Información del producto
                Expanded(
                  child: ProductInfoBlock(
                    title: title,
                    primaryInfo: primaryInfo,
                    secondaryInfo: secondaryInfo,
                    badge: badge,
                    primaryInfoColor: primaryInfoColor,
                    primaryInfoBackgroundColor: primaryInfoBackgroundColor,
                    badgeColor: badgeColor,
                    badgeBackgroundColor: badgeBackgroundColor,
                    primaryInfoPrefix: primaryInfoPrefix,
                    secondaryInfoPrefix: secondaryInfoPrefix,
                    maxTitleLines: maxTitleLines,
                    maxSecondaryInfoLines: maxSecondaryInfoLines,
                  ),
                ),

                SizedBox(height: spacing),

                // Precio y botón de acción
                ProductActionBlock(
                  price: price,
                  onAddToCart: onAddToCart,
                  isSelected: isSelected,
                  additionalBadge: actionBadge,
                  additionalBadgeColor: actionBadgeColor,
                  additionalBadgeBackgroundColor: actionBadgeBackgroundColor,
                  selectedIcon: selectedIcon,
                  unselectedIcon: unselectedIcon,
                  selectedButtonColor: selectedButtonColor,
                  unselectedButtonColor: unselectedButtonColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, bool isTablet, bool isDesktop) {
    final horizontalPadding = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
    final spacing = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
    final imageSize = isDesktop ? 90.0 : (isTablet ? 85.0 : 75.0);

    return Container(
      padding: EdgeInsets.all(horizontalPadding),
      decoration: PuStyleContainers.borderAllContainer,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Imagen del producto
            ProductImage(
              imageUrl: imageUrl,
              width: imageSize,
              height: imageSize,
              borderRadius: BorderRadius.circular(8),
            ),

            SizedBox(width: spacing),

            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Información del producto
                  Expanded(
                    child: ProductInfoBlock(
                      title: title,
                      primaryInfo: primaryInfo,
                      secondaryInfo: secondaryInfo,
                      badge: badge,
                      primaryInfoColor: primaryInfoColor,
                      primaryInfoBackgroundColor: primaryInfoBackgroundColor,
                      badgeColor: badgeColor,
                      badgeBackgroundColor: badgeBackgroundColor,
                      primaryInfoPrefix: primaryInfoPrefix,
                      secondaryInfoPrefix: secondaryInfoPrefix,
                      maxTitleLines: maxTitleLines,
                      maxSecondaryInfoLines: maxSecondaryInfoLines,
                    ),
                  ),

                  SizedBox(height: spacing / 2),

                  // Precio y botón de acción
                  ProductActionBlock(
                    price: price,
                    onAddToCart: onAddToCart,
                    isSelected: isSelected,
                    additionalBadge: actionBadge,
                    additionalBadgeColor: actionBadgeColor,
                    additionalBadgeBackgroundColor: actionBadgeBackgroundColor,
                    selectedIcon: selectedIcon,
                    unselectedIcon: unselectedIcon,
                    selectedButtonColor: selectedButtonColor,
                    unselectedButtonColor: unselectedButtonColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
