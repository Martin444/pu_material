import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../utils/pu_colors.dart';

class AdminKpiMolecule extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackground;
  final VoidCallback? onTap;
  final String? subtitle;

  const AdminKpiMolecule({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.iconBackground,
    this.onTap,
    this.subtitle,
  });

  @override
  State<AdminKpiMolecule> createState() => _AdminKpiMoleculeState();
}

class _AdminKpiMoleculeState extends State<AdminKpiMolecule> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: ContainerAtom(
            variant: ContainerVariant.card,
            padding: const EdgeInsets.all(12),
            borderWidth: _isHovered ? 2 : 1,
            borderColor: _isHovered ? PUColors.primaryBlue : PUColors.borderInputColor,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  ContainerAtom(
                    variant: ContainerVariant.compact,
                    backgroundColor: widget.iconBackground ?? PUColors.primaryBlueLight,
                    padding: const EdgeInsets.all(10),
                    child: IconAtom(
                      icon: widget.icon,
                      color: widget.iconColor ?? PUColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: PUColors.textColorRich,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: PUColors.textColorMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.onTap != null)
                    IconAtom(
                      icon: Icons.arrow_forward_ios,
                      color: _isHovered ? PUColors.primaryBlue : PUColors.textColorLight,
                      size: 14,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}