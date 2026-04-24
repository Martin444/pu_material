import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../atoms/container_atom.dart';
import '../utils/pu_colors.dart';

class UserListTileMolecule extends StatelessWidget {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final String? photoUrl;
  final bool? isEmailVerified;
  final String? membership;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserListTileMolecule({
    super.key,
    this.id,
    this.name,
    this.email,
    this.role,
    this.photoUrl,
    this.isEmailVerified,
    this.membership,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final content = ContainerAtom(
      variant: ContainerVariant.card,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 16),
            Expanded(child: _buildUserInfo()),
            if (onEdit != null || onDelete != null) ...[
              const SizedBox(width: 8),
              _buildActions(),
            ],
          ],
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: content,
      );
    }
    return content;
  }

  Widget _buildAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: PUColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: photoUrl != null && photoUrl!.isNotEmpty
            ? Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildIconFallback(),
              )
            : _buildIconFallback(),
      ),
    );
  }

  Widget _buildIconFallback() {
    return const Icon(
      FluentIcons.person_24_regular,
      color: PUColors.primaryColor,
      size: 24,
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name ?? 'Sin nombre',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isEmailVerified == true)
              const Icon(
                FluentIcons.checkmark_circle_24_regular,
                size: 16,
                color: PUColors.ctaSuccess,
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          email ?? '',
          style: const TextStyle(
            color: PUColors.textColorMuted,
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (role != null || membership != null) ...[
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              if (role != null)
                _buildBadge(role!, PUColors.primaryBlue),
              if (membership != null)
                _buildBadge(membership!, PUColors.primaryColor),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: color.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          IconButton(
            icon: const Icon(FluentIcons.edit_24_regular, size: 20),
            onPressed: onEdit,
            color: PUColors.textColorMuted,
            visualDensity: VisualDensity.compact,
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(FluentIcons.delete_24_regular, size: 20),
            onPressed: onDelete,
            color: PUColors.bgError,
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}