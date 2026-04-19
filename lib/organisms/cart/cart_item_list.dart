// Level: Organism
// Description: Lista pura y reutilizable de items en el carrito. Sin dependencias de controladores.
import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:pu_material/organisms/cart/cart_tile.dart';
import 'package:pu_material/organisms/cart/model/cart_item_model.dart';

class CartItemList extends StatelessWidget {
  final List<CartItemModel> items;
  final Function(CartItemModel) onAdd;
  final Function(CartItemModel) onRemove;
  final String emptyMessage;

  const CartItemList({
    super.key,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    this.emptyMessage = 'No seleccionaste ningún producto aún.',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Container(
            height: constraints.maxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: const BoxConstraints(maxWidth: 800),
            child: items.isNotEmpty
                ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CartTile(
                          item: item,
                          onAddCart: onAdd,
                          onRemoveCart: onRemove,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      emptyMessage,
                      textAlign: TextAlign.center,
                      style: PuTextStyle.description1,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
