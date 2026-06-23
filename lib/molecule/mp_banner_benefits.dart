import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class MPBannerBenefits extends StatelessWidget {
  const MPBannerBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: const [
        MPBenefitBadge(
          icon: FluentIcons.flash_24_regular,
          text: 'Cobros inmediatos',
        ),
        MPBenefitBadge(
          icon: FluentIcons.shield_checkmark_24_regular,
          text: 'Pagos seguros',
        ),
        MPBenefitBadge(
          icon: FluentIcons.data_trending_24_regular,
          text: 'Gestión automática',
        ),
      ],
    );
  }
}
