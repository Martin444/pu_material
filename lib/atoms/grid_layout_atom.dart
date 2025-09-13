import 'package:flutter/material.dart';

/// Grid Layout Atom - Átomo para manejar grids responsivos
/// Grid Layout Atom - Átomo para manejar grids responsivos y contextos acotados/no acotados
class GridLayoutAtom extends StatelessWidget {
  /// Widgets a mostrar en el grid
  final List<Widget> children;

  /// Constraints para calcular el crossAxisCount
  final BoxConstraints constraints;

  /// Altura de cada item
  final double mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  /// Si el grid debe adaptarse a su contenido (útil en SingleChildScrollView o Column)
  final bool shrinkWrap;

  /// Physics del scroll (útil para evitar scroll anidado)
  final ScrollPhysics? physics;

  ///
  /// [shrinkWrap]: true si usas el grid en un contexto no acotado (ej: dentro de Column o SingleChildScrollView)
  /// [physics]: usualmente NeverScrollableScrollPhysics() si usas shrinkWrap
  const GridLayoutAtom({
    super.key,
    required this.children,
    required this.constraints,
    this.mainAxisExtent = 530,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics,
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
      shrinkWrap: shrinkWrap,
      physics: physics,
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
