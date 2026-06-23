import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:collection/collection.dart';
import 'package:pu_material/pu_material.dart';

class CommerceSelectionDialog {
  static Future<void> show({
    required BuildContext context,
    required List<CommerceSelectionItem> contexts,
    required bool isLoading,
    required Future<void> Function(CommerceSelectionItem) onSwitch,
    required VoidCallback onEditCurrent,
    required VoidCallback onCreateNew,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: PUBorderRadius.lg,
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        title: const Row(
          children: [
            Icon(
              FluentIcons.store_microsoft_24_regular,
              color: PUColors.primaryBlue,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Mis negocios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SizedBox(
            width: double.maxFinite,
            child: _CommerceSelectionContent(
              contexts: contexts,
              isLoading: isLoading,
              onSwitch: onSwitch,
              onEditCurrent: onEditCurrent,
              onCreateNew: onCreateNew,
              showClose: true,
            ),
          ),
        ),
      ),
    );
  }
}

class CommerceSelectionItem {
  final String id;
  final String businessName;
  final String slug;
  final String? role;
  final bool isCurrent;

  const CommerceSelectionItem({
    required this.id,
    required this.businessName,
    required this.slug,
    this.role,
    required this.isCurrent,
  });
}

class _CommerceSelectionContent extends StatelessWidget {
  final List<CommerceSelectionItem> contexts;
  final bool isLoading;
  final Future<void> Function(CommerceSelectionItem) onSwitch;
  final VoidCallback onEditCurrent;
  final VoidCallback onCreateNew;
  final bool showClose;

  const _CommerceSelectionContent({
    required this.contexts,
    required this.isLoading,
    required this.onSwitch,
    required this.onEditCurrent,
    required this.onCreateNew,
    this.showClose = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final activeContext = contexts.firstWhereOrNull((c) => c.isCurrent);
    final otherContexts = contexts.where((c) => !c.isCurrent).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (activeContext != null) ...[
          const Text(
            'Comercio actual',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: PUColors.textColorMuted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          _CommerceCard(
            item: activeContext,
            isActive: true,
            onTap: () => onSwitch(activeContext),
            onEdit: onEditCurrent,
          ),
        ],
        if (otherContexts.isNotEmpty) ...[
          SizedBox(height: activeContext != null ? 24 : 0),
          Text(
            activeContext != null
                ? 'Cambiar a otro comercio'
                : 'Selecciona un comercio',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: PUColors.textColorMuted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          ...otherContexts.map((ctxItem) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _CommerceCard(
                item: ctxItem,
                isActive: false,
                onTap: () => onSwitch(ctxItem),
              ),
            );
          }),
        ],
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 12),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: PUBorderRadius.lg,
            onTap: onCreateNew,
            child: Container(
              decoration: BoxDecoration(
                color: PUColors.primaryBlueLight.withValues(alpha: 0.3),
                borderRadius: PUBorderRadius.lg,
                border: Border.all(
                  color: PUColors.primaryBlue.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  _CreateIcon(),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Crear nuevo negocio',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: PUColors.primaryBlue,
                      ),
                    ),
                  ),
                  Icon(
                    FluentIcons.arrow_right_24_regular,
                    color: PUColors.primaryBlue,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CreateIcon extends StatelessWidget {
  const _CreateIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: PUColors.primaryBlue,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        FluentIcons.add_24_regular,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

class _CommerceCard extends StatelessWidget {
  final CommerceSelectionItem item;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onEdit;

  const _CommerceCard({
    required this.item,
    required this.isActive,
    required this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: PUBorderRadius.lg,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive
                ? PUColors.primaryBlueLight.withValues(alpha: 0.4)
                : PUColors.bgInput,
            border: isActive
                ? Border.all(
                    color: PUColors.primaryBlue.withValues(alpha: 0.3),
                    width: 1.5,
                  )
                : null,
            borderRadius: PUBorderRadius.lg,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: isActive ? 44 : 40,
                height: isActive ? 44 : 40,
                decoration: BoxDecoration(
                  color: isActive
                      ? PUColors.primaryBlue.withValues(alpha: 0.15)
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: !isActive
                      ? Border.all(color: PUColors.bgInput, width: 1)
                      : null,
                ),
                child: Icon(
                  isActive
                      ? FluentIcons.store_microsoft_24_filled
                      : FluentIcons.store_microsoft_24_regular,
                  color: isActive
                      ? PUColors.primaryBlue
                      : PUColors.textColorMuted,
                  size: isActive ? 22 : 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.businessName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: isActive ? 15 : 14,
                        color: PUColors.textColorRich,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.role != null
                          ? '${item.slug}  •  ${item.role}'
                          : item.slug,
                      style: PuTextStyle.bodySmall,
                    ),
                  ],
                ),
              ),
              if (isActive && onEdit != null) ...[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: PUBorderRadius.md,
                    onTap: onEdit,
                    child: const Tooltip(
                      message: 'Editar perfil del negocio',
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          FluentIcons.edit_24_regular,
                          size: 18,
                          color: PUColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: PUColors.primaryBlue,
                    borderRadius: PUBorderRadius.full,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FluentIcons.checkmark_12_filled,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Actual',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (!isActive)
                const Icon(
                  FluentIcons.arrow_right_24_regular,
                  color: PUColors.textColorMuted,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
