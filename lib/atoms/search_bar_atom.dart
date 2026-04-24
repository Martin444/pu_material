import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

class SearchBarAtom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSubmitted;

  const SearchBarAtom({
    super.key,
    required this.controller,
    this.hintText = 'Buscar...',
    this.onChanged,
    this.onClear,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: PUColors.bgInput,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: PUColors.borderInputColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            FluentIcons.search_24_regular,
            size: 20,
            color: PUColors.iconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: PUColors.textColorLight,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: onChanged,
              onSubmitted: (_) => onSubmitted?.call(),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(
                FluentIcons.dismiss_24_regular,
                size: 16,
              ),
              onPressed: () {
                controller.clear();
                onClear?.call();
              },
              color: PUColors.iconColor,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}