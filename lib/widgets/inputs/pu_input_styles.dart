import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/pu_design_tokens.dart';

enum PUInputSize { sm, md, lg }

class PUInputStyles {
  static InputDecoration base({
    String? hintText,
    String? labelText,
    String? errorText,
    PUInputSize size = PUInputSize.md,
  }) {
    final inputHeight = _getHeight(size);
    double vPadding = size == PUInputSize.sm ? PUTokens.sm : PUTokens.md;

    return InputDecoration(
      filled: true,
      fillColor: PUColors.bgInput,
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'Sansation-bold',
        fontSize: PUTokens.fontMd,
        color: PUColors.textColor3,
        fontWeight: FontWeight.w300,
      ),
      labelText: labelText,
      errorText: errorText,
      errorStyle: const TextStyle(fontWeight: FontWeight.w400),
      contentPadding: EdgeInsets.symmetric(
        horizontal: PUTokens.md,
        vertical: vPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide: BorderSide(color: PUColors.borderInputColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide: BorderSide(color: PUColors.borderInputColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide: BorderSide(color: PUColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide: BorderSide(color: PUColors.bgError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide: BorderSide(color: PUColors.bgError, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: PUBorderRadius.md,
        borderSide:
            BorderSide(color: PUColors.borderInputColor.withOpacity(0.5)),
      ),
    );
  }

  static InputDecoration primary({
    String? hintText,
    String? labelText,
    String? errorText,
    PUInputSize size = PUInputSize.md,
  }) {
    return base(
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      size: size,
    );
  }

  static InputDecoration minimal({
    String? hintText,
    String? labelText,
    String? errorText,
    PUInputSize size = PUInputSize.md,
  }) {
    return InputDecoration(
      filled: false,
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'Sansation-bold',
        fontSize: PUTokens.fontMd,
        color: PUColors.textColor3,
      ),
      labelText: labelText,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  static double _getHeight(PUInputSize size) {
    switch (size) {
      case PUInputSize.sm:
        return 36;
      case PUInputSize.md:
        return PUTokens.inputHeight;
      case PUInputSize.lg:
        return 56;
    }
  }
}
