import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class ContextSwitcherMolecule extends StatefulWidget {
  final bool compact;
  final String businessName;
  final VoidCallback onShowSelectionDialog;

  const ContextSwitcherMolecule({
    super.key,
    this.compact = false,
    required this.businessName,
    required this.onShowSelectionDialog,
  });

  @override
  State<ContextSwitcherMolecule> createState() =>
      _ContextSwitcherMoleculeState();
}

class _ContextSwitcherMoleculeState extends State<ContextSwitcherMolecule> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onShowSelectionDialog,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 8 : 12,
            vertical: widget.compact ? 4 : 6,
          ),
          decoration: BoxDecoration(
            color: PUColors.primaryBlueLight.withValues(alpha: 0.5),
            borderRadius: PUBorderRadius.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FluentIcons.store_microsoft_24_regular,
                size: 16,
                color: PUColors.primaryBlue,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  widget.businessName,
                  style: PuTextStyle.bodySmall.copyWith(
                    color: PUColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                FluentIcons.chevron_down_24_regular,
                size: 14,
                color: PUColors.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
