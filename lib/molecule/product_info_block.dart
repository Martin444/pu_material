import 'package:flutter/material.dart';
import 'package:pu_material/atoms/product_title.dart';
import 'package:pu_material/atoms/product_additional_info.dart';
import 'package:pu_material/atoms/product_badge.dart';

/// Molécula: Bloque de información del producto
class ProductInfoBlock extends StatelessWidget {
  final String title;
  final String? primaryInfo;
  final List<String>? secondaryInfo;
  final String? badge;
  final Color? primaryInfoColor;
  final Color? primaryInfoBackgroundColor;
  final Color? badgeColor;
  final Color? badgeBackgroundColor;
  final String? primaryInfoPrefix;
  final String? secondaryInfoPrefix;
  final int maxTitleLines;
  final int maxSecondaryInfoLines;

  const ProductInfoBlock({
    super.key,
    required this.title,
    this.primaryInfo,
    this.secondaryInfo,
    this.badge,
    this.primaryInfoColor,
    this.primaryInfoBackgroundColor,
    this.badgeColor,
    this.badgeBackgroundColor,
    this.primaryInfoPrefix,
    this.secondaryInfoPrefix,
    this.maxTitleLines = 2,
    this.maxSecondaryInfoLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth >= 768;
        final isDesktop = screenWidth >= 1024;

        final spacing = isDesktop ? 8.0 : (isTablet ? 6.0 : 4.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información primaria (tiempo de entrega, marca, etc.)
            if (primaryInfo != null) ...[
              ProductAdditionalInfo(
                text: primaryInfo!,
                textColor: primaryInfoColor,
                backgroundColor: primaryInfoBackgroundColor,
                prefix: primaryInfoPrefix,
                maxLines: 1,
                showBackground: primaryInfoBackgroundColor != null,
              ),
              SizedBox(height: spacing),
            ],

            // Título del producto
            ProductTitle(
              title: title,
              maxLines: maxTitleLines,
            ),

            // Badge (stock, ofertas, etc.)
            if (badge != null) ...[
              SizedBox(height: spacing / 2),
              ProductBadge(
                text: badge!,
                textColor: badgeColor,
                backgroundColor: badgeBackgroundColor,
              ),
            ],

            // Información secundaria (ingredientes, tallas, etc.)
            if (secondaryInfo != null && secondaryInfo!.isNotEmpty) ...[
              SizedBox(height: spacing),
              ProductAdditionalInfo(
                text: secondaryInfo!.join(', '),
                prefix: secondaryInfoPrefix,
                maxLines: maxSecondaryInfoLines,
              ),
            ],
          ],
        );
      },
    );
  }
}
