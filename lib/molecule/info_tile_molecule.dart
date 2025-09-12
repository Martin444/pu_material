import 'package:flutter/material.dart';
import '../atoms/icon_atom.dart';
import '../atoms/title_atom.dart';
import '../atoms/subtitle_atom.dart';

/// Molécula genérica para tiles de información
///
/// Implementa atomic design combinando átomos básicos:
/// - IconAtom para representación visual
/// - TitleAtom para título principal
/// - SubtitleAtom para información secundaria
///
/// Esta molécula es completamente agnóstica del dominio y puede
/// reutilizarse para mostrar cualquier tipo de información estructurada.
class InfoTileMolecule extends StatelessWidget {
  const InfoTileMolecule({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 20,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.spacing = 12,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.onTap,
  });

  /// Ícono que representa la información
  final IconData icon;

  /// Título principal de la información
  final String title;

  /// Subtítulo o información secundaria
  final String subtitle;

  /// Tamaño del ícono
  final double iconSize;

  /// Color del ícono (opcional)
  final Color? iconColor;

  /// Color del título (opcional)
  final Color? titleColor;

  /// Color del subtítulo (opcional)
  final Color? subtitleColor;

  /// Espaciado entre el ícono y el contenido de texto
  final double spacing;

  /// Alineación cruzada de los elementos
  final CrossAxisAlignment crossAxisAlignment;

  /// Callback opcional para cuando se toca el tile
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // Ícono
        IconAtom(
          icon: icon,
          size: iconSize,
          color: iconColor,
        ),

        SizedBox(width: spacing),

        // Contenido de texto
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleAtom(
                text: title,
                level: TitleLevel.subtitle,
                color: titleColor,
              ),
              const SizedBox(height: 4),
              SubtitleAtom(
                text: subtitle,
                variant: SubtitleVariant.description,
                color: subtitleColor,
              ),
            ],
          ),
        ),
      ],
    );

    // Si hay onTap, envolver en GestureDetector
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
