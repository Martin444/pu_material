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
    this.loadingMessage = 'Cargando...',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con título y acciones
        _buildHeader(),

        const SizedBox(height: 16),

        // Contenido principal
        Expanded(
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título con contador
        Row(
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
              child: Text(
                isLoading ? loadingMessage : '${items.length} elementos',
                style: PuTextStyle.brandHeadStyle.copyWith(
                  color: PUColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: isCompact ? 11 : 12,
                ),
              ),
            ),
          ],
        ),

        // Acciones del header
        if (headerActions.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: headerActions
                .map((action) => Padding(
                      padding: EdgeInsets.only(
                        left: headerActions.indexOf(action) > 0 ? 8 : 0,
                      ),
                      child: IconButton(
                        onPressed: action.onPressed,
                        icon: IconAtom(
                          icon: action.icon,
                          size: isCompact ? 20 : 24,
                          color: action.color,
                        ),
                        tooltip: action.tooltip,
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
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
    return _buildGrid(context);
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
              icon: IconAtom(
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
            IconAtom(
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
                icon: IconAtom(
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

  Widget _buildGrid(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableWidth = mediaQuery.size.width;

    // Calcular número de columnas según el ancho disponible
    int calculatedCrossAxisCount = crossAxisCount ?? _calculateCrossAxisCount(availableWidth, isCompact);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: calculatedCrossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index], index);
      },
    );
  }

  int _calculateCrossAxisCount(double availableWidth, bool isCompact) {
    if (isCompact) {
      if (availableWidth > 1200) return 4;
      if (availableWidth > 800) return 3;
      if (availableWidth > 600) return 2;
      return 1;
    } else {
      if (availableWidth > 1400) return 3;
      if (availableWidth > 900) return 2;
      return 1;
    }
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
