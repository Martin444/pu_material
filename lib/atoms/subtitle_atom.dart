import 'package:flutter/material.dart';
import '../utils/style/pu_style_fonts.dart';
import '../utils/pu_colors.dart';

/// Átomo genérico para subtítulos y texto descriptivo
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Muestra texto con estilo de subtítulo o descripción
/// - Soporta diferentes variantes de texto secundario
/// - Completamente agnóstico del dominio
///
/// Puede usarse para cualquier texto secundario o descriptivo.
class SubtitleAtom extends StatelessWidget {
  const SubtitleAtom({
    super.key,
    required this.text,
    this.variant = SubtitleVariant.description,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  /// Texto del subtítulo
  final String text;

  /// Variante del subtítulo
  final SubtitleVariant variant;

  /// Color del texto (opcional, usa color por defecto si no se especifica)
  final Color? color;

  /// Tamaño de fuente personalizado (opcional)
  final double? fontSize;

  /// Peso de la fuente (opcional)
  final FontWeight? fontWeight;

  /// Alineación del texto
  final TextAlign textAlign;

  /// Número máximo de líneas
  final int? maxLines;

  /// Comportamiento cuando el texto desborda
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getStyleForVariant().copyWith(
        color: color ?? _getDefaultColor(),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getStyleForVariant() {
    switch (variant) {
      case SubtitleVariant.description:
        return PuTextStyle.description1;
      case SubtitleVariant.caption:
        return PuTextStyle.brandHeadStyle;
      case SubtitleVariant.helper:
        return PuTextStyle.brandHeadStyle;
      case SubtitleVariant.label:
        return PuTextStyle.description1;
    }
  }

  Color _getDefaultColor() {
    switch (variant) {
      case SubtitleVariant.description:
        return PUColors.textColor3;
      case SubtitleVariant.caption:
        return PUColors.textColor3;
      case SubtitleVariant.helper:
        return PUColors.textColor2;
      case SubtitleVariant.label:
        return PUColors.textColor2;
    }
  }
}

/// Enumera los diferentes tipos de subtítulo disponibles
enum SubtitleVariant {
  /// Texto descriptivo general
  description,

  /// Texto de caption o etiqueta pequeña
  caption,

  /// Texto de ayuda o instrucciones
  helper,

  /// Etiqueta o label
  label,
}
