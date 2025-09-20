import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../atoms/title_atom.dart';
import '../atoms/icon_atom.dart';
import '../atoms/container_atom.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

/// Organismo genérico para grids de entidades de negocio
///
/// Implementa atomic design combinando múltiples molecules:
/// - Header con título y contador
/// - Grid responsivo de elementos
/// - Estados de carga y vacío
/// - Manejo de errores
///
/// Este organismo es completamente agnóstico del dominio y puede
/// reutilizarse para mostrar cualquier tipo de entidad en formato grid.
class BusinessGridOrganism<T> extends StatelessWidget {
  const BusinessGridOrganism({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.isCompact = false,
    this.emptyTitle = 'No hay elementos',
    this.emptySubtitle = 'No se encontraron elementos para mostrar',
    this.emptyIcon = FluentIcons.box_24_regular,
    this.loadingMessage = '-',
    this.errorMessage,
    this.onRefresh,
    this.headerActions = const [],
    this.crossAxisCount,
    this.childAspectRatio = 1.0,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
  });

  /// Título de la sección
  final String title;

  /// Lista de elementos a mostrar
  final List<T> items;

  /// Constructor para cada elemento del grid
  final Widget Function(T item, int index) itemBuilder;

  /// Si los datos están cargando
  final bool isLoading;

  /// Si debe usar diseño compacto
  final bool isCompact;

  /// Título para estado vacío
  final String emptyTitle;

  /// Subtítulo para estado vacío
  final String emptySubtitle;

  /// Ícono para estado vacío
  final IconData emptyIcon;

  /// Mensaje durante la carga
  final String loadingMessage;

  /// Mensaje de error (si existe)
  final String? errorMessage;

  /// Callback para refrescar (opcional)
  final VoidCallback? onRefresh;

  /// Acciones del header
  final List<GridHeaderAction> headerActions;

  /// Número de columnas (auto si no se especifica)
  final int? crossAxisCount;

  /// Relación de aspecto de los elementos
  final double childAspectRatio;

  /// Espaciado vertical entre elementos
  final double mainAxisSpacing;

