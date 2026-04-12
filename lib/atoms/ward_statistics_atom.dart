import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';

/// Ward Statistics Atom - Átomo para mostrar estadísticas del wardrobe
class WardStatisticsAtom extends StatelessWidget {
  final int totalItems;
  final int totalCategories;
  final double totalValue;
  final String currency;
  final Color backgroundColor;
  final EdgeInsets padding;
  final BorderRadiusGeometry borderRadius;

  const WardStatisticsAtom({
    super.key,
    required this.totalItems,
    required this.totalCategories,
    required this.totalValue,
    this.currency = '\$',
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: PUColors.borderInputColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            title: 'Prendas',
            value: totalItems.toString(),
            icon: FluentIcons.person_24_regular,
            color: PUColors.primaryColor,
          ),
          _buildDivider(),
          _buildStatItem(
            context,
            title: 'Categorías',
            value: totalCategories.toString(),
            icon: FluentIcons.grid_24_regular,
            color: Colors.orange,
          ),
          _buildDivider(),
          _buildStatItem(
            context,
            title: 'Valor Total',
            value: '$currency${totalValue.toStringAsFixed(0)}',
            icon: FluentIcons.money_24_regular,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: PuTextStyle.title3.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: PuTextStyle.description1.copyWith(
            fontSize: 12,
            color: PUColors.textColor3,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 50,
      width: 1,
      color: PUColors.borderInputColor.withOpacity(0.3),
    );
  }
}
