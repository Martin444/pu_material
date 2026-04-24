import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../atoms/title_atom.dart';
import '../utils/pu_colors.dart';

class AdminHeaderMolecule extends StatelessWidget {
  final String title;
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final String? searchHint;
  final ValueChanged<String>? onSearch;
  final List<Widget>? actions;

  const AdminHeaderMolecule({
    super.key,
    required this.title,
    this.onRefresh,
    this.onAdd,
    this.searchHint,
    this.onSearch,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: PUColors.bgItem,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TitleAtom(text: title, level: TitleLevel.h1),
              const Spacer(),
              ...?actions,
              if (onRefresh != null)
                _buildActionButton(
                  icon: Icons.refresh,
                  onTap: onRefresh!,
                  tooltip: 'Actualizar',
                ),
              if (onAdd != null) ...[
                const SizedBox(width: 12),
                _buildActionButton(
                  icon: Icons.add,
                  onTap: onAdd!,
                  tooltip: 'Agregar',
                  filled: true,
                ),
              ],
            ],
          ),
          if (onSearch != null) ...[
            const SizedBox(height: 16),
            _buildSearchField(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: PUColors.borderInputColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconAtom(
            icon: Icons.search,
            color: PUColors.textColorMuted,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(color: PUColors.textColorLight),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 14),
              onChanged: onSearch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
    bool filled = false,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ContainerAtom(
            variant: ContainerVariant.minimal,
            padding: const EdgeInsets.all(12),
            backgroundColor: filled ? PUColors.primaryBlue : Colors.transparent,
            borderColor: filled ? PUColors.primaryBlue : PUColors.borderInputColor,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(12),
            child: IconAtom(
              icon: icon,
              color: filled ? Colors.white : PUColors.textColorMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}