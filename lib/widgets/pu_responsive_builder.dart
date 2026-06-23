import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_breakpoints.dart';

class ResponsiveInfo {
  final double width;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const ResponsiveInfo({
    required this.width,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });
}

class PuResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  const PuResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return builder(
          context,
          ResponsiveInfo(
            width: width,
            isMobile: width < kMobileBreakpoint,
            isTablet: width >= kMobileBreakpoint && width < kTabletBreakpoint,
            isDesktop: width >= kTabletBreakpoint,
          ),
        );
      },
    );
  }
}
