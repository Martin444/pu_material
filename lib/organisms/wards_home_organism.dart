import 'package:flutter/material.dart';
import 'package:pu_material/molecule/ward_item_grid.dart';
import 'package:pu_material/molecule/category_sidebar.dart';
import 'package:pu_material/molecule/molecule_promo_card.dart';

/// Wards Home Organism - Organismo principal para la vista de guardarropas
class WardsHomeOrganism<TCategory, TItem> extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isMobile;

  // Categories
  final List<TCategory> categories;
  final TCategory? selectedCategory;
  final String Function(TCategory) categoryTitleBuilder;
  final void Function(TCategory) onCategorySelected;
  final void Function(TCategory)? onCategoryEdit;
  final void Function(TCategory)? onCategoryDelete;
  final Widget Function(TCategory)? categoryTileBuilder;
  final String categoriesTitle;

  // Items
  final List<TItem> items;
  final Widget Function(TItem item, int index) itemBuilder;
  final String? emptyItemsTitle;
  final String? emptyItemsImagePath;
  final String? emptyItemsButtonText;
  final VoidCallback? onEmptyItemsButtonPressed;
  final bool isItemsLoading;

  // Tags section (for mobile)
  final Widget? tagsSection;

  // Promo card parameters
  final bool showPromoCard;
  final String? promoTitle;
  final String? promoButtonText;
  final VoidCallback? onPromoButtonTap;

  const WardsHomeOrganism({
    super.key,
    required this.constraints,
    required this.isMobile,
    required this.categories,
    required this.selectedCategory,
    required this.categoryTitleBuilder,
    required this.onCategorySelected,
    required this.categoriesTitle,
    required this.items,
    required this.itemBuilder,
    this.onCategoryEdit,
    this.onCategoryDelete,
    this.categoryTileBuilder,
    this.emptyItemsTitle,
    this.emptyItemsImagePath,
    this.emptyItemsButtonText,
    this.onEmptyItemsButtonPressed,
    this.isItemsLoading = false,
    this.tagsSection,
    this.showPromoCard = false,
    this.promoTitle,
    this.promoButtonText,
    this.onPromoButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo card for mobile/tablet (above tags section)
          if (showPromoCard &&
              constraints.maxWidth < 1200 &&
              promoTitle != null &&
              promoButtonText != null &&
              onPromoButtonTap != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: MoleculePromoCard(
                title: promoTitle!,
                buttonText: promoButtonText!,
                onButtonTap: onPromoButtonTap!,
                padding: const EdgeInsets.all(20),
                fontSize: 16,
              ),
            ),
          ],

          // Tags section for mobile/tablet
          if (tagsSection != null && constraints.maxWidth < 1200) tagsSection!,

          // Main content
          Expanded(
            child: Row(
              children: [
                // Items grid
                Flexible(
                  flex: 8,
                  child: WardItemGrid<TItem>(
                    items: items,
                    constraints: constraints,
                    itemBuilder: itemBuilder,
                    emptyTitle: emptyItemsTitle,
                    emptyImagePath: emptyItemsImagePath,
                    emptyButtonText: emptyItemsButtonText,
                    onEmptyButtonPressed: onEmptyItemsButtonPressed,
                    isLoading: isItemsLoading,
                  ),
                ),

                // Sidebar for desktop
                if (constraints.maxWidth > 1200)
                  Flexible(
                    flex: 2,
                    child: CategorySidebar<TCategory>(
                      title: categoriesTitle,
                      categories: categories,
                      selectedCategory: selectedCategory,
                      titleBuilder: categoryTitleBuilder,
                      onCategorySelected: onCategorySelected,
                      onCategoryEdit: onCategoryEdit,
                      onCategoryDelete: onCategoryDelete,
                      categoryTileBuilder: categoryTileBuilder,
                      constraints: constraints,
                      showPromoCard: showPromoCard,
                      promoTitle: promoTitle,
                      promoButtonText: promoButtonText,
                      onPromoButtonTap: onPromoButtonTap,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