  /// Espaciado horizontal entre elementos
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final hasBoundedHeight = constraints.hasBoundedHeight && constraints.maxHeight < double.infinity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            // Si la altura está acotada, usar Expanded y shrinkWrap: false
            // Si no, usar shrinkWrap: true y sin Expanded
            hasBoundedHeight
                ? Expanded(child: _buildContent(context, shrinkWrap: false))
                : _buildContent(context, shrinkWrap: true),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título con contador e ícono de comercios
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleAtom(
              text: title,
              level: isCompact ? TitleLevel.h3 : TitleLevel.h2,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: PUColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    isLoading ? loadingMessage : '${items.length} ',
                    style: PuTextStyle.brandHeadStyle.copyWith(
                      color: PUColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: isCompact ? 15 : 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconAtom(
                    icon: FluentIcons.building_shop_24_regular,
                    size: isCompact ? 11 : 18,
                    color: PUColors.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, {bool shrinkWrap = false}) {
    // Estado de error
    if (errorMessage != null) {
      return _buildErrorState();
    }

    // Estado de carga
    if (isLoading) {
      return _buildLoadingState();
    }

    // Estado vacío
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    // Grid de elementos
    return _buildGrid(context, shrinkWrap: shrinkWrap);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(PUColors.primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            loadingMessage,
            style: TextStyle(
              color: PUColors.textColor3,
              fontSize: isCompact ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconAtom(
            icon: emptyIcon,
            size: isCompact ? 48 : 64,
            color: PUColors.textColor3.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          TitleAtom(
            text: emptyTitle,
            level: TitleLevel.h3,
            color: PUColors.textColor3,
          ),
          const SizedBox(height: 8),
          Text(
            emptySubtitle,
            style: TextStyle(
              color: PUColors.textColor3,
              fontSize: isCompact ? 14 : 16,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRefresh != null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const IconAtom(
                icon: FluentIcons.arrow_sync_24_regular,
                size: 16,
                color: Colors.white,
              ),
              label: const Text('Intentar de nuevo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PUColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: ContainerAtom(
        variant: ContainerVariant.card,
        backgroundColor: Colors.red.withOpacity(0.05),
        borderColor: Colors.red.withOpacity(0.2),
        borderWidth: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconAtom(
              icon: FluentIcons.error_circle_24_regular,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            TitleAtom(
              text: 'Error al cargar',
              level: TitleLevel.h3,
              color: Colors.red[700],
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const IconAtom(
                  icon: FluentIcons.arrow_sync_24_regular,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text('Reintentar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, {bool shrinkWrap = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Responsive breakpoint calculations
        final isMobile = availableWidth < 768;
        final isTablet = availableWidth >= 768 && availableWidth < 1200;
        final isDesktop = availableWidth >= 1200;

        // Calculate columns based on device type and content density
        final calculatedCrossAxisCount = crossAxisCount ??
            _calculateResponsiveCrossAxisCount(
              availableWidth,
              isCompact,
              isMobile: isMobile,
              isTablet: isTablet,
              isDesktop: isDesktop,
            );

        // Adaptive aspect ratio based on device and column count
        final adaptiveAspectRatio = _calculateAdaptiveAspectRatio(
          calculatedCrossAxisCount,
          isMobile: isMobile,
          isTablet: isTablet,
          baseAspectRatio: childAspectRatio,
        );

        // Responsive spacing
        final adaptiveMainSpacing = _calculateAdaptiveSpacing(mainAxisSpacing, isMobile);
        final adaptiveCrossSpacing = _calculateAdaptiveSpacing(crossAxisSpacing, isMobile);

        // Detectar plataforma para scroll
        final bool isMobilePlatform =
            Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS;
        return GridView.builder(
          shrinkWrap: shrinkWrap,
          physics: isMobilePlatform ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculatedCrossAxisCount,
            childAspectRatio: adaptiveAspectRatio,
            mainAxisSpacing: adaptiveMainSpacing,
            crossAxisSpacing: adaptiveCrossSpacing,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return itemBuilder(items[index], index);
          },
        );
      },
    );
  }

  /// Calculate responsive column count with enhanced mobile/tablet support
  int _calculateResponsiveCrossAxisCount(
    double availableWidth,
    bool isCompact, {
    required bool isMobile,
    required bool isTablet,
    required bool isDesktop,
  }) {
    // Unified breakpoint system
    if (isCompact) {
      // Compact mode: prioritize density
      if (availableWidth >= 1600) return 5; // Large desktop
      if (isDesktop) return 4;
      if (availableWidth >= 1024) return 3; // Large tablet
      if (isTablet) return 2;
      return 1; // Mobile
    } else {
      // Normal mode: prioritize content visibility
      if (availableWidth >= 1600) return 4; // Large desktop
      if (isDesktop) return 3;
      if (isTablet) return 2;
      return 1; // Mobile
    }
  }

  /// Calculate adaptive aspect ratio with responsive scaling
  double _calculateAdaptiveAspectRatio(
    int columnCount, {
    required bool isMobile,
    required bool isTablet,
    required double baseAspectRatio,
  }) {
    if (isMobile) {
      // Mobile: taller cards for better content display
      return baseAspectRatio * 1.2;
    } else if (isTablet) {
      // Tablet: slightly adjusted based on column count
      return columnCount == 1 ? baseAspectRatio * 1.1 : baseAspectRatio;
    } else {
      // Desktop: use base ratio
      return baseAspectRatio;
    }
  }

  /// Calculate adaptive spacing with responsive scaling
  double _calculateAdaptiveSpacing(double baseSpacing, bool isMobile) {
    return isMobile ? baseSpacing * 0.75 : baseSpacing;
  }
}

/// Clase para acciones del header del grid
class GridHeaderAction {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final String? tooltip;

  const GridHeaderAction({
    required this.icon,
    required this.onPressed,
    this.color,
    this.tooltip,
  });
}
