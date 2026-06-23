import 'package:flutter/material.dart';
import 'package:menu_dart_api/menu_com_api.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

import '../atoms/customer_atoms.dart';
import '../molecules/customer_molecules.dart';

class CustomerFeaturedCommerces extends StatelessWidget {
  const CustomerFeaturedCommerces({
    super.key,
    required this.isMobile,
    required this.commercesList,
    required this.isLoading,
    required this.accessTokenHashed,
    this.onCommerceSelected,
  });

  final String accessTokenHashed;
  final bool isMobile;
  final List<UserByRoleModel> commercesList;
  final bool isLoading;
  final void Function(UserByRoleModel)? onCommerceSelected;

  @override
  Widget build(BuildContext context) {
    return BusinessGridOrganism<UserByRoleModel>(
      title: 'Comercios Registrados',
      items: commercesList,
      isLoading: isLoading,
      emptyIcon: FluentIcons.store_microsoft_24_regular,
      emptyTitle: 'No hay comercios registrados',
      emptySubtitle: 'No se encontraron comercios en este momento',
      itemBuilder: (commerce, index) =>
          _buildCommerceCard(commerce, accessTokenHashed),
      headerActions: [
        GridHeaderAction(
          icon: FluentIcons.info_24_regular,
          onPressed: () {},
        ),
      ],
      crossAxisCount: isMobile ? 1 : null,
      childAspectRatio: isMobile ? 1.2 : 1.0,
    );
  }

  Widget _buildCommerceCard(
      UserByRoleModel commerce, String accessTokenHashed) {
    String? storeUrlWithToken;
    if (commerce.storeURL != null && commerce.storeURL!.isNotEmpty) {
      final uri = Uri.parse(commerce.storeURL!);
      final params = Map<String, String>.from(uri.queryParameters);
      params['token'] = accessTokenHashed;
      debugPrint('Access Token Hashed: $accessTokenHashed');
      storeUrlWithToken = uri.replace(queryParameters: params).toString();
      debugPrint('Store URL with token: $storeUrlWithToken');
    }

    return CommerceCard(
      name: commerce.name ?? 'Comercio sin nombre',
      category: _getCategoryFromRole(commerce.role),
      rating: _generateRating(),
      distance: _generateDistance(),
      imageUrl: commerce.photoURL ?? '',
      email: commerce.email,
      phone: commerce.phone,
      isEmailVerified: commerce.isEmailVerified,
      memberSince: commerce.createAt,
      lastActivity: commerce.lastLoginAt,
      menus: commerce.catalogs,
      storeUrl: storeUrlWithToken,
      onTap: () => onCommerceSelected?.call(commerce),
    );
  }

  String _getCategoryFromRole(String? role) {
    if (role == null) return 'Sin categoría';

    switch (role.toLowerCase()) {
      case 'dinning':
        return 'Restaurante';
      case 'food':
        return 'Restaurant/Comida';
      case 'clothes':
        return 'Tienda de Ropa';
      case 'retail':
        return 'Comercio General';
      case 'water_distributor':
        return 'Distribuidora de Agua';
      case 'grocery':
        return 'Distribuidora de Alimentos';
      case 'accessories':
        return 'Accesorios';
      case 'electronics':
        return 'Electrónica';
      case 'pharmacy':
        return 'Farmacia';
      case 'beauty':
        return 'Belleza';
      case 'construction':
        return 'Materiales de Construcción';
      case 'automotive':
        return 'Automotriz';
      case 'pets':
        return 'Petshop';
      case 'service':
        return 'Servicios';
      default:
        return 'Sin categoría';
    }
  }

  double _generateRating() {
    return 3.5 + (DateTime.now().millisecondsSinceEpoch % 25) / 10.0;
  }

  String _generateDistance() {
    final distance = 0.5 + (DateTime.now().millisecondsSinceEpoch % 50) / 10.0;
    return '${distance.toStringAsFixed(1)} km';
  }
}

class CustomerServiceInfo extends StatelessWidget {
  const CustomerServiceInfo({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerSectionTitle(
          text: 'Información del Servicio',
          fontSize: isMobile ? 16 : 18,
        ),
        const SizedBox(height: 16),
        const CustomerContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerInfoTile(
                icon: FluentIcons.clock_24_regular,
                title: 'Horarios de Atención',
                subtitle: 'Lunes a Domingo: 8:00 AM - 10:00 PM',
              ),
              SizedBox(height: 12),
              CustomerInfoTile(
                icon: FluentIcons.phone_24_regular,
                title: 'Soporte al Cliente',
                subtitle: 'Disponible 24/7 para ayudarte',
              ),
              SizedBox(height: 12),
              CustomerInfoTile(
                icon: FluentIcons.star_24_regular,
                title: 'Programa de Beneficios',
                subtitle: 'Descuentos y promociones exclusivas',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomerSidePanel extends StatelessWidget {
  const CustomerSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomerContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerSectionTitle(
            text: 'Notificaciones',
            fontSize: 16,
          ),
          SizedBox(height: 16),
          CustomerNotification(
            message: 'No tienes notificaciones nuevas',
            icon: FluentIcons.info_24_regular,
          ),
          SizedBox(height: 12),
          CustomerSectionTitle(
            text: 'Estadísticas',
            fontSize: 14,
          ),
          SizedBox(height: 8),
          CustomerInfoTile(
            icon: FluentIcons.receipt_24_regular,
            title: 'Pedidos Realizados',
            subtitle: '0 este mes',
          ),
        ],
      ),
    );
  }
}
