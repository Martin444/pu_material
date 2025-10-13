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
    this.mainAxisExtent = 580, // Aumentar de 530 a 580 para más espacio vertical
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    // Calcular altura adaptativa basada en el dispositivo
    final adaptiveMainAxisExtent = _getAdaptiveMainAxisExtent();

    return GridView.builder(
      itemCount: children.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(),
        mainAxisExtent: adaptiveMainAxisExtent,
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

  /// Calcula la altura adaptativa basada en el ancho del dispositivo
  double _getAdaptiveMainAxisExtent() {
    final isDesktop = constraints.maxWidth >= 800;
    final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 800;

    if (isDesktop) {
      return mainAxisExtent * 1.1; // 10% más de altura en desktop
    } else if (isTablet) {
      return mainAxisExtent * 1.05; // 5% más de altura en tablet
    } else {
      return mainAxisExtent; // Altura base en móvil
    }
  }
}
