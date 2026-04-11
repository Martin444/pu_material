import 'package:flutter/material.dart';

class PUTokens {
  static const double _baseSpacing = 4.0;

  static const double xs = _baseSpacing * 1;
  static const double sm = _baseSpacing * 2;
  static const double md = _baseSpacing * 3;
  static const double lg = _baseSpacing * 4;
  static const double xl = _baseSpacing * 6;
  static const double xxl = _baseSpacing * 8;

  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 999.0;

  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  static const double fontXs = 12.0;
  static const double fontSm = 14.0;
  static const double fontMd = 16.0;
  static const double fontLg = 18.0;
  static const double fontXl = 20.0;
  static const double fontXxl = 24.0;
  static const double font3xl = 28.0;

  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightLg = 52.0;

  static const double inputHeight = 48.0;
}

class PUSpacing {
  static const EdgeInsets xs = EdgeInsets.all(PUTokens.xs);
  static const EdgeInsets sm = EdgeInsets.all(PUTokens.sm);
  static const EdgeInsets md = EdgeInsets.all(PUTokens.md);
  static const EdgeInsets lg = EdgeInsets.all(PUTokens.lg);
  static const EdgeInsets xl = EdgeInsets.all(PUTokens.xl);

  static const EdgeInsets horizontalSm =
      EdgeInsets.symmetric(horizontal: PUTokens.sm);
  static const EdgeInsets horizontalMd =
      EdgeInsets.symmetric(horizontal: PUTokens.md);
  static const EdgeInsets horizontalLg =
      EdgeInsets.symmetric(horizontal: PUTokens.lg);

  static const EdgeInsets verticalSm =
      EdgeInsets.symmetric(vertical: PUTokens.sm);
  static const EdgeInsets verticalMd =
      EdgeInsets.symmetric(vertical: PUTokens.md);
  static const EdgeInsets verticalLg =
      EdgeInsets.symmetric(vertical: PUTokens.lg);
}

class PUBorderRadius {
  static BorderRadius none = BorderRadius.circular(0);
  static BorderRadius sm = BorderRadius.circular(PUTokens.radiusSm);
  static BorderRadius md = BorderRadius.circular(PUTokens.radiusMd);
  static BorderRadius lg = BorderRadius.circular(PUTokens.radiusLg);
  static BorderRadius xl = BorderRadius.circular(PUTokens.radiusXl);
  static BorderRadius full = BorderRadius.circular(PUTokens.radiusFull);
}
