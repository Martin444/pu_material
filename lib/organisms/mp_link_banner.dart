import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class MPLinkBanner extends StatelessWidget {
  final bool isVisible;
  final bool isLinked;
  final String? role;
  final bool isLoadingMPStatus;
  final VoidCallback onLink;
  final VoidCallback onRefresh;
  final VoidCallback onClose;

  const MPLinkBanner({
    super.key,
    required this.isVisible,
    required this.isLinked,
    required this.role,
    required this.isLoadingMPStatus,
    required this.onLink,
    required this.onRefresh,
    required this.onClose,
  });

  bool get _isCustomerRole {
    if (role == null) return false;
    return role!.toLowerCase() == 'customer';
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible || isLinked || _isCustomerRole) {
      return const SizedBox.shrink();
    }

    return PuResponsiveBuilder(
      builder: (context, info) {
        final bool isMobile = info.isMobile;
        final bool isSmallMobile = info.width < kSmallBreakpoint;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF009EE3),
                Color(0xFF007EB5),
                Color(0xFF005E87),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF009EE3).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned(
                  right: -50,
                  top: -50,
                  child: Opacity(
                    opacity: 0.1,
                    child: const Icon(
                      FluentIcons.wallet_24_regular,
                      size: 250,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 24 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MPBannerHeader(
                        isMobile: isMobile,
                        isSmallMobile: isSmallMobile,
                        isLoadingMPStatus: isLoadingMPStatus,
                        onRefresh: onRefresh,
                        onClose: onClose,
                      ),
                      const SizedBox(height: 24),
                      const MPBannerBenefits(),
                      const SizedBox(height: 32),
                      MPBannerActions(
                        isMobile: isMobile,
                        onLink: onLink,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
