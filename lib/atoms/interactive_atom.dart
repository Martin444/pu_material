import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

/// InteractiveAtom - Átomo base para elementos interactivos
///
/// Proporciona estados de hover, focus y press contransiciones suaves.
/// Sigue atomic design: wrapper genérico para cualquier elemento clickable.
class InteractiveAtom extends StatefulWidget {
  const InteractiveAtom({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.enableHover = true,
    this.enableHoverColor = true,
    this.hoverColor,
    this.hoverScale = 1.02,
    this.duration = const Duration(milliseconds: 200),
    this.cursor = SystemMouseCursors.click,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.semanticsLabel,
  });

  /// Widget hijo (generalmente un icono, texto o imagen)
  final Widget child;

  /// Callback al presionar
  final VoidCallback? onTap;

  /// Callback al presionar largo
  final VoidCallback? onLongPress;

  /// Callback al cambiar estado hover
  final void Function(bool)? onHover;

  /// Habilitar estado hover
  final bool enableHover;

  /// Habilitar cambio de color en hover
  final bool enableHoverColor;

  /// Color de fondo en hover
  final Color? hoverColor;

  /// Escala en hover (1.0 = sin cambio)
  final double hoverScale;

  /// Duración de la transición
  final Duration duration;

  /// Cursor del mouse
  final MouseCursor cursor;

  /// Padding interno
  final EdgeInsets? padding;

  /// Margin externo
  final EdgeInsets? margin;

  /// Radio del borde
  final double? borderRadius;

  /// Color de fondo
  final Color? backgroundColor;

  /// Borde decoration
  final BoxBorder? border;

  /// Label para accesibilidad
  final String? semanticsLabel;

  @override
  State<InteractiveAtom> createState() => _InteractiveAtomState();
}

class _InteractiveAtomState extends State<InteractiveAtom> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel,
      button: widget.onTap != null,
      child: MouseRegion(
        cursor: widget.cursor,
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: Curves.easeInOut,
            padding: widget.padding,
            margin: widget.margin,
            transform: Matrix4.identity()..scale(_isHovered ? widget.hoverScale : 1.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: widget.borderRadius != null
                  ? BorderRadius.circular(widget.borderRadius!)
                  : null,
              border: widget.border,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor() {
    if (widget.enableHoverColor && _isHovered) {
      return widget.hoverColor ?? PUColors.restaurantPrimary.withValues(alpha: 0.1);
    }
    return widget.backgroundColor;
  }

  void _handleHover(bool hovered) {
    if (widget.enableHover) {
      setState(() => _isHovered = hovered);
      widget.onHover?.call(hovered);
    }
  }
}

/// AnimatedIconAtom - Icono con animación de hover
class AnimatedIconAtom extends StatefulWidget {
  const AnimatedIconAtom({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
    this.hoverColor,
    this.onTap,
    this.enableScale = true,
    this.scaleOnHover = 1.15,
    this.duration = const Duration(milliseconds: 200),
  });

  final IconData icon;
  final double size;
  final Color? color;
  final Color? hoverColor;
  final VoidCallback? onTap;
  final bool enableScale;
  final double scaleOnHover;
  final Duration duration;

  @override
  State<AnimatedIconAtom> createState() => _AnimatedIconAtomState();
}

class _AnimatedIconAtomState extends State<AnimatedIconAtom> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Icono interactivo',
      button: widget.onTap != null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(8),
            transform: Matrix4.identity()
              ..scale(widget.enableScale && _isHovered
                  ? widget.scaleOnHover
                  : 1.0),
            transformAlignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: widget.duration,
              style: TextStyle(
                fontSize: widget.size,
                color: _isHovered
                    ? (widget.hoverColor ?? PUColors.restaurantPrimary)
                    : (widget.color ?? PUColors.iconColor),
              ),
              child: Icon(widget.icon),
            ),
          ),
        ),
      ),
    );
  }
}

/// PulseIndicatorAtom - Indicador visual para estados de carga
class PulseIndicatorAtom extends StatefulWidget {
  const PulseIndicatorAtom({
    super.key,
    this.size = 24,
    this.color,
    this.duration = const Duration(milliseconds: 1500),
  });

  final double size;
  final Color? color;
  final Duration duration;

  @override
  State<PulseIndicatorAtom> createState() => _PulseIndicatorAtomState();
}

class _PulseIndicatorAtomState extends State<PulseIndicatorAtom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (widget.color ?? PUColors.restaurantPrimary)
                .withValues(alpha: _animation.value),
          ),
        );
      },
    );
  }
}