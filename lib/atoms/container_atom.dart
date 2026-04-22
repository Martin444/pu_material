import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

/// Átomo genérico para contenedores
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Proporciona un contenedor base con estilo consistente
/// - Soporta diferentes variantes de estilo
/// - Completamente agnóstico del dominio
///
/// Puede usarse como base para cualquier contenedor en la aplicación.
class ContainerAtom extends StatelessWidget {
  const ContainerAtom({
    super.key,
    required this.child,
    this.variant = ContainerVariant.card,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.boxShadow,
  });

  /// Widget hijo que se coloca dentro del contenedor
  final Widget child;

  /// Variante de estilo del contenedor
  final ContainerVariant variant;

  /// Padding interno
  final EdgeInsets? padding;

  /// Margin externo
  final EdgeInsets? margin;

  /// Ancho del contenedor
  final double? width;

  /// Alto del contenedor
  final double? height;

  /// Color de fondo personalizado
  final Color? backgroundColor;

  /// Color del borde personalizado
  final Color? borderColor;

  /// Radio del borde personalizado
  final BorderRadius? borderRadius;

  /// Ancho del borde personalizado
  final double? borderWidth;

  /// Sombra personalizada
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? _getDefaultPadding(),
      decoration: BoxDecoration(
        color: backgroundColor ?? _getDefaultBackgroundColor(),
        borderRadius: borderRadius ?? _getDefaultBorderRadius(),
        border: _getBorder(),
        boxShadow: boxShadow ?? _getDefaultBoxShadow(),
      ),
      child: child,
    );
  }

  EdgeInsets _getDefaultPadding() {
    switch (variant) {
      case ContainerVariant.card:
        return const EdgeInsets.all(16);
      case ContainerVariant.compact:
        return const EdgeInsets.all(12);
      case ContainerVariant.spacious:
        return const EdgeInsets.all(24);
      case ContainerVariant.minimal:
        return const EdgeInsets.all(8);
    }
  }

  Color _getDefaultBackgroundColor() {
    switch (variant) {
      case ContainerVariant.card:
        return PUColors.bgItem;
      case ContainerVariant.compact:
        return PUColors.bgItem;
      case ContainerVariant.spacious:
        return PUColors.bgItem;
      case ContainerVariant.minimal:
        return Colors.transparent;
    }
  }

  BorderRadius _getDefaultBorderRadius() {
    switch (variant) {
      case ContainerVariant.card:
        return BorderRadius.circular(12);
      case ContainerVariant.compact:
        return BorderRadius.circular(8);
      case ContainerVariant.spacious:
        return BorderRadius.circular(16);
      case ContainerVariant.minimal:
        return BorderRadius.circular(4);
    }
  }

  Border? _getBorder() {
    if (borderColor != null && borderWidth != null) {
      return Border.all(
        color: borderColor!,
        width: borderWidth!,
      );
    }

    switch (variant) {
      case ContainerVariant.card:
        return Border.all(
          color: PUColors.borderInputColor.withValues(alpha: 0.2),
          width: 1,
        );
      case ContainerVariant.compact:
        return Border.all(
          color: PUColors.borderInputColor.withValues(alpha: 0.15),
          width: 1,
        );
      case ContainerVariant.spacious:
        return Border.all(
          color: PUColors.borderInputColor.withValues(alpha: 0.2),
          width: 1,
        );
      case ContainerVariant.minimal:
        return null;
    }
  }

  List<BoxShadow>? _getDefaultBoxShadow() {
    switch (variant) {
      case ContainerVariant.card:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case ContainerVariant.compact:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ];
      case ContainerVariant.spacious:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case ContainerVariant.minimal:
        return null;
    }
  }
}

/// Enumera las diferentes variantes de contenedor disponibles
enum ContainerVariant {
  /// Contenedor tipo card estándar
  card,

  /// Contenedor compacto con menos padding
  compact,

  /// Contenedor espacioso con más padding
  spacious,

  /// Contenedor mínimo sin estilos adicionales
  minimal,
}
