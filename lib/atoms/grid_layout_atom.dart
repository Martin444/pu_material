import 'package:flutter/material.dart';

/// Grid Layout Atom - Átomo para manejar grids responsivos
class GridLayoutAtom extends StatelessWidget {
  final List<Widget> children;
  final BoxConstraints constraints;
  final double mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const GridLayoutAtom({
    super.key,
    required this.children,
    required this.constraints,
    this.mainAxisExtent = 330,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: children.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(),
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemBuilder: (context, index) => children[index],
    );
  }

  int _getCrossAxisCount() {
    if (constraints.maxWidth < 800) {
      return constraints.maxWidth > 600 ? 3 : 2;
    }
    return 4;
  }
}
