import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';

/// Action Button Atom - Átomo para botones de acción con iconos
class ActionButtonAtom extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double iconSize;
  final double padding;
  final double borderRadius;
  final String? tooltip;

  const ActionButtonAtom({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.iconSize = 16,
    this.padding = 6,
    this.borderRadius = 6,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final widget = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: backgroundColor ?? PUColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: SvgPicture.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
            colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: widget,
      );
    }

    return widget;
  }
}
