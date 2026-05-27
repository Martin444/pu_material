import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../utils/pu_colors.dart';

class PwaInstallButtonAtom extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final String? tooltip;

  const PwaInstallButtonAtom({
    super.key,
    required this.onPressed,
    this.size = 20,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final widget = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: PUColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            FluentIcons.arrow_download_24_regular,
            size: size,
            color: PUColors.primaryColor,
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
