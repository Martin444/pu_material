import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:menu_dart_api/menu_com_api.dart';
import 'package:pu_material/pu_material.dart';

class MPOAuthGateWidget extends StatelessWidget {
  final bool isLoading;
  final bool isLinked;
  final VoidCallback onLink;
  final VoidCallback onShare;
  final String? menuId;

  const MPOAuthGateWidget({
    super.key,
    required this.isLoading,
    required this.isLinked,
    required this.onLink,
    required this.onShare,
    this.menuId,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(4),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (isLinked) {
      return IconButton(
        onPressed: onShare,
        icon: const Icon(FluentIcons.share_24_regular, size: 20),
        tooltip: 'Compartir menú',
        splashRadius: 18,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      );
    }

    return IconButton(
      onPressed: onLink,
      icon: const Icon(FluentIcons.link_24_regular, size: 20),
      tooltip: 'Vincular Mercado Pago',
      splashRadius: 18,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }
}
