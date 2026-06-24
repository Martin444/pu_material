import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';
import 'package:pu_material/utils/pu_assets.dart';

class CatalogGridOrganism<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final BoxConstraints constraints;
  final IconData emptyIcon;
  final String emptyMessage;
  final String createButtonLabel;
  final VoidCallback? onCreateItem;

  const CatalogGridOrganism({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.constraints,
    required this.emptyIcon,
    this.emptyMessage = 'No hay productos en este catálogo',
    this.createButtonLabel = 'Cargar primer producto',
    this.onCreateItem,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyState();
    }

    final width = constraints.maxWidth;
    final crossAxisCount = width >= 1024
        ? 4
        : width >= 768
            ? 3
            : 2;

    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 400,
        mainAxisSpacing: 0,
        childAspectRatio: 1.0,
        crossAxisSpacing: 0,
      ),
      itemBuilder: (context, index) => itemBuilder(context, items[index], index),
    );
  }

  Widget _EmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(PUImages.noDataImageSvg, height: 140),
        const SizedBox(height: 20),
        Text(emptyMessage, style: PuTextStyle.description1, textAlign: TextAlign.center),
        if (onCreateItem != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: ButtonPrimary(
              title: createButtonLabel,
              onPressed: onCreateItem!,
              load: false,
            ),
          ),
        ],
      ],
    );
  }
}
