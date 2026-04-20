import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../atoms/container_atom.dart';
import '../atoms/title_atom.dart';
import '../atoms/subtitle_atom.dart';
import '../atoms/icon_atom.dart';
import '../widgets/pu_robust_network_image.dart';

/// Molécula genérica para cards de negocios/entidades
///
/// Implementa atomic design combinando átomos básicos:
/// - ContainerAtom para el layout base
/// - TitleAtom y SubtitleAtom para información textual
/// - IconAtom para elementos visuales
/// - RobustNetworkImage para manejo robusto de imágenes
///
/// Esta molécula es altamente configurable y reutilizable,
/// permitiendo construir cards de diferentes tipos de entidades
/// (restaurantes, negocios, usuarios, etc.)
class BusinessCardMolecule extends StatelessWidget {
  const BusinessCardMolecule({
    super.key,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.isVerified,
    this.contactInfo = const [],
    this.additionalInfo = const [],
    this.badges = const [],
    this.actions = const [],
    this.storeURL,
    this.onStoreUrlTap,
    this.backgroundColor,
    this.borderRadius = 12,
    this.elevation = 2,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  /// Nombre principal de la entidad
  final String name;

  /// Categoría o subtítulo
  final String category;

  /// URL de la imagen principal
  final String imageUrl;

  /// Si la entidad está verificada
  final bool isVerified;

  /// Lista de información de contacto
  final List<ContactInfo> contactInfo;

  /// Lista de información adicional
  final List<AdditionalInfo> additionalInfo;

  /// Lista de badges/etiquetas
  final List<BadgeInfo> badges;

  /// Lista de acciones disponibles
  final List<BusinessCardAction> actions;

  /// URL de la tienda para redirección
  final String? storeURL;

  /// Callback cuando se toca el botón de la tienda
  final VoidCallback? onStoreUrlTap;

  /// Color de fondo personalizado
  final Color? backgroundColor;

  /// Radio de borde
  final double borderRadius;

  /// Elevación de la card
  final double elevation;

  /// Padding interno
  final EdgeInsets padding;

  /// Callback cuando se toca la card
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Usar solo las acciones pasadas externamente, sin agregar botón automático
    final allActions = <BusinessCardAction>[...actions];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header principal
                BusinessCardHeader(
                  name: name,
                  category: category,
                  imageUrl: imageUrl,
                  isVerified: isVerified,
                ),

                // Información de contacto
                if (contactInfo.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1, thickness: 0.5, color: Color(0xFFF1F1F0)),
                  const SizedBox(height: 16),
                  BusinessCardContactSection(contactInfo: contactInfo),
                ],

                // Información adicional
                if (additionalInfo.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  BusinessCardAdditionalInfoSection(additionalInfo: additionalInfo),
                ],

                // Badges
                if (badges.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  BusinessCardBadgesSection(badges: badges),
                ],

                // Acciones
                if (allActions.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  BusinessCardActionsSection(actions: allActions),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget para el header de la business card
class BusinessCardHeader extends StatelessWidget {
  const BusinessCardHeader({
    super.key,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.isVerified,
  });

  final String name;
  final String category;
  final String imageUrl;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Imagen circular premium
        BusinessCardImage(imageUrl: imageUrl, size: 70),

        const SizedBox(width: 16),

        // Información textual
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre con verificación Gold
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: PuTextStyle.title3.copyWith(
                        color: PUColors.textColorRich,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isVerified) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.verified_rounded,
                      size: 18,
                      color: PUColors.accentColor,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 2),

              // Categoría con estilo minimalista
              Text(
                category.toUpperCase(),
                style: PuTextStyle.bodySmall.copyWith(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: PUColors.accentColor,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget para la imagen de la business card (Circular con borde fino)
class BusinessCardImage extends StatelessWidget {
  const BusinessCardImage({
    super.key,
    required this.imageUrl,
    this.size = 60,
  });

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF1F1F0), width: 1),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: PuRobustNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: size,
          height: size,
        ),
      ),
    );
  }
}

/// Widget para sección de contacto
class BusinessCardContactSection extends StatelessWidget {
  const BusinessCardContactSection({
    super.key,
    required this.contactInfo,
  });

