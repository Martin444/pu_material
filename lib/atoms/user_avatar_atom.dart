import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../utils/pu_colors.dart';

/// Átomo genérico para avatares de usuario
///
/// Implementa atomic design con responsabilidades mínimas:
/// - Muestra un avatar circular con ícono o imagen
/// - Soporta diferentes tamaños y colores
/// - Completamente agnóstico del dominio
///
/// Puede usarse para cualquier tipo de usuario o entidad que requiera representación visual.
class UserAvatarAtom extends StatelessWidget {
  const UserAvatarAtom({
    super.key,
    required this.size,
    this.icon = FluentIcons.person_24_regular,
    this.backgroundColor,
    this.iconColor,
    this.imageUrl,
    this.borderColor,
    this.borderWidth = 0,
  });

  /// Tamaño del avatar (width y height)
  final double size;

  /// Ícono a mostrar cuando no hay imagen
  final IconData icon;

  /// Color de fondo del avatar
  final Color? backgroundColor;

  /// Color del ícono
  final Color? iconColor;

  /// URL de imagen opcional (si se proporciona, se usa en lugar del ícono)
  final String? imageUrl;

  /// Color del borde opcional
  final Color? borderColor;

  /// Ancho del borde
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? PUColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: borderWidth > 0 && borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildIconFallback(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoadingIndicator();
                },
              )
            : _buildIconFallback(),
      ),
    );
  }

  Widget _buildIconFallback() {
    return Icon(
      icon,
      size: size * 0.5,
      color: iconColor ?? PUColors.primaryColor,
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: size * 0.3,
        height: size * 0.3,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            iconColor ?? PUColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
