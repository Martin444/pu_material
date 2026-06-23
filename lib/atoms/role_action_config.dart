import 'package:flutter/material.dart';

class RoleActionConfig {
  final String emptyListLabel;
  final String emptyListRoute;
  final String singleItemLabel;
  final String singleItemRoute;
  final String secondaryLabel;
  final String secondaryRoute;
  final String primaryLabel;
  final String primaryRoute;
  final VoidCallback? onTap;
  final String? onTapLabel;

  const RoleActionConfig({
    required this.emptyListLabel,
    required this.emptyListRoute,
    required this.singleItemLabel,
    required this.singleItemRoute,
    required this.secondaryLabel,
    required this.secondaryRoute,
    required this.primaryLabel,
    required this.primaryRoute,
    this.onTap,
    this.onTapLabel,
  });
}
