import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class MPRefreshButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onRefresh;

  const MPRefreshButton({
    super.key,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            )
          : IconButton(
              onPressed: onRefresh,
              icon: const Icon(FluentIcons.arrow_sync_24_regular, color: Colors.white),
              tooltip: 'Actualizar estado',
            ),
    );
  }
}

class MPBannerHeader extends StatelessWidget {
  final bool isMobile;
  final bool isSmallMobile;
  final bool isLoadingMPStatus;
  final VoidCallback onRefresh;
  final VoidCallback onClose;

  const MPBannerHeader({
    super.key,
    required this.isMobile,
    required this.isSmallMobile,
    required this.isLoadingMPStatus,
    required this.onRefresh,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            'assets/logo/logo-mp.png',
            width: 52,
            height: 52,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impulsá tu negocio con Mercado Pago',
                style: PuTextStyle.title2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: isSmallMobile ? 20 : 26,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vincular tu cuenta te permite aceptar pagos automáticos y gestionar tus ventas en tiempo real.',
                style: PuTextStyle.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isSmallMobile ? 13 : 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(width: 20),
          MPRefreshButton(
            isLoading: isLoadingMPStatus,
            onRefresh: onRefresh,
          ),
        ],
        const SizedBox(width: 8),
        IconButton(
          onPressed: onClose,
          icon: const Icon(
            FluentIcons.dismiss_24_regular,
            color: Colors.white,
            size: 24,
          ),
          tooltip: 'Ocultar banner',
          splashRadius: 20,
        ),
      ],
    );
  }
}
