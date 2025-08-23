import 'package:flutter/material.dart';
import 'package:pu_material/widgets/pu_robust_network_image.dart';

/// Átomo: Imagen del producto
class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ProductImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        // Responsive image dimensions
        final defaultHeight = height ?? (isDesktop ? 160.0 : (isTablet ? 150.0 : 120.0));
        final defaultWidth = width ?? double.infinity;

        Widget imageWidget = PuRobustNetworkImage(
          imageUrl: imageUrl ?? '',
          height: defaultHeight,
          width: defaultWidth,
          fit: fit,
          clearCacheOnError: true,
        );

        if (borderRadius != null) {
          return ClipRRect(
            borderRadius: borderRadius!,
            child: imageWidget,
          );
        }

        return imageWidget;
      },
    );
  }
}
