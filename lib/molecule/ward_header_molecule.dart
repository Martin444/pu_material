import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';

/// Ward Header Molecule - Molécula para el header del wardrobe con estadísticas y acciones
class WardHeaderMolecule extends StatelessWidget {
  final String title;
  final int totalItems;
  final int totalCategories;
  final double totalValue;
  final String currency;
  final List<WardHeaderAction> actions;
  final BoxConstraints constraints;
  final TextStyle? titleStyle;

  const WardHeaderMolecule({
    super.key,
    required this.title,
    required this.totalItems,
    required this.totalCategories,
    required this.totalValue,
    required this.constraints,
    this.currency = '\$',
    this.actions = const [],
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = constraints.maxWidth < 768;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and actions row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ??
                      PuTextStyle.title1.copyWith(
                        fontSize: isMobile ? 20 : 24,
                      ),
                ),
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions.asMap().entries.map((entry) {
                    final action = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: entry.key > 0 ? 8 : 0,
                      ),
                      child: ActionButtonAtom(
                        iconPath: action.iconPath,
                        onPressed: action.onPressed,
                        backgroundColor: action.backgroundColor,
                        iconColor: action.iconColor,
                        tooltip: action.tooltip,
                        iconSize: isMobile ? 14 : 16,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),

          const SizedBox(height: 16),

          // Statistics
          WardStatisticsAtom(
            totalItems: totalItems,
            totalCategories: totalCategories,
            totalValue: totalValue,
            currency: currency,
          ),
        ],
      ),
    );
  }
}

/// Data class para las acciones del header
class WardHeaderAction {
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;

  const WardHeaderAction({
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
  });
}
