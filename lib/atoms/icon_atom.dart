import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

/// Átomo genérico para iconos
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Muestra un ícono con estilo consistente
/// - Soporta diferentes tamaños y colores
/// - Completamente agnóstico del dominio
///
/// Puede usarse para cualquier ícono en la aplicación.
class IconAtom extends StatelessWidget {
  const IconAtom({
    super.key,
    required this.icon,
    this.size = 20,
    this.color,
    this.semanticLabel,
  });

  /// Ícono a mostrar
  final IconData icon;

  /// Tamaño del ícono
  final double size;

  /// Color del ícono (opcional, usa color primario si no se especifica)
  final Color? color;

  /// Etiqueta semántica para accesibilidad
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? PUColors.primaryColor,
      semanticLabel: semanticLabel,
    );
  }
}
