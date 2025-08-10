import 'package:flutter/material.dart';

/// Gradient Container Atom - A container with customizable gradient background
class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Duration? animationDuration;

  const GradientContainer({
    Key? key,
    required this.child,
    required this.gradientColors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: gradientColors,
      ),
      borderRadius: borderRadius,
    );

    Widget container = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );

    if (animationDuration != null) {
      return AnimatedContainer(
        duration: animationDuration!,
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: child,
      );
    }

    return container;
  }
}