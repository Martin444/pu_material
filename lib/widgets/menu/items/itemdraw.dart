import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:svg_flutter/svg.dart';

class ItemDrawMenu extends StatelessWidget {
  final String icon;
  final String label;
  final bool? isSelected;
  final Function onRoute;
  const ItemDrawMenu({
    super.key,
    required this.icon,
    this.isSelected,
    required this.label,
    required this.onRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onRoute();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ?? false ? PUColors.bgItemMenuSelected : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  isSelected ?? false ? PUColors.primaryColor : PUColors.iconColor,
                  BlendMode.src,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: PuTextStyle.title3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
