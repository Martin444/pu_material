import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Progress Dot Atom - A single dot in a progress indicator
class ProgressDot extends StatelessWidget {
  final bool isActive;
  final bool isCompleted;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Color completedIconColor;

  const ProgressDot({
    Key? key,
    required this.isActive,
    required this.isCompleted,
    this.size = 10,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x4DFFFFFF),
    this.completedIconColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: activeColor.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: isCompleted
          ? Icon(
              FluentIcons.checkmark_24_regular,
              size: size * 0.75,
              color: completedIconColor,
            )
          : null,
    );
  }
}
