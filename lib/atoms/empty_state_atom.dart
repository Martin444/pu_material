import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:pu_material/widgets/buttons/button_primary.dart';
import 'package:svg_flutter/svg.dart';

/// Empty State Atom - Átomo para mostrar estados vacíos
class EmptyStateAtom extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool isLoading;
  final TextStyle? titleStyle;
  final double? imageHeight;
  final double? maxButtonWidth;

  const EmptyStateAtom({
    super.key,
    this.imagePath,
    required this.title,
    this.buttonText,
    this.onButtonPressed,
    this.isLoading = false,
    this.titleStyle,
    this.imageHeight = 140,
    this.maxButtonWidth = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (imagePath != null) ...[
          SvgPicture.asset(
            imagePath!,
            height: imageHeight,
          ),
          const SizedBox(height: 20),
        ],
        Center(
          child: Text(
            title,
            style: titleStyle ?? PuTextStyle.description1,
            textAlign: TextAlign.center,
          ),
        ),
        if (buttonText != null && onButtonPressed != null) ...[
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(
              maxWidth: maxButtonWidth!,
            ),
            child: ButtonPrimary(
              title: buttonText!,
              onPressed: onButtonPressed!,
              load: isLoading,
            ),
          ),
        ],
      ],
    );
  }
}
