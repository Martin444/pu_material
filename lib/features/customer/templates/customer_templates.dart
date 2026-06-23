import 'package:flutter/material.dart';
import 'package:menu_dart_api/menu_com_api.dart';
import '../organisms/customer_organisms.dart';
import '../molecules/customer_molecules.dart';
import '../utils/responsive_breakpoints.dart';

class CustomerMobileTemplate extends StatelessWidget {
  const CustomerMobileTemplate({
    super.key,
    required this.userName,
    required this.commercesList,
    required this.isLoadingCommerces,
    required this.accessTokenHashed,
    this.onCommerceSelected,
  });

  final String userName;
  final String accessTokenHashed;
  final List<UserByRoleModel> commercesList;
  final bool isLoadingCommerces;
  final void Function(UserByRoleModel)? onCommerceSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivePadding = ResponsiveBreakpoints.getResponsivePadding(
        screenWidth, basePadding: 16);
    final responsiveSpacing = ResponsiveBreakpoints.getResponsiveSpacing(
        screenWidth, baseSpacing: 24);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: responsivePadding,
        vertical: responsivePadding * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerWelcomeHeader(
            userName: userName,
            isMobile: true,
          ),
          SizedBox(height: responsiveSpacing),
          CustomerFeaturedCommerces(
            isMobile: true,
            commercesList: commercesList,
            isLoading: isLoadingCommerces,
            onCommerceSelected: onCommerceSelected,
            accessTokenHashed: accessTokenHashed,
          ),
          SizedBox(height: responsiveSpacing),
          const CustomerServiceInfo(isMobile: true),
          SizedBox(height: responsiveSpacing * 0.75),
        ],
      ),
    );
  }
}

class CustomerTabletTemplate extends StatelessWidget {
  const CustomerTabletTemplate({
    super.key,
    required this.userName,
    required this.commercesList,
    required this.isLoadingCommerces,
    required this.accessTokenHashed,
    this.onCommerceSelected,
  });

  final String userName;
  final String accessTokenHashed;
  final List<UserByRoleModel> commercesList;
  final bool isLoadingCommerces;
  final void Function(UserByRoleModel)? onCommerceSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isLandscape = screenWidth > screenHeight;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerWelcomeHeader(
            userName: userName,
            isMobile: false,
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: CustomerFeaturedCommerces(
            isMobile: false,
            commercesList: commercesList,
            isLoading: isLoadingCommerces,
            onCommerceSelected: onCommerceSelected,
            accessTokenHashed: accessTokenHashed,
          ),
        ),
        const SizedBox(width: 20),
        const Expanded(
          flex: 3,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomerSidePanel(),
                SizedBox(height: 16),
                CustomerServiceInfo(isMobile: false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerFeaturedCommerces(
            isMobile: false,
            commercesList: commercesList,
            isLoading: isLoadingCommerces,
            onCommerceSelected: onCommerceSelected,
            accessTokenHashed: accessTokenHashed,
          ),
          const SizedBox(height: 24),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CustomerSidePanel()),
              SizedBox(width: 16),
              Expanded(child: CustomerServiceInfo(isMobile: false)),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CustomerDesktopTemplate extends StatelessWidget {
  const CustomerDesktopTemplate({
    super.key,
    required this.userName,
    required this.commercesList,
    required this.isLoadingCommerces,
    required this.accessTokenHashed,
    this.onCommerceSelected,
  });

  final String userName;
  final String accessTokenHashed;
  final List<UserByRoleModel> commercesList;
  final bool isLoadingCommerces;
  final void Function(UserByRoleModel)? onCommerceSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerWelcomeHeader(
          userName: userName,
          isMobile: false,
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomerFeaturedCommerces(
                        isMobile: false,
                        commercesList: commercesList,
                        isLoading: isLoadingCommerces,
                        onCommerceSelected: onCommerceSelected,
                        accessTokenHashed: accessTokenHashed,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomerSidePanel(),
                      SizedBox(height: 24),
                      CustomerServiceInfo(isMobile: false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
