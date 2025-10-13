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

  /// Si es true, usa layout adaptativo cuando hay restricciones de altura
  final bool useAdaptiveLayout;

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
    this.useAdaptiveLayout = true,
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

        // Si tenemos restricciones de altura y se solicita layout adaptativo, usamos un enfoque flexible
        if (useAdaptiveLayout && maxHeight != double.infinity && maxHeight > 0) {
          return _buildFlexibleLayout(spacing, maxHeight);
        }

        // Layout normal para casos sin restricciones de altura
        return _buildNormalLayout(spacing);
      },
    );
  }

  /// Layout flexible que se adapta a restricciones de altura
  Widget _buildFlexibleLayout(double spacing, double maxHeight) {
    // Calcular el espacio mínimo requerido para elementos no-flex
    final minSpaceForFixedElements = _calculateMinFixedSpace(spacing);
    final availableFlexSpace = maxHeight - minSpaceForFixedElements;

    // Si el espacio disponible es muy pequeño, usar layout compacto
    if (availableFlexSpace < 30) {
      return _buildCompactLayout(spacing);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Información primaria (tiempo de entrega, marca, etc.) - Siempre visible
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

        // Título del producto - Dar más espacio (flex: 4)
        Flexible(
          flex: 4,
          child: ProductTitle(
            title: title,
            maxLines: maxTitleLines,
            color: null,
          ),
        ),

        // Badge (stock, ofertas, etc.) - Siempre visible si existe
        if (badge != null) ...[
          SizedBox(height: spacing / 2),
          ProductBadge(
            text: badge!,
            textColor: badgeColor,
            backgroundColor: badgeBackgroundColor,
          ),
        ],

        // Información secundaria - Flexible y se ajusta al espacio disponible
        if (secondaryInfo != null && secondaryInfo!.isNotEmpty) ...[
          SizedBox(height: spacing),
          Flexible(
            flex: 1,
            child: ProductAdditionalInfo(
              text: secondaryInfo!.join(', '),
              prefix: secondaryInfoPrefix,
              maxLines: maxSecondaryInfoLines,
              textColor: null,
              backgroundColor: null,
              showBackground: false,
            ),
          ),
        ],
      ],
    );
  }

  /// Layout compacto para espacios muy restringidos
  Widget _buildCompactLayout(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Título con más espacio flexible
        Flexible(
          flex: 2,
          child: ProductTitle(
            title: title,
            maxLines: maxTitleLines.clamp(1, 2), // Al menos 1, máximo 2 líneas
            color: null,
          ),
        ),

        // Información primaria con menos prioridad
        if (primaryInfo != null) ...[
          SizedBox(height: spacing / 2),
          Flexible(
            flex: 1,
            child: ProductAdditionalInfo(
              text: primaryInfo!,
              textColor: primaryInfoColor,
              backgroundColor: primaryInfoBackgroundColor,
              prefix: primaryInfoPrefix,
              maxLines: 1,
              showBackground: false, // Sin fondo en modo compacto
            ),
          ),
        ],
      ],
    );
  }

  /// Calcula el espacio mínimo requerido por elementos no flexibles
  double _calculateMinFixedSpace(double spacing) {
    double totalSpace = 0;

    // Espacio estimado para información primaria (más conservador)
    if (primaryInfo != null) {
      totalSpace += 18 + spacing; // ~18px altura + spacing
    }

    // Espacio estimado para badge (más conservador)
    if (badge != null) {
      totalSpace += 18 + (spacing / 2); // ~18px altura + spacing reducido
    }

    // Espacio para información secundaria (más conservador)
    if (secondaryInfo != null && secondaryInfo!.isNotEmpty) {
      totalSpace += 14 + spacing; // ~14px altura + spacing
    }

    return totalSpace;
  }

  /// Layout normal para casos sin restricciones de altura
  Widget _buildNormalLayout(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
          color: null,
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
            textColor: null,
            backgroundColor: null,
            showBackground: false,
          ),
        ],
      ],
    );
  }
}
