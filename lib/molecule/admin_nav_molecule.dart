import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/icon_atom.dart';
import '../atoms/title_atom.dart';
import '../utils/pu_colors.dart';

class AdminNavMolecule extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  final List<AdminNavItem> items;
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final VoidCallback? onLogout;

  const AdminNavMolecule({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.items,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.onLogout,
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
          const Divider(height: 1, color: PUColors.borderInputColor),
          Expanded(child: _buildNavItems()),
          if (userName != null) _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          ContainerAtom(
            variant: ContainerVariant.compact,
            backgroundColor: PUColors.primaryColor,
            padding: const EdgeInsets.all(10),
            borderRadius: BorderRadius.circular(12),
            child: const IconAtom(
              icon: Icons.restaurant_menu,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleAtom(text: 'Menucom', fontWeight: FontWeight.w700),
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: PUColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = index == selectedIndex;
        return _NavItemWidget(
          item: item,
          isSelected: isSelected,
          onTap: () => onIndexChanged(index),
        );
      },
    );
  }

  Widget _buildUserInfo() {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: PUColors.primaryBlue,
            backgroundImage: userAvatar != null ? NetworkImage(userAvatar!) : null,
            child: userAvatar == null
                ? Text(
                    (userName ?? 'A')[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName ?? 'Administrador',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PUColors.textColorRich,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (userEmail != null)
                  Text(
                    userEmail!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: PUColors.textColorLight,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (onLogout != null)
            GestureDetector(
              onTap: onLogout,
              child: IconAtom(
                icon: Icons.logout,
                color: PUColors.textColorMuted,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItemWidget extends StatefulWidget {
  final AdminNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<_NavItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 4),
          child: ContainerAtom(
            variant: ContainerVariant.minimal,
            backgroundColor: widget.isSelected
                ? PUColors.primaryBlueLight
                : _isHovered
                    ? PUColors.bgInput
                    : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            borderRadius: BorderRadius.circular(12),
            borderWidth: widget.isSelected ? 2 : 0,
            borderColor:
                widget.isSelected ? PUColors.primaryBlue : Colors.transparent,
            child: Row(
              children: [
                IconAtom(
                  icon: widget.item.icon,
                  color: widget.isSelected
                      ? PUColors.primaryBlue
                      : _isHovered
                          ? PUColors.textColorRich
                          : PUColors.textColorMuted,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: widget.isSelected
                          ? PUColors.primaryBlue
                          : _isHovered
                              ? PUColors.textColorRich
                              : PUColors.textColorMuted,
                    ),
                  ),
                ),
                if (widget.item.badge != null) _buildBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return ContainerAtom(
      variant: ContainerVariant.compact,
      backgroundColor: widget.isSelected
          ? PUColors.primaryBlue
          : PUColors.textColorMuted.withValues(alpha: 0.2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      borderRadius: BorderRadius.circular(10),
      child: Text(
        widget.item.badge!,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: widget.isSelected ? Colors.white : PUColors.textColorMuted,
        ),
      ),
    );
  }
}

class AdminNavItem {
  final IconData icon;
  final String label;
  final String? badge;

  const AdminNavItem({
    required this.icon,
    required this.label,
    this.badge,
  });
}