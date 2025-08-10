import 'dart:ui';
import 'package:flutter/material.dart';

/// Info Card Molecule - A card displaying key-value information pairs
class InfoCard extends StatelessWidget {
  final List<InfoItem> items;
  final bool isMobile;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  const InfoCard({
    Key? key,
    required this.items,
    this.isMobile = false,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        // backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildItems(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildItems(),
            ),
    );
  }

  List<Widget> _buildItems() {
    final widgets = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      widgets.add(_buildInfoItem(items[i]));
      if (i < items.length - 1 && isMobile) {
        widgets.add(const SizedBox(height: 8));
      }
    }
    return widgets;
  }

  Widget _buildInfoItem(InfoItem item) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: item.textColor,
          fontSize: isMobile ? 13 : 15,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '${item.label} ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: item.value),
        ],
      ),
    );
  }
}

/// Data class for info items
class InfoItem {
  final String label;
  final String value;
  final Color textColor;

  const InfoItem({
    required this.label,
    required this.value,
    this.textColor = Colors.white,
  });
}
