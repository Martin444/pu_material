import 'package:flutter/material.dart';
import 'package:pu_material/atoms/atom_text.dart';
import 'package:pu_material/atoms/atom_button.dart';

/// Molecule Promo Card - Molécula para tarjeta promocional
class MoleculePromoCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onButtonTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? fontSize;

  const MoleculePromoCard({
    required this.title,
    required this.buttonText,
    required this.onButtonTap,
    super.key,
    this.backgroundColor,
    this.textColor,
    this.buttonBackgroundColor,
    this.buttonTextColor,
    this.padding,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color.fromARGB(255, 239, 239, 239), // fondo lila claro
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AtomText(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black87,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          AtomButton(
            label: buttonText,
            onPressed: onButtonTap,
            backgroundColor: buttonBackgroundColor,
            textColor: buttonTextColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}
