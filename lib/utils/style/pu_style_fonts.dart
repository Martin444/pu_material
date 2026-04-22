import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';

class PuTextStyle {
  // --- Font Pairings: Reverted to Sansation-bold ---
  
  static const String _fontFamily = 'Sansation-bold';

  // Base font styles
  static TextStyle get headingBase => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    color: PUColors.textColorRich,
  );

  static TextStyle get bodyBase => const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: PUColors.textColorMuted,
  );

  // --- Headings ---
  
  static TextStyle title1 = headingBase.copyWith(
    fontSize: 32,
    letterSpacing: -0.5,
  );

  static TextStyle title2 = headingBase.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle title3 = headingBase.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleSecundary = headingBase.copyWith(
    color: Colors.white,
    fontSize: 28,
  );

  // --- Body Text ---
  
  static TextStyle bodyLarge = bodyBase.copyWith(
    fontSize: 18,
    height: 1.5,
  );

  static TextStyle bodyMedium = bodyBase.copyWith(
    fontSize: 16,
    height: 1.4,
  );

  static TextStyle bodySmall = bodyBase.copyWith(
    fontSize: 14,
    color: PUColors.textColorLight,
  );

  // --- UI Elements / Labels ---
  
  static TextStyle textLabelMenu = bodyBase.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle labelGold = bodyBase.copyWith(
    color: PUColors.textColorGold,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  // --- Legacy Compatibility ---
  
  static TextStyle title3Withe = title3.copyWith(color: Colors.white);
  static TextStyle title3disable = title3.copyWith(color: Colors.grey.shade400);
  static TextStyle title4 = title2.copyWith(color: Colors.white);
  static TextStyle title5 = title2.copyWith(color: PUColors.textColorMuted);
  static TextStyle title6 = bodyMedium.copyWith(color: Colors.white);
  
  static TextStyle description1 = bodyMedium;
  static TextStyle description2 = bodySmall.copyWith(color: Colors.white70);

  // CART / PRODUCT Specific
  static TextStyle brandHeadStyle = bodySmall.copyWith(
    fontWeight: FontWeight.bold,
    color: PUColors.textColorLight,
    height: 1.0,
  );

  static TextStyle nameProductStyle = bodyMedium.copyWith(
    fontWeight: FontWeight.w600,
    color: PUColors.textColorRich,
    height: 1.2,
  );

  static TextStyle namePriceCardStyle = bodyLarge.copyWith(
    fontWeight: FontWeight.w700,
    color: PUColors.textColorGold,
  );

  static TextStyle ingredientsListStyle = bodySmall.copyWith(
    color: PUColors.textColorMuted,
  );

  // HEAD CATALOG
  static TextStyle cartQuantityTextStyle = bodySmall.copyWith(
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle titleHeadTextStyle = title2;

  // BUTTONS
  static TextStyle primaryButtonStyle = bodyMedium.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textbtnStyle = primaryButtonStyle;
  
  static TextStyle secundaryButtonStyle = bodyMedium.copyWith(
    color: PUColors.textColorMuted,
    fontWeight: FontWeight.w500,
  );

  static TextStyle textInput1 = bodyMedium;
  static TextStyle hintTextStyle = bodyMedium.copyWith(color: Colors.grey);
  
  static TextStyle redirectLink1 = bodyMedium.copyWith(
    color: PUColors.accentColor,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  static TextStyle subtitle = bodyMedium;
  static TextStyle buttonTextStyle = primaryButtonStyle;

  // --- Membership Feature Styles ---
  // Reverted to Sansation
  static TextStyle get membershipPriceLarge => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get membershipPriceLabel => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  // Membership plan title
  static TextStyle membershipPlanTitle = headingBase.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // Membership plan subtitle
  static TextStyle membershipPlanSubtitle = bodyBase.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Membership badge text
  static TextStyle membershipBadge = bodySmall.copyWith(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Status label
  static TextStyle membershipStatus = bodyBase.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Plan card title
  static TextStyle membershipCardTitle = bodyBase.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: PUColors.textColorRich,
  );

  // Plan card description
  static TextStyle membershipCardDescription = bodySmall.copyWith(
    color: PUColors.textColorLight,
  );

  // Plan card feature
  static TextStyle membershipFeature = bodyBase.copyWith(
    fontSize: 14,
    color: PUColors.textColor3,
  );

  // Discount code applied text
  static TextStyle discountAppliedText = bodyBase.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  // Billing history amount
  static TextStyle billingAmount = bodyBase.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: PUColors.textColorRich,
  );
}

