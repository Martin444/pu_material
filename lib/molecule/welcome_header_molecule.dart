import 'package:flutter/material.dart';
import '../atoms/user_avatar_atom.dart';
import '../atoms/title_atom.dart';
import '../atoms/subtitle_atom.dart';
import '../atoms/container_atom.dart';

/// Molécula genérica para headers de bienvenida
///
/// Implementa atomic design combinando átomos básicos:
/// - UserAvatarAtom para representación del usuario
/// - TitleAtom para saludo personalizado
/// - SubtitleAtom para mensaje descriptivo
/// - ContainerAtom para el layout base
///
/// Esta molécula es completamente agnóstica del dominio y puede
/// reutilizarse para cualquier tipo de usuario o contexto.
class WelcomeHeaderMolecule extends StatelessWidget {
  const WelcomeHeaderMolecule({
    super.key,
    required this.userName,
    this.welcomeMessage,
    this.description,
    this.avatarSize = 56,
    this.avatarImageUrl,
    this.avatarIcon,
    this.spacing = 16,
    this.containerVariant = ContainerVariant.card,
    this.isCompact = false,
    this.onAvatarTap,
  });

  /// Nombre del usuario para personalizar el saludo
  final String userName;

  /// Mensaje de bienvenida personalizado (opcional)
  /// Si no se proporciona, usa un saludo genérico
  final String? welcomeMessage;

  /// Descripción adicional (opcional)
  final String? description;

  /// Tamaño del avatar
  final double avatarSize;

  /// URL de imagen para el avatar (opcional)
  final String? avatarImageUrl;

  /// Ícono para el avatar (opcional)
  final IconData? avatarIcon;

  /// Espaciado entre el avatar y el contenido de texto
  final double spacing;

  /// Variante del contenedor
  final ContainerVariant containerVariant;

  /// Si debe usar el diseño compacto
  final bool isCompact;

  /// Callback opcional para cuando se toca el avatar
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: containerVariant,
      padding: EdgeInsets.all(isCompact ? 16 : 24),
      child: Row(
        children: [
          // Avatar del usuario
          GestureDetector(
            onTap: onAvatarTap,
            child: UserAvatarAtom(
              size: isCompact ? avatarSize * 0.85 : avatarSize,
              imageUrl: avatarImageUrl,
              icon: avatarIcon ?? Icons.person,
            ),
          ),

          SizedBox(width: spacing),

          // Contenido de texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Saludo personalizado
                TitleAtom(
                  text: welcomeMessage ?? '¡Hola, $userName!',
                  level: isCompact ? TitleLevel.h3 : TitleLevel.h2,
                ),

                // Descripción si está disponible
                if (description != null) ...[
                  const SizedBox(height: 4),
                  SubtitleAtom(
                    text: description!,
                    variant: SubtitleVariant.description,
                    fontSize: isCompact ? 14 : 16,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
