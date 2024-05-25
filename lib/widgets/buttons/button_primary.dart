import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

// ignore: must_be_immutable
class ButtonPrimary extends StatelessWidget {
  //parametros
  String title;
  VoidCallback? onPressed;
  bool load;
  bool disabled = false;

  ButtonPrimary({
    super.key,
    required this.title,
    required this.onPressed,
    required this.load,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: disabled || onPressed == null
              ? MaterialStateProperty.all(PUColors.bgButton)
              : MaterialStateProperty.all(PUColors.bgButton),
          overlayColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 97, 97, 97).withOpacity(0.1),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: disabled || onPressed == null ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !load
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: PuTextStyle.primaryButtonStyle,
                  )
                : SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(PUColors.textColor2),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
