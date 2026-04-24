import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../utils/pu_colors.dart';

class AdminKpiMolecule extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackground;
  final VoidCallback? onTap;

  const AdminKpiMolecule({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.iconBackground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerAtom(
        variant: ContainerVariant.card,
        child: Row(
          children: [
            ContainerAtom(
              variant: ContainerVariant.compact,
              backgroundColor: iconBackground ?? PUColors.primaryBlueLight,
              child: IconAtom(
                icon: icon,
                color: iconColor ?? PUColors.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: PUColors.textColorMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}