import 'package:flutter/material.dart';
import 'package:menu_dart_api/menu_com_api.dart';
import 'package:pu_material/pu_material.dart';

class CatalogUnlinkedBanners extends StatelessWidget {
  final List<UnlinkedCatalogData> unlinkedCatalogs;
  final bool isVisible;

  const CatalogUnlinkedBanners({
    super.key,
    required this.unlinkedCatalogs,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible || unlinkedCatalogs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: unlinkedCatalogs
          .map((c) => UnlinkedCatalogsBanner(
                catalog: c.catalog,
                isLoading: c.isLoading,
                onAssign: c.onAssign,
              ))
          .toList(),
    );
  }
}

class UnlinkedCatalogData {
  final CatalogModel catalog;
  final bool isLoading;
  final VoidCallback onAssign;

  const UnlinkedCatalogData({
    required this.catalog,
    required this.isLoading,
    required this.onAssign,
  });
}
