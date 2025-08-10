import 'package:flutter/material.dart';
import '../atoms/gradient_container.dart';
import '../atoms/status_icon.dart';
import '../molecule/info_card.dart';
import '../molecule/status_progress_indicator.dart';

/// Status Header Configuration
class StatusHeaderConfig {
  final List<Color> gradientColors;
  final Color iconBackgroundColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const StatusHeaderConfig({
    required this.gradientColors,
    required this.iconBackgroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = Colors.white,
  });
}

/// Status Header Organism - A complete header with status, info, and progress
class StatusHeader extends StatefulWidget {
  final bool isMobile;
  final StatusHeaderConfig config;
  final List<InfoItem> infoItems;
  final bool showStatusAnimation;
  final bool showProgressIndicator;
  final int? currentStep;
  final int? totalSteps;
  final VoidCallback? onStatusChange;

  const StatusHeader({
    Key? key,
    required this.isMobile,
    required this.config,
    required this.infoItems,
    this.showStatusAnimation = false,
    this.showProgressIndicator = false,
    this.currentStep,
    this.totalSteps,
    this.onStatusChange,
  }) : super(key: key);

  @override
  State<StatusHeader> createState() => _StatusHeaderState();
}

class _StatusHeaderState extends State<StatusHeader>
    with TickerProviderStateMixin {
  late AnimationController _statusController;
  late Animation<double> _statusAnimation;

  @override
  void initState() {
    super.initState();
    _statusController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _statusAnimation = CurvedAnimation(
      parent: _statusController,
      curve: Curves.elasticOut,
    );

    _statusController.forward();
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      gradientColors: widget.config.gradientColors,
      animationDuration: const Duration(milliseconds: 600),
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            widget.isMobile ? 20 : 32,
            widget.isMobile ? 20 : 30,
            widget.isMobile ? 20 : 32,
            widget.isMobile ? 20 : 30,
          ),
          child: Column(
            children: [
              StatusIcon(
                size: widget.isMobile ? 50 : 60,
                backgroundColor: widget.config.iconBackgroundColor,
                icon: widget.config.icon,
                iconColor: widget.config.iconColor,
                borderWidth: widget.isMobile ? 4 : 6,
                animation: _statusAnimation,
                isRotating: widget.config.icon == Icons.sync,
              ),
              SizedBox(height: widget.isMobile ? 16 : 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  key: ValueKey(widget.config.title),
                  children: [
                    Text(
                      widget.config.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.isMobile ? 24 : 36,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: widget.isMobile ? 4 : 8),
                    Text(
                      widget.config.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: widget.isMobile ? 14 : 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.isMobile ? 20 : 32),
              InfoCard(
                items: widget.infoItems,
                isMobile: widget.isMobile,
              ),
              if (widget.showProgressIndicator &&
                  widget.currentStep != null &&
                  widget.totalSteps != null) ...[
                SizedBox(height: widget.isMobile ? 16 : 20),
                StatusProgressIndicator(
                  currentStep: widget.currentStep!,
                  totalSteps: widget.totalSteps!,
                  isMobile: widget.isMobile,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}