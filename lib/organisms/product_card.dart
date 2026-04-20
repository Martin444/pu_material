import 'package:flutter/material.dart';
import 'package:pu_material/atoms/product_image.dart';
import 'package:pu_material/molecule/product_info_block.dart';
import 'package:pu_material/molecule/product_action_block.dart';
import 'package:pu_material/utils/pu_colors.dart';

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
      primaryInfoColor: const Color(0xFF969696),
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
      primaryInfoColor: const Color(0xFF969696),
      primaryInfoBackgroundColor: Colors.transparent,
      actionBadgeColor: const Color(0xFF969696),
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
        // Sistema responsive mejorado
        final maxWidth = constraints.maxWidth;
        final screenWidth = MediaQuery.of(context).size.width;

        // Breakpoints adaptativos que consideran tanto el screen como el widget
        final isDesktop = screenWidth >= 800 && maxWidth >= 280;
        final isTablet = screenWidth >= 600 && maxWidth >= 220;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: layout == ProductCardLayout.vertical
                ? _buildVerticalCard(context, isTablet, isDesktop)
                : _buildHorizontalCard(context, isTablet, isDesktop),
          ),
        );
      },
    );
  }

  Widget _buildVerticalCard(BuildContext context, bool isTablet, bool isDesktop) {
    final verticalPadding = isDesktop ? 12.0 : 8.0;
    final horizontalPadding = isDesktop ? 12.0 : 8.0;
    final spacing = isDesktop ? 12.0 : 8.0;
    final borderRadius = 16.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 1.0, end: 1.0), // Scale effect can be added here if wrapped in a stateful widget or using a custom hover state
        builder: (context, scale, child) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            decoration: _buildCardDecoration(context, borderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(bottom: spacing),
                    child: ProductImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(borderRadius - 4),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProductInfoBlock(
                        title: title,
                        primaryInfo: primaryInfo,
                        secondaryInfo: secondaryInfo,
                        badge: badge,
                        primaryInfoColor: primaryInfoColor,
                        maxTitleLines: maxTitleLines,
                        maxSecondaryInfoLines: maxSecondaryInfoLines,
                      ),
                      const Spacer(),
                      ProductActionBlock(
                        price: price,
                        onAddToCart: onAddToCart,
                        isSelected: isSelected,
                        additionalBadge: actionBadge,
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
        },
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, bool isTablet, bool isDesktop) {
    final padding = 12.0;
    final spacing = 12.0;
    final imageSize = isDesktop ? 90.0 : 70.0;
    final borderRadius = 16.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: _buildCardDecoration(context, borderRadius),
      child: Row(
        children: [
          ProductImage(
            imageUrl: imageUrl,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(borderRadius - 4),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductInfoBlock(
                  title: title,
                  primaryInfo: primaryInfo,
                  secondaryInfo: secondaryInfo,
                  badge: badge,
                  primaryInfoColor: primaryInfoColor,
                  maxTitleLines: 2,
                  maxSecondaryInfoLines: 1,
                ),
                ProductActionBlock(
                  price: price,
                  onAddToCart: onAddToCart,
                  isSelected: isSelected,
                  additionalBadge: actionBadge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context, double borderRadius) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
      border: Border.all(
        color: isSelected ? PUColors.accentColor.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.05),
        width: isSelected ? 1.5 : 1,
      ),
    );
  }
}
