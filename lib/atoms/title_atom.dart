import 'package:flutter/material.dart';
import '../utils/style/pu_style_fonts.dart';
import '../utils/pu_colors.dart';

/// Átomo genérico para títulos
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Muestra texto con estilo de título
/// - Soporta diferentes niveles de jerarquía (h1, h2, h3, etc.)
/// - Completamente agnóstico del dominio
///
/// Puede usarse para cualquier texto que requiera formato de título.
class TitleAtom extends StatelessWidget {
  const TitleAtom({
    super.key,
    required this.text,
    this.level = TitleLevel.h2,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  /// Texto del título
  final String text;

  /// Nivel de jerarquía del título
  final TitleLevel level;

  /// Color del texto (opcional, usa color por defecto si no se especifica)
  final Color? color;

  /// Peso de la fuente (opcional, usa peso por defecto del nivel si no se especifica)
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
      style: _getStyleForLevel().copyWith(
        color: color ?? PUColors.textColor1,
        fontWeight: fontWeight ?? _getDefaultFontWeight(),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getStyleForLevel() {
    switch (level) {
      case TitleLevel.h1:
        return PuTextStyle.title1;
      case TitleLevel.h2:
        return PuTextStyle.title2;
      case TitleLevel.h3:
        return PuTextStyle.title3;
      case TitleLevel.subtitle:
        return PuTextStyle.nameProductStyle;
      case TitleLevel.section:
        return PuTextStyle.nameProductStyle;
    }
  }

  FontWeight _getDefaultFontWeight() {
    switch (level) {
      case TitleLevel.h1:
        return FontWeight.w700;
      case TitleLevel.h2:
        return FontWeight.w600;
      case TitleLevel.h3:
        return FontWeight.w600;
      case TitleLevel.subtitle:
        return FontWeight.w500;
      case TitleLevel.section:
        return FontWeight.w600;
    }
  }
}

/// Enumera los diferentes niveles de título disponibles
enum TitleLevel {
  /// Título principal (más grande)
  h1,

  /// Título secundario
  h2,

  /// Título terciario
  h3,

  /// Subtítulo
  subtitle,

  /// Título de sección
  section,
}
