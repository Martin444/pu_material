import 'package:flutter/material.dart';

/// Status Icon Atom - Displays an animated status icon with customizable appearance
class StatusIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final double borderWidth;
  final Animation<double>? animation;
  final bool isRotating;

  const StatusIcon({
    Key? key,
    required this.size,
    required this.backgroundColor,
    required this.icon,
    this.iconColor = Colors.white,
    this.borderWidth = 4.0,
    this.animation,
    this.isRotating = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      color: iconColor,
      size: size * 0.4,
    );

    if (isRotating) {
      iconWidget = RotatingIcon(
        icon: icon,
        color: iconColor,
        size: size * 0.4,
      );
    }

    Widget container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: iconWidget,
    );

    if (animation != null) {
      return AnimatedBuilder(
        animation: animation!,
        builder: (context, child) {
          return Transform.scale(
            scale: animation!.value,
            child: container,
          );
        },
      );
    }

    return container;
  }
}

/// Rotating Icon Widget for animated states
class RotatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const RotatingIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * 3.14159,
          child: Icon(
            widget.icon,
            color: widget.color,
            size: widget.size,
          ),
        );
      },
    );
  }
}