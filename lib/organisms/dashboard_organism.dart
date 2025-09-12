import 'package:flutter/material.dart';
import '../molecule/welcome_header_molecule.dart';
import '../molecule/info_tile_molecule.dart';
import '../molecule/notification_molecule.dart';
import '../atoms/container_atom.dart';

/// Organismo genérico para dashboards
///
/// Implementa atomic design combinando molecules y otros organisms:
/// - WelcomeHeaderMolecule para el header personalizado
/// - NotificationMolecule para mensajes importantes
/// - InfoTileMolecule para información adicional
/// - Layouts responsivos para móvil y desktop
///
/// Este organismo es completamente agnóstico del dominio y puede
/// reutilizarse para cualquier tipo de dashboard.
class DashboardOrganism extends StatelessWidget {
  const DashboardOrganism({
    super.key,
    required this.userName,
    required this.mainContent,
    this.welcomeMessage,
    this.description,
    this.avatarImageUrl,
    this.notifications = const [],
    this.infoTiles = const [],
    this.sidebarContent,
    this.isMobile = false,
    this.onAvatarTap,
  });

  /// Nombre del usuario para personalizar el dashboard
  final String userName;

  /// Contenido principal del dashboard
  final Widget mainContent;

  /// Mensaje de bienvenida personalizado (opcional)
  final String? welcomeMessage;

  /// Descripción adicional (opcional)
  final String? description;

  /// URL de imagen del avatar (opcional)
  final String? avatarImageUrl;

  /// Lista de notificaciones a mostrar
  final List<DashboardNotification> notifications;

  /// Lista de tiles informativos
  final List<DashboardInfoTile> infoTiles;

  /// Contenido opcional del sidebar (solo en desktop)
  final Widget? sidebarContent;

  /// Si debe usar el layout móvil
  final bool isMobile;

  /// Callback cuando se toca el avatar
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header de bienvenida
        WelcomeHeaderMolecule(
          userName: userName,
          welcomeMessage: welcomeMessage,
          description: description,
          avatarImageUrl: avatarImageUrl,
          isCompact: true,
          onAvatarTap: onAvatarTap,
        ),

        const SizedBox(height: 16),

        // Contenido con scroll
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notificaciones
                if (notifications.isNotEmpty) ...[
                  _buildNotificationsSection(),
                  const SizedBox(height: 16),
                ],

                // Info tiles
                if (infoTiles.isNotEmpty) ...[
                  _buildInfoTilesSection(),
                  const SizedBox(height: 16),
                ],

                // Contenido principal
                mainContent,

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header de bienvenida
        WelcomeHeaderMolecule(
          userName: userName,
          welcomeMessage: welcomeMessage,
          description: description,
          avatarImageUrl: avatarImageUrl,
          isCompact: false,
          onAvatarTap: onAvatarTap,
        ),

        const SizedBox(height: 24),

        // Contenido principal en dos columnas
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contenido principal
              Expanded(
                flex: sidebarContent != null ? 7 : 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notificaciones
                    if (notifications.isNotEmpty) ...[
                      _buildNotificationsSection(),
                      const SizedBox(height: 16),
                    ],

                    // Contenido principal
                    Expanded(child: mainContent),
                  ],
                ),
              ),

              // Sidebar (solo si existe contenido)
              if (sidebarContent != null) ...[
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info tiles
                      if (infoTiles.isNotEmpty) ...[
                        _buildInfoTilesSection(),
                        const SizedBox(height: 16),
                      ],

                      // Contenido del sidebar
                      Expanded(child: sidebarContent!),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: notifications
          .map((notification) => Padding(
                padding: EdgeInsets.only(
                  bottom: notifications.indexOf(notification) < notifications.length - 1 ? 8 : 0,
                ),
                child: NotificationMolecule(
                  message: notification.message,
                  type: notification.type,
                  icon: notification.icon,
                  onDismiss: notification.onDismiss,
                  onTap: notification.onTap,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildInfoTilesSection() {
    return ContainerAtom(
      variant: ContainerVariant.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: infoTiles
            .map((tile) => Padding(
                  padding: EdgeInsets.only(
                    bottom: infoTiles.indexOf(tile) < infoTiles.length - 1 ? 16 : 0,
                  ),
                  child: InfoTileMolecule(
                    icon: tile.icon,
                    title: tile.title,
                    subtitle: tile.subtitle,
                    onTap: tile.onTap,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

/// Clase para notificaciones del dashboard
class DashboardNotification {
  final String message;
  final NotificationType type;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final VoidCallback? onTap;

  const DashboardNotification({
    required this.message,
    this.type = NotificationType.info,
    this.icon,
    this.onDismiss,
    this.onTap,
  });
}

/// Clase para tiles informativos del dashboard
class DashboardInfoTile {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const DashboardInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}
