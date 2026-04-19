// Level: Atom
// Description: Pequeño componente de botón primario reutilizable.
import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

// ignore: must_be_immutable

class ButtonPrimary extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool load;
  final bool disabled;
  final IconData? icon;

  const ButtonPrimary({
    super.key,
    required this.title,
    required this.onPressed,
    required this.load,
    this.disabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = disabled || onPressed == null;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: Colors.transparent,
        elevation: isDisabled ? 0 : 4,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isDisabled ? null : onPressed,
          splashColor: PUColors.textColor2.withOpacity(0.12),
          child: Ink(
            decoration: BoxDecoration(
              color: PUColors.bgButton,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isDisabled
                  ? []
                  : [
                      BoxShadow(
                        color: PUColors.textColor2.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
              child: Center(
                child: load
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(PUColors.textColor2),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              size: 22,
                              color: PUColors.textColor2,
                            ),
                            const SizedBox(width: 10),
                          ],
                          Flexible(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: PuTextStyle.primaryButtonStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
