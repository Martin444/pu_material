import 'package:flutter/material.dart';
import '../atoms/progress_dot.dart';

/// Status Progress Indicator Molecule - Shows progress through multiple states
class StatusProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final bool isMobile;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color completedIconColor;

  const StatusProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.isMobile = false,
    this.backgroundColor = const Color(0x26FFFFFF),
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x4DFFFFFF),
    this.completedIconColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = isMobile ? 8.0 : 10.0;
    final lineWidth = isMobile ? 20.0 : 24.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        // backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          final isActive = index <= currentStep;
          final isCompleted = index < currentStep;

          return Row(
            children: [
              ProgressDot(
                isActive: isActive,
                isCompleted: isCompleted,
                size: dotSize,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                completedIconColor: completedIconColor,
              ),
              if (index < totalSteps - 1)
                Container(
                  width: lineWidth,
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index < currentStep ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
