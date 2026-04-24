import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/interactive_atom.dart';
import '../atoms/icon_atom.dart';
import '../atoms/title_atom.dart';
import '../utils/pu_colors.dart';

class AdminNavMolecule extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  final List<AdminNavItem> items;
  final String? userName;
  final String? userEmail;

  const AdminNavMolecule({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.items,
    this.userName,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      width: 260,
      backgroundColor: PUColors.bgItem,
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1),
          Expanded(child: _buildNavItems()),
          if (userName != null) _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          ContainerAtom(
            variant: ContainerVariant.compact,
            backgroundColor: PUColors.primaryColor,
            child: const IconAtom(
              icon: Icons.restaurant_menu,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const TitleAtom(text: 'Menucom'),
        ],
      ),
    );
  }

  Widget _buildNavItems() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = index == selectedIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: InteractiveAtom(
            onTap: () => onIndexChanged(index),
            borderRadius: 12,
            child: ContainerAtom(
              variant: ContainerVariant.minimal,
              backgroundColor: isSelected ? PUColors.primaryBlueLight : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconAtom(
                    icon: item.icon,
                    color: isSelected ? PUColors.primaryBlue : PUColors.textColorMuted,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? PUColors.primaryBlue : PUColors.textColorMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(radius: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName ?? 'Administrador',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                if (userEmail != null)
                  Text(
                    userEmail!,
                    style: const TextStyle(fontSize: 12, color: PUColors.textColorLight),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminNavItem {
  final IconData icon;
  final String label;

  const AdminNavItem({
    required this.icon,
    required this.label,
  });
}