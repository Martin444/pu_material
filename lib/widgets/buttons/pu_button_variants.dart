import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/pu_design_tokens.dart';

enum PUButtonSize { sm, md, lg }

enum PUButtonVariant { primary, secondary, outline, ghost, danger }

class PUButtonStyles {
  static double _getHeight(PUButtonSize size) {
    switch (size) {
      case PUButtonSize.sm:
        return PUTokens.buttonHeightSm;
      case PUButtonSize.md:
        return PUTokens.buttonHeightMd;
      case PUButtonSize.lg:
        return PUTokens.buttonHeightLg;
    }
  }

  static EdgeInsets _getPadding(PUButtonSize size,
      {bool horizontal = true, bool vertical = true}) {
    final h = horizontal ? PUTokens.md : 0.0;
    final v = vertical ? PUTokens.sm : 0.0;
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  static ButtonStyle primary({
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (disabled || states.contains(WidgetState.disabled)) {
          return PUColors.bgButton.withValues(alpha: 0.5);
        }
        if (states.contains(WidgetState.pressed)) {
          return PUColors.bgButton.withValues(alpha: 0.8);
        }
        if (states.contains(WidgetState.hovered)) {
          return PUColors.bgButton.withValues(alpha: 0.9);
        }
        return PUColors.bgButton;
      }),
      foregroundColor: WidgetStateProperty.all(PUColors.textColor2),
      padding: WidgetStateProperty.all(_getPadding(size)),
      minimumSize: WidgetStateProperty.all(Size(0, _getHeight(size))),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: PUBorderRadius.md),
      ),
      overlayColor: WidgetStateProperty.all(
        Colors.white.withValues(alpha: 0.1),
      ),
    );
  }

  static ButtonStyle secondary({
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (disabled || states.contains(WidgetState.disabled)) {
          return PUColors.bgCategorySelected.withValues(alpha: 0.5);
        }
        if (states.contains(WidgetState.pressed)) {
          return PUColors.bgCategorySelected.withValues(alpha: 0.8);
        }
        return PUColors.bgCategorySelected;
      }),
      foregroundColor: WidgetStateProperty.all(PUColors.textColor3),
      padding: WidgetStateProperty.all(_getPadding(size)),
      minimumSize: WidgetStateProperty.all(Size(0, _getHeight(size))),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: PUBorderRadius.md),
      ),
      overlayColor: WidgetStateProperty.all(
        Colors.grey.withValues(alpha: 0.1),
      ),
    );
  }

  static ButtonStyle outline({
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(PUColors.primaryColor),
      padding: WidgetStateProperty.all(_getPadding(size)),
      minimumSize: WidgetStateProperty.all(Size(0, _getHeight(size))),
      side: WidgetStateProperty.resolveWith((states) {
        if (disabled || states.contains(WidgetState.disabled)) {
          return BorderSide(color: PUColors.primaryColor.withValues(alpha: 0.5));
        }
        return BorderSide(color: PUColors.primaryColor);
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: PUBorderRadius.md),
      ),
    );
  }

  static ButtonStyle ghost({
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(PUColors.textColor3),
      padding: WidgetStateProperty.all(_getPadding(size)),
      minimumSize: WidgetStateProperty.all(Size(0, _getHeight(size))),
      overlayColor: WidgetStateProperty.all(
        Colors.grey.withValues(alpha: 0.1),
      ),
    );
  }

  static ButtonStyle danger({
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (disabled || states.contains(WidgetState.disabled)) {
          return PUColors.bgError.withValues(alpha: 0.5);
        }
        if (states.contains(WidgetState.pressed)) {
          return PUColors.bgError.withValues(alpha: 0.8);
        }
        return PUColors.bgError;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(_getPadding(size)),
      minimumSize: WidgetStateProperty.all(Size(0, _getHeight(size))),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: PUBorderRadius.md),
      ),
      overlayColor: WidgetStateProperty.all(
        Colors.white.withValues(alpha: 0.1),
      ),
    );
  }

  static ButtonStyle fromVariant(
    PUButtonVariant variant, {
    PUButtonSize size = PUButtonSize.md,
    bool disabled = false,
  }) {
    switch (variant) {
      case PUButtonVariant.primary:
        return primary(size: size, disabled: disabled);
      case PUButtonVariant.secondary:
        return secondary(size: size, disabled: disabled);
      case PUButtonVariant.outline:
        return outline(size: size, disabled: disabled);
      case PUButtonVariant.ghost:
        return ghost(size: size, disabled: disabled);
      case PUButtonVariant.danger:
        return danger(size: size, disabled: disabled);
    }
  }
}
