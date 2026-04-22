import 'package:flutter/material.dart';

class PUColors {
  // --- Core Design System: Liquid Glass / Luxury Minimalist ---
  
  // Backgrounds
  static const Color primaryBackground = Color(0xFFFAFAF9);   // Cream / Off-white
  static const Color secundaryBackground = Color(0xFF1C1917); // Dark Stone
  
  // Interaction & Selection
  static const Color selectedItem = Color(0xFFCA8A04);        // Rich Gold
  static const Color selectedItemLight = Color(0xFFFEF08A);   // Pale Gold
  static const Color bgItem = Color(0xFFFFFFFF);
  static const Color bgItemMenuSelected = Color(0xFFF5F5F6);
  static const Color bgCategorySelected = Color(0xFFEFF6FF);  // Soft Blue BG
  
  // Professional Blues
  static const Color primaryBlue = Color(0xFF2563EB);         // Royal Blue
  static const Color primaryBlueDark = Color(0xFF1E40AF);
  static const Color primaryBlueLight = Color(0xFFDBEAFE);
  
  // Primary Branding (Branding is now sophisticated)
  static const Color primaryColor = Color(0xFF1C1917);        // Use Dark Stone as Primary
  static const Color accentColor = Color(0xFF2563EB);         // Royal Blue as Accent (More Professional)
  
  // Semantic
  static const Color bgError = Color(0xFF991B1B);
  static const Color bgSuccess = Color(0xFF166534);
  static const Color bgWarning = Color(0xFF92400E);
  static const Color bgInfo = Color(0xFF1E293B);
  
  // Glass Effects
  static Color glassBg = Colors.white.withValues(alpha: 0.7);
  static Color glassBorder = Colors.white.withValues(alpha: 0.2);
  static Color glassShadow = const Color(0x1A000000);
  
  // UI Elements
  static const Color bgHeader = Color(0xFFFAFAF9);
  static const Color bgInput = Color(0xFFF3F4F6);
  static Color iconColor = const Color(0xFF44403C);
  static const Color iconColorBlack = Color(0xFF0C0A09);
  static const Color borderInputColor = Color(0xFFE5E7EB);
  
  // Text Tokens
  static const Color textColorRich = Color(0xFF0C0A09);       // Deep Charcoal
  static const Color textColorMuted = Color(0xFF44403C);      // Stone
  static const Color textColorLight = Color(0xFF78716C);      // Light Stone
  static const Color textColorOnDark = Color(0xFFFAFAF9);     // Off-white
  static const Color textColorGold = Color(0xFF2563EB);       // Now Blue (formerly Gold)
  
  // Legacy / Feature Compatibility (Mapped to new theme)
  static const Color restaurantPrimary = Color(0xFF1C1917);
  static const Color restaurantPrimaryLight = Color(0xFF44403C);
  static const Color restaurantPrimaryDark = Color(0xFF0C0A09);
  static const Color restaurantSecondary = Color(0xFF2563EB); // Now Blue
  static const Color restaurantSecondaryLight = Color(0xFF3B82F6);
  static const Color restaurantBackground = Color(0xFFFAFAF9);
  static const Color restaurantText = Color(0xFF0C0A09);
  static const Color restaurantTextMuted = Color(0xFF44403C);
  
  // Compatibility with old variable names
  static Color textColor1 = const Color(0xFF78716C);
  static Color textColor2 = const Color(0xFFFAFAF9);
  static Color textColor3 = const Color(0xFF44403C);
  static Color textColor4 = const Color(0xFF78716C);
  static Color bgLink = const Color(0xFF2563EB); // Now Blue
  static Color bgButton = const Color(0xFF2563EB); // Now Blue (Professional)
  static Color bgSucces = const Color(0xFF166534);
  
  // Hover & Interactive states
  static Color restaurantPrimaryHover = const Color(0xFF292524);
  static Color restaurantSecondaryHover = const Color(0xFFA16207);

  // --- Membership Feature Colors ---
  // Premium tier (sophisticated alternative to gold for premium features)
  static const Color premiumPrimary = Color(0xFF1C1917);   // Dark Stone
  static const Color premiumAccent = Color(0xFFCA8A04);      // Rich Gold
  static const Color premiumBackground = Color(0xFFFEF9C3); // Soft Gold BG
  
  // Enterprise tier
  static const Color enterprisePrimary = Color(0xFF1C1917);   // Dark Stone
  static const Color enterpriseAccent = Color(0xFF44403C);   // Slate
  
  // CTA Colors (semantic)
  static const Color ctaSuccess = Color(0xFF166534);          // Green CTA
  static const Color ctaPrimary = Color(0xFF2563EB);          // Blue CTA (Now Primary for Professionalism)
  static const Color ctaSecondary = Color(0xFF1C1917);        // Dark Stone
  
  // Glassmorphism for membership cards
  static Color glassPremiumBg = const Color(0xFF1C1917).withValues(alpha: 0.85);
  static Color glassPremiumBorder = Colors.white.withValues(alpha: 0.2);
  static Color glassPremiumShadow = const Color(0xFF1C1917).withValues(alpha: 0.25);
}
