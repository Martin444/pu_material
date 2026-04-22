import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../atoms/icon_atom.dart';
import '../atoms/subtitle_atom.dart';
import '../atoms/container_atom.dart';
import '../utils/pu_colors.dart';

/// Molécula genérica para notificaciones y mensajes
///
/// Implementa atomic design combinando átomos básicos:
/// - IconAtom para representación visual del tipo de notificación
/// - SubtitleAtom para el mensaje
/// - ContainerAtom para el layout base
///
/// Esta molécula es completamente agnóstica del dominio y puede
/// reutilizarse para cualquier tipo de notificación o mensaje.
class NotificationMolecule extends StatelessWidget {
  const NotificationMolecule({
    super.key,
    required this.message,
    this.type = NotificationType.info,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.onDismiss,
    this.onTap,
  });

  /// Mensaje de la notificación
  final String message;

  /// Tipo de notificación que determina el estilo por defecto
  final NotificationType type;

  /// Ícono personalizado (opcional, usa ícono por defecto del tipo si no se especifica)
  final IconData? icon;

  /// Color de fondo personalizado (opcional)
  final Color? backgroundColor;

  /// Color del ícono personalizado (opcional)
  final Color? iconColor;

  /// Color del texto personalizado (opcional)
  final Color? textColor;

  /// Callback para descartar la notificación (opcional)
  final VoidCallback? onDismiss;

  /// Callback para cuando se toca la notificación (opcional)
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerAtom(
        variant: ContainerVariant.compact,
        backgroundColor: backgroundColor ?? _getDefaultBackgroundColor(),
        borderColor: _getDefaultBorderColor(),
        borderWidth: 1,
        child: Row(
          children: [
            // Ícono de tipo de notificación
            IconAtom(
              icon: icon ?? _getDefaultIcon(),
              color: iconColor ?? _getDefaultIconColor(),
              size: 20,
            ),

            const SizedBox(width: 12),

            // Mensaje
            Expanded(
              child: SubtitleAtom(
                text: message,
                variant: SubtitleVariant.description,
                color: textColor ?? _getDefaultTextColor(),
              ),
            ),

            // Botón de cerrar si está disponible
            if (onDismiss != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDismiss,
                child: IconAtom(
                  icon: FluentIcons.dismiss_24_regular,
                  size: 16,
                  color: _getDefaultIconColor().withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getDefaultIcon() {
    switch (type) {
      case NotificationType.info:
        return FluentIcons.info_24_regular;
      case NotificationType.success:
        return FluentIcons.checkmark_circle_24_regular;
      case NotificationType.warning:
        return FluentIcons.warning_24_regular;
      case NotificationType.error:
        return FluentIcons.error_circle_24_regular;
    }
  }

  Color _getDefaultBackgroundColor() {
    switch (type) {
      case NotificationType.info:
        return PUColors.primaryColor.withValues(alpha: 0.1);
      case NotificationType.success:
        return Colors.green.withValues(alpha: 0.1);
      case NotificationType.warning:
        return Colors.orange.withValues(alpha: 0.1);
      case NotificationType.error:
        return Colors.red.withValues(alpha: 0.1);
    }
  }

  Color _getDefaultBorderColor() {
    switch (type) {
      case NotificationType.info:
        return PUColors.primaryColor.withValues(alpha: 0.3);
      case NotificationType.success:
        return Colors.green.withValues(alpha: 0.3);
      case NotificationType.warning:
        return Colors.orange.withValues(alpha: 0.3);
      case NotificationType.error:
        return Colors.red.withValues(alpha: 0.3);
    }
  }

  Color _getDefaultIconColor() {
    switch (type) {
      case NotificationType.info:
        return PUColors.primaryColor;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
    }
  }

  Color _getDefaultTextColor() {
    return PUColors.textColor2;
  }
}

/// Enumera los diferentes tipos de notificación disponibles
enum NotificationType {
  /// Notificación informativa
  info,

  /// Notificación de éxito
  success,

  /// Notificación de advertencia
  warning,

  /// Notificación de error
  error,
}
