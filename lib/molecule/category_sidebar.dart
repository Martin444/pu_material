import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_containers.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:pu_material/molecule/molecule_promo_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Category Sidebar Molecule - Molécula para sidebar de categorías
class CategorySidebar<T> extends StatelessWidget {
  final String title;
  final List<T> categories;
  final T? selectedCategory;
  final String Function(T category) titleBuilder;
  final void Function(T category) onCategorySelected;
  final void Function(T category)? onCategoryEdit;
  final void Function(T category)? onCategoryDelete;
  final Widget Function(T category)? categoryTileBuilder;
  final BoxConstraints constraints;

  // Promo card parameters
  final bool showPromoCard;
  final String? promoTitle;
  final String? promoButtonText;
  final VoidCallback? onPromoButtonTap;

  const CategorySidebar({
    super.key,
    required this.title,
    required this.categories,
    required this.selectedCategory,
    required this.titleBuilder,
    required this.onCategorySelected,
    required this.constraints,
    this.onCategoryEdit,
    this.onCategoryDelete,
    this.categoryTileBuilder,
    this.showPromoCard = false,
    this.promoTitle,
    this.promoButtonText,
    this.onPromoButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight,
      padding: const EdgeInsets.only(left: 20),
      decoration: PuStyleContainers.borderLeftContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PuTextStyle.title1,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                // Categories list
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      if (categoryTileBuilder != null) {
                        return categoryTileBuilder!(category);
                      }
                      return _buildDefaultCategoryTile(category);
                    },
                  ),
                ),

                // Promo card at the bottom
                if (showPromoCard && promoTitle != null && promoButtonText != null && onPromoButtonTap != null) ...[
                  const SizedBox(height: 16),
                  MoleculePromoCard(
                    title: promoTitle!,
                    buttonText: promoButtonText!,
                    onButtonTap: onPromoButtonTap!,
                    padding: const EdgeInsets.all(16),
                    fontSize: 14,
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCategoryTile(T category) {
    final isSelected = selectedCategory == category;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: Text(
          titleBuilder(category),
          style: PuTextStyle.description1.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        selected: isSelected,
        onTap: () => onCategorySelected(category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onCategoryEdit != null)
              IconButton(
                icon: const Icon(FluentIcons.edit_24_regular, size: 16),
                onPressed: () => onCategoryEdit!(category),
              ),
            if (onCategoryDelete != null)
              IconButton(
                icon: const Icon(FluentIcons.delete_24_regular, size: 16),
                onPressed: () => onCategoryDelete!(category),
              ),
          ],
        ),
      ),
    );
  }
}
