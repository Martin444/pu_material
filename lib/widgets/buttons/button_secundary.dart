import 'package:flutter/material.dart';
import 'package:pu_material/utils/overflow_text.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

// ignore: must_be_immutable
class ButtonSecundary extends StatelessWidget {
  //parametros
  String title;
  VoidCallback? onPressed;
  bool load;
  bool disabled = false;

  ButtonSecundary({
    super.key,
    required this.title,
    required this.onPressed,
    required this.load,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: disabled || onPressed == null
              ? WidgetStateProperty.all(PUColors.bgCategorySelected)
              : WidgetStateProperty.all(PUColors.bgCategorySelected),
          overlayColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 97, 97, 97).withOpacity(0.1),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: disabled || onPressed == null ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !load
                ? Flexible(
                    child: PUOverflowTextDetector(
                      message: title,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: PuTextStyle.secundaryButtonStyle,
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(PUColors.textColor2),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
