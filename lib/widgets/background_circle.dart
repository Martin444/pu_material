import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';

class BackgroundCircles extends StatefulWidget {
  final bool? withBlur;

  const BackgroundCircles({super.key, this.withBlur});

  @override
  State<BackgroundCircles> createState() => _BackgroundCirclesState();
}

class _BackgroundCirclesState extends State<BackgroundCircles> {
  @override
  Widget build(BuildContext context) {
    var heigth = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: heigth / 2,
          right: 10,
          child: Container(
            height: 600,
            width: 600,
            decoration: BoxDecoration(
              color: PUColors.secundaryBackgroundCircle1,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: heigth / 9,
          right: -20,
          child: Container(
            height: 700,
            width: 700,
            decoration: BoxDecoration(
              color: PUColors.secundaryBackgroundCircle2,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -132,
          left: -140,
          child: Container(
            height: 800,
            width: 800,
            decoration: BoxDecoration(
              color: PUColors.secundaryBackgroundCircle4,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: heigth / 2,
          left: -30,
          child: Container(
            height: 800,
            width: 800,
            decoration: BoxDecoration(
              color: PUColors.secundaryBackgroundCircle3,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Visibility(
          visible: widget.withBlur ?? false,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 60,
                sigmaY: 60,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
