class ResponsiveBreakpoints {
  static double getResponsivePadding(double screenWidth,
      {double basePadding = 16}) {
    if (screenWidth < 600) {
      return basePadding.clamp(12, 24);
    } else if (screenWidth < 1024) {
      return (basePadding * 1.25).clamp(16, 40);
    } else {
      return (basePadding * 1.5).clamp(24, 64);
    }
  }

  static double getResponsiveSpacing(double screenWidth,
      {double baseSpacing = 24}) {
    if (screenWidth < 600) {
      return baseSpacing.clamp(16, 32);
    } else if (screenWidth < 1024) {
      return (baseSpacing * 1.25).clamp(20, 48);
    } else {
      return (baseSpacing * 1.5).clamp(24, 64);
    }
  }
}
