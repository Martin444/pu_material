import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class MenuSide extends StatelessWidget {
  final List<MenuNavItem> items;
  final bool isMobile;
  final VoidCallback? onLogout;
  final String? userName;
  final String? userPhotoUrl;
  final String? businessName;

  const MenuSide({
    super.key,
    required this.items,
    required this.isMobile,
    this.onLogout,
    this.userName,
    this.userPhotoUrl,
    this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (businessName != null || userName != null) _buildUserHeader(),
        ...items.map((item) => _buildNavItem(context, item)),
        const Spacer(),
        if (onLogout != null) _buildLogoutButton(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (businessName != null)
            Text(
              businessName!,
              style: PuTextStyle.title2.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          if (userName != null) ...[
            const SizedBox(height: 4),
            Text(
              userName!,
              style: PuTextStyle.bodySmall.copyWith(
                color: PUColors.textColorMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, MenuNavItem item) {
    final isSelected = item.isSelected;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: item.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? PUColors.primaryBlueLight.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: isSelected
                    ? PUColors.primaryBlue
                    : PUColors.textColorMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? PUColors.primaryBlue
                        : PUColors.textColorRich,
                  ),
                ),
              ),
              if (item.badge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: PUColors.bgError.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.badge!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: PUColors.bgError,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onLogout,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(
                FluentIcons.sign_out_24_regular,
                size: 20,
                color: PUColors.textColorMuted,
              ),
              SizedBox(width: 12),
              Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: PUColors.textColorRich,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuNavItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final String? badge;

  const MenuNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.badge,
  });
}