  final List<ContactInfo> contactInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contactInfo
          .map((contact) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    IconAtom(
                      icon: contact.icon,
                      size: 16,
                      color: PUColors.textColor3, // Color más oscuro para iconos
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SubtitleAtom(
                        text: contact.value,
                        fontSize: 13,
                        color: PUColors.textColor3, // Cambiar a textColor3 para mejor contraste
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

/// Widget para sección de información adicional
class BusinessCardAdditionalInfoSection extends StatelessWidget {
  const BusinessCardAdditionalInfoSection({
    super.key,
    required this.additionalInfo,
  });

  final List<AdditionalInfo> additionalInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: additionalInfo
          .map((info) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (info.icon != null) ...[
                    IconAtom(
                      icon: info.icon!,
                      size: 14,
                      color: info.color ?? PUColors.textColor3,
                    ),
                    const SizedBox(width: 4),
                  ],
                  SubtitleAtom(
                    text: info.text,
                    fontSize: 12,
                    color: info.color ?? PUColors.textColor3,
                    maxLines: 1,
                  ),
                ],
              ))
          .toList(),
    );
  }
}

/// Widget para sección de badges
class BusinessCardBadgesSection extends StatelessWidget {
  const BusinessCardBadgesSection({
    super.key,
    required this.badges,
  });

  final List<BadgeInfo> badges;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: badges
          .map((badge) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badge.backgroundColor,
                  border: Border.all(
                    color: badge.borderColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SubtitleAtom(
                  text: badge.text,
                  fontSize: 11,
                  color: badge.textColor,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ))
          .toList(),
    );
  }
}

/// Widget para sección de acciones
class BusinessCardActionsSection extends StatelessWidget {
  const BusinessCardActionsSection({
    super.key,
    required this.actions,
  });

  final List<BusinessCardAction> actions;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    // En pantallas pequeñas o con 3+ acciones, usar Wrap
    // En pantallas normales con 1-2 acciones, usar Row con Expanded
    if (isSmallScreen || actions.length > 2) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: actions
            .asMap()
            .entries
            .map((entry) => BusinessCardActionButton(
                  action: entry.value,
                  isFirst: entry.key == 0,
                  isLast: entry.key == actions.length - 1,
                  isExpanded: false,
                  isSmallScreen: isSmallScreen,
                ))
            .toList(),
      );
    } else {
      return Row(
        children: actions
            .asMap()
            .entries
            .map((entry) => Expanded(
                  child: BusinessCardActionButton(
                    action: entry.value,
                    isFirst: entry.key == 0,
                    isLast: entry.key == actions.length - 1,
                    isExpanded: true,
                    isSmallScreen: isSmallScreen,
                  ),
                ))
            .toList(),
      );
    }
  }
}

/// Widget para botón de acción individual
class BusinessCardActionButton extends StatelessWidget {
  const BusinessCardActionButton({
    super.key,
    required this.action,
    required this.isFirst,
    required this.isLast,
    this.isExpanded = false,
    this.isSmallScreen = false,
  });

  final BusinessCardAction action;
  final bool isFirst;
  final bool isLast;
  final bool isExpanded;
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    // Ajustar tamaños según el tipo de pantalla
    final double fontSize = isSmallScreen ? 12 : 14;
    final double iconSize = isSmallScreen ? 14 : 16;
    final EdgeInsets padding = isSmallScreen
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
    final Size minimumSize = isSmallScreen ? const Size(70, 36) : const Size(80, 40);

    Widget button = ElevatedButton.icon(
      onPressed: action.onPressed,
      icon: IconAtom(
        icon: action.icon,
        size: iconSize,
        color: action.iconColor ?? Colors.white,
      ),
      label: Text(
        action.label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: action.textColor ?? Colors.white,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: action.backgroundColor ?? PUColors.primaryColor,
        elevation: 0,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: minimumSize,
      ),
    );

    if (isExpanded) {
      return Padding(
        padding: EdgeInsets.only(
          left: !isFirst ? 4 : 0,
          right: !isLast ? 4 : 0,
        ),
        child: button,
      );
    } else {
      return button;
    }
  }
}

/// Clase para información de contacto
class ContactInfo {
  final IconData icon;
  final String value;

  const ContactInfo({
    required this.icon,
    required this.value,
  });
}

/// Clase para información adicional
class AdditionalInfo {
  final String text;
  final IconData? icon;
  final Color? color;

  const AdditionalInfo({
    required this.text,
    this.icon,
    this.color,
  });
}

/// Clase para badges/etiquetas
class BadgeInfo {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const BadgeInfo({
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
}

/// Clase para acciones de la card
class BusinessCardAction {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const BusinessCardAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });
}
