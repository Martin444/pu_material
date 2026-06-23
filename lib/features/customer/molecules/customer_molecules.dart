import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:menu_dart_api/menu_com_api.dart';
import 'package:pu_material/pu_material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerInfoTile extends StatelessWidget {
  const CustomerInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InfoTileMolecule(
      icon: icon,
      title: title,
      subtitle: subtitle,
    );
  }
}

class CommerceCard extends StatelessWidget {
  const CommerceCard({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.email,
    this.phone,
    this.isEmailVerified,
    this.memberSince,
    this.lastActivity,
    this.menus,
    this.storeUrl,
    this.onTap,
  });

  final String name;
  final String category;
  final double rating;
  final String distance;
  final String imageUrl;
  final String? email;
  final String? phone;
  final bool? isEmailVerified;
  final DateTime? memberSince;
  final DateTime? lastActivity;
  final List<CatalogModel>? menus;
  final String? storeUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final isTablet =
            constraints.maxWidth >= 768 && constraints.maxWidth < 1200;

        if (isMobile) {
          return _buildMobileCard(context);
        } else if (isTablet) {
          return _buildTabletCard(context);
        } else {
          return _buildDesktopCard(context);
        }
      },
    );
  }

  Widget _buildMobileCard(BuildContext context) {
    return BusinessCardMolecule(
      name: name,
      category: category,
      imageUrl: imageUrl,
      isVerified: isEmailVerified ?? false,
      contactInfo: _buildContactInfo(),
      additionalInfo: _buildAdditionalInfo(),
      badges: _buildBadges(),
      actions: _buildMobileActions(),
      storeURL: storeUrl,
      onStoreUrlTap: _launchStoreUrl,
      onTap: onTap ?? _launchStoreUrl,
    );
  }

  Widget _buildTabletCard(BuildContext context) {
    return BusinessCardMolecule(
      name: name,
      category: category,
      imageUrl: imageUrl,
      isVerified: isEmailVerified ?? false,
      contactInfo: _buildContactInfo(),
      additionalInfo: _buildAdditionalInfo(),
      badges: _buildBadges(),
      actions: _buildActions(),
      storeURL: storeUrl,
      onStoreUrlTap: _launchStoreUrl,
      onTap: onTap ?? _launchStoreUrl,
    );
  }

  Widget _buildDesktopCard(BuildContext context) {
    return BusinessCardMolecule(
      name: name,
      category: category,
      imageUrl: imageUrl,
      isVerified: isEmailVerified ?? false,
      contactInfo: _buildContactInfo(),
      additionalInfo: _buildAdditionalInfo(),
      badges: _buildBadges(),
      actions: _buildActions(),
      storeURL: storeUrl,
      onStoreUrlTap: _launchStoreUrl,
      onTap: onTap ?? _launchStoreUrl,
    );
  }

  List<BusinessCardAction> _buildMobileActions() {
    List<BusinessCardAction> actionList = [];

    if (phone != null && phone!.trim().isNotEmpty) {
      actionList.add(BusinessCardAction(
        label: 'Llamar',
        icon: FluentIcons.phone_24_regular,
        onPressed: () => _launchPhoneCall(phone!),
        backgroundColor: Colors.blue,
      ));
    }

    if (storeUrl != null && storeUrl!.trim().isNotEmpty) {
      actionList.add(BusinessCardAction(
        label: 'Web',
        icon: FluentIcons.globe_24_regular,
        onPressed: _launchStoreUrl,
        backgroundColor: Colors.green,
      ));
    }

    return actionList;
  }

  List<ContactInfo> _buildContactInfo() {
    List<ContactInfo> contactList = [];

    if (phone != null && phone!.trim().isNotEmpty) {
      contactList.add(ContactInfo(
        icon: FluentIcons.phone_24_regular,
        value: _formatPhoneNumber(phone!),
      ));
    }

    return contactList;
  }

  List<AdditionalInfo> _buildAdditionalInfo() {
    List<AdditionalInfo> infoList = [];

    if (memberSince != null) {
      infoList.add(AdditionalInfo(
        text: _formatMemberSince(memberSince!),
        icon: FluentIcons.calendar_24_regular,
        color: PUColors.primaryColor,
      ));
    }

    if (lastActivity != null) {
      final isRecent = _isRecentActivity(lastActivity!);
      infoList.add(AdditionalInfo(
        text: _formatLastActivity(lastActivity!),
        icon: FluentIcons.presence_available_24_regular,
        color: isRecent ? Colors.green[700] : PUColors.textColor3,
      ));
    }

    if (menus != null && menus!.isNotEmpty) {
      final totalItems = _getTotalMenuItems();
      final avgDeliveryTime = _getAverageDeliveryTime();

      if (totalItems > 0) {
        infoList.add(AdditionalInfo(
          text: '$totalItems productos disponibles',
          icon: FluentIcons.food_24_regular,
          color: Colors.orange[600],
        ));
      }

      if (avgDeliveryTime > 0) {
        infoList.add(AdditionalInfo(
          text: 'Entrega promedio: ${avgDeliveryTime}min',
          icon: FluentIcons.clock_24_regular,
          color: Colors.blue[600],
        ));
      }
    }

    return infoList;
  }

  List<BadgeInfo> _buildBadges() {
    List<BadgeInfo> badgeList = [];

    if (menus != null && menus!.isNotEmpty) {
      final totalItems = _getTotalMenuItems();
      if (totalItems > 0) {
        badgeList.add(BadgeInfo(
          text: '$totalItems platos',
          backgroundColor: Colors.green.withOpacity(0.15),
          borderColor: Colors.green.withOpacity(0.4),
          textColor: Colors.green[700]!,
        ));
      }

      final avgDeliveryTime = _getAverageDeliveryTime();
      if (avgDeliveryTime > 0) {
        String deliveryText;
        Color badgeColor;

        if (avgDeliveryTime <= 30) {
          deliveryText = 'Entrega rápida';
          badgeColor = Colors.green;
        } else if (avgDeliveryTime <= 60) {
          deliveryText = 'Entrega normal';
          badgeColor = Colors.orange;
        } else {
          deliveryText = 'Entrega lenta';
          badgeColor = Colors.red;
        }

        badgeList.add(BadgeInfo(
          text: deliveryText,
          backgroundColor: badgeColor.withOpacity(0.15),
          borderColor: badgeColor.withOpacity(0.4),
          textColor: badgeColor,
        ));
      }
    }

    if (isEmailVerified == true) {
      badgeList.add(BadgeInfo(
        text: '✓ Verificado',
        backgroundColor: Colors.blue.withOpacity(0.15),
        borderColor: Colors.blue.withOpacity(0.4),
        textColor: Colors.blue,
      ));
    }

    return badgeList;
  }

  List<BusinessCardAction> _buildActions() {
    List<BusinessCardAction> actionList = [];

    if (menus != null && menus!.isNotEmpty && _getTotalMenuItems() > 0) {
      actionList.add(BusinessCardAction(
        label: 'Ver Menú',
        icon: FluentIcons.food_24_regular,
        onPressed: () {
          debugPrint('Ver menú de $name');
        },
        backgroundColor: PUColors.primaryColor,
      ));
    }

    if (storeUrl != null && storeUrl!.trim().isNotEmpty) {
      actionList.add(BusinessCardAction(
        label: 'Tienda Web',
        icon: FluentIcons.globe_24_regular,
        onPressed: _launchStoreUrl,
        backgroundColor: Colors.green,
      ));
    }

    if (phone != null && phone!.trim().isNotEmpty) {
      actionList.add(BusinessCardAction(
        label: 'Llamar',
        icon: FluentIcons.phone_24_regular,
        onPressed: () => _launchPhoneCall(phone!),
        backgroundColor: Colors.blue,
      ));
    }

    return actionList;
  }

  String _formatMemberSince(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 30) {
      return 'Nuevo';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}m';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}a';
    }
  }

  String _formatLastActivity(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return 'Activo ahora';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays}d';
    } else {
      return 'Inactivo';
    }
  }

  bool _isRecentActivity(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    return difference.inHours < 24;
  }

  String _formatPhoneNumber(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.isEmpty) return phone;

    if (cleanPhone.length == 10) {
      return '(${cleanPhone.substring(0, 3)}) ${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6)}';
    } else if (cleanPhone.length == 11 && cleanPhone.startsWith('1')) {
      return '+1 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7)}';
    } else if (cleanPhone.length >= 8) {
      if (cleanPhone.length > 10) {
        return '+${cleanPhone.substring(0, cleanPhone.length - 10)} ${cleanPhone.substring(cleanPhone.length - 10, cleanPhone.length - 7)}-${cleanPhone.substring(cleanPhone.length - 7, cleanPhone.length - 4)}-${cleanPhone.substring(cleanPhone.length - 4)}';
      } else {
        return '${cleanPhone.substring(0, cleanPhone.length - 4)}-${cleanPhone.substring(cleanPhone.length - 4)}';
      }
    }

    return phone;
  }

  int _getTotalMenuItems() {
    if (menus == null || menus!.isEmpty) {
      debugPrint('CommerceCard: No catalogs data for $name');
      return 0;
    }
    int total = 0;
    for (final catalog in menus!) {
      if (catalog.items != null) {
        total += catalog.items!.length;
      }
    }
    return total;
  }

  int _getAverageDeliveryTime() {
    if (menus == null || menus!.isEmpty) {
      return 0;
    }
    int totalTime = 0;
    int itemCount = 0;
    for (final catalog in menus!) {
      if (catalog.items != null) {
        for (final item in catalog.items!) {
          final deliveryTime = item.attributes?['deliveryTime'] as int?;
          if (deliveryTime != null) {
            totalTime += deliveryTime;
            itemCount++;
          }
        }
      }
    }
    return itemCount > 0 ? (totalTime / itemCount).round() : 0;
  }

  Future<void> _launchStoreUrl() async {
    if (storeUrl == null || storeUrl!.trim().isEmpty) {
      debugPrint('CommerceCard: No store URL provided');
      return;
    }

    try {
      String urlToLaunch = storeUrl!.trim();
      if (!urlToLaunch.startsWith('http://') &&
          !urlToLaunch.startsWith('https://')) {
        urlToLaunch = 'https://$urlToLaunch';
      }

      final Uri url = Uri.parse(urlToLaunch);

      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('CommerceCard: Cannot launch URL: $urlToLaunch');
      }
    } catch (e) {
      debugPrint('CommerceCard: Error launching URL: $e');
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    if (phoneNumber.trim().isEmpty) {
      debugPrint('CommerceCard: No phone number provided');
      return;
    }

    try {
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      if (!cleanPhone.startsWith('+')) {
        if (cleanPhone.length == 10) {
          cleanPhone = '+1$cleanPhone';
        }
      }

      final Uri telUri = Uri.parse('tel:$cleanPhone');

      if (await canLaunchUrl(telUri)) {
        await launchUrl(
          telUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('CommerceCard: Cannot launch phone call to: $cleanPhone');
      }
    } catch (e) {
      debugPrint('CommerceCard: Error launching phone call: $e');
    }
  }
}

class CustomerWelcomeHeader extends StatelessWidget {
  const CustomerWelcomeHeader({
    super.key,
    required this.userName,
    required this.isMobile,
  });

  final String userName;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return WelcomeHeaderMolecule(
      userName: userName,
      description: 'Bienvenido a tu panel de cliente',
      isCompact: isMobile,
    );
  }
}

class CustomerNotification extends StatelessWidget {
  const CustomerNotification({
    super.key,
    required this.message,
    this.icon = FluentIcons.info_24_regular,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return NotificationMolecule(
      message: message,
      icon: icon,
      type: NotificationType.info,
    );
  }
}
