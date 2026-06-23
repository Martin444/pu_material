import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class GetFunctionButton extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final String roleType;
  final bool isFreePlan;
  final bool isListEmpty;
  final VoidCallback? onRetry;
  final VoidCallback? onEmptyListAction;
  final VoidCallback? onSingleItemAction;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final String? singleItemLabel;
  final String? emptyListLabel;
  final String? primaryLabel;
  final String? secondaryLabel;

  const GetFunctionButton({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.roleType,
    required this.isFreePlan,
    required this.isListEmpty,
    this.onRetry,
    this.onEmptyListAction,
    this.onSingleItemAction,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.singleItemLabel,
    this.emptyListLabel,
    this.primaryLabel,
    this.secondaryLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return DashboardErrorState(
        isCompact: true,
        onRetry: onRetry,
      );
    }

    if (isListEmpty && emptyListLabel != null) {
      return ButtonPrimary(
        title: emptyListLabel!,
        onPressed: onEmptyListAction ?? () {},
        load: false,
      );
    }

    if (isFreePlan && singleItemLabel != null) {
      return ButtonSecundary(
        title: singleItemLabel!,
        onPressed: onSingleItemAction ?? () {},
        load: false,
      );
    }

    if (primaryLabel != null && secondaryLabel != null) {
      return Row(
        children: [
          Flexible(
            child: ButtonSecundary(
              title: secondaryLabel!,
              onPressed: onSecondaryAction ?? () {},
              load: false,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: ButtonPrimary(
              title: primaryLabel!,
              onPressed: onPrimaryAction ?? () {},
              load: false,
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class GetFunctionButtonConfig {
  final String? emptyListLabel;
  final String? singleItemLabel;
  final String? primaryLabel;
  final String? secondaryLabel;
  final VoidCallback? onEmptyListAction;
  final VoidCallback? onSingleItemAction;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final VoidCallback? onRetry;

  const GetFunctionButtonConfig({
    this.emptyListLabel,
    this.singleItemLabel,
    this.primaryLabel,
    this.secondaryLabel,
    this.onEmptyListAction,
    this.onSingleItemAction,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.onRetry,
  });
}
