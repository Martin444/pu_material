import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../atoms/title_atom.dart';
import '../utils/pu_colors.dart';

class AdminHeaderMolecule extends StatelessWidget {
  final String title;
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;

  const AdminHeaderMolecule({
    super.key,
    required this.title,
    this.onRefresh,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: PUColors.bgItem,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          TitleAtom(text: title),
          const Spacer(),
          if (onRefresh != null)
            _buildActionButton(
              icon: Icons.refresh,
              onTap: onRefresh!,
            ),
          if (onAdd != null) ...[
            const SizedBox(width: 16),
            _buildActionButton(
              icon: Icons.add,
              onTap: onAdd!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerAtom(
        variant: ContainerVariant.minimal,
        padding: const EdgeInsets.all(10),
        borderColor: PUColors.borderInputColor,
        borderWidth: 1,
        child: IconAtom(
          icon: icon,
          color: PUColors.textColorMuted,
          size: 20,
        ),
      ),
    );
  }
}