import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../atoms/container_atom.dart';
import '../atoms/user_avatar_atom.dart';
import '../utils/pu_colors.dart';

class UserTableRowMolecule extends StatelessWidget {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? photoUrl;
  final bool? isEmailVerified;
  final bool? hasActiveMembership;
  final bool? hasVinculedAccount;
  final DateTime? createdAt;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserTableRowMolecule({
    super.key,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.photoUrl,
    this.isEmailVerified,
    this.hasActiveMembership,
    this.hasVinculedAccount,
    this.createdAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ContainerAtom(
        variant: ContainerVariant.minimal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildUserCell(),
            ),
            Expanded(
              flex: 2,
              child: _buildInfoCell(email ?? '-'),
            ),
            Expanded(
              flex: 1,
              child: _buildStatusBadge(
                role ?? '-',
                _getRoleColor(role),
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildBoolBadge(hasActiveMembership),
            ),
            Expanded(
              flex: 1,
              child: _buildBoolBadge(hasVinculedAccount),
            ),
            Expanded(
              flex: 1,
              child: Text(
                createdAt != null
                    ? '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}'
                    : '-',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            if (onEdit != null || onDelete != null)
              Expanded(
                flex: 1,
                child: _buildActions(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCell() {
    return Row(
      children: [
        UserAvatarAtom(
          size: 36,
          imageUrl: photoUrl,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name ?? 'Sin nombre',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isEmailVerified == true)
                    const Icon(
                      FluentIcons.checkmark_circle_24_regular,
                      size: 14,
                      color: PUColors.ctaSuccess,
                    ),
                ],
              ),
              if (phone != null && phone!.isNotEmpty)
                Text(
                  phone!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: PUColors.textColorLight,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCell(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: color.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBoolBadge(bool? value) {
    final isTrue = value == true;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isTrue ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: isTrue ? PUColors.ctaSuccess : PUColors.textColorMuted,
        ),
        const SizedBox(width: 4),
        Text(
          isTrue ? 'Sí' : 'No',
          style: TextStyle(
            fontSize: 12,
            color: isTrue ? PUColors.ctaSuccess : PUColors.textColorMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: onEdit,
            color: PUColors.textColorLight,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete, size: 18),
            onPressed: onDelete,
            color: PUColors.bgError,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
      ],
    );
  }

  Color _getRoleColor(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return PUColors.primaryColor;
      case 'owner':
        return PUColors.primaryBlue;
      case 'dinning':
        return PUColors.primaryBlueLight;
      default:
        return PUColors.textColorLight;
    }
  }
}

class UserTableHeaderMolecule extends StatelessWidget {
  const UserTableHeaderMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      variant: ContainerVariant.minimal,
      backgroundColor: PUColors.bgInput,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text('Usuario', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 2, child: Text('Email', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 1, child: Text('Rol', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 1, child: Text('Membresía', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 1, child: Text('MP', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 1, child: Text('Creado', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 1, child: Text('Acciones', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
        ],
      ),
    );
  }
}