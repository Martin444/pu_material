import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
  final List<InfoItem>? infoItems;
  final bool showStatusAnimation;
  final bool showProgressIndicator;
  final int? currentStep;
  final int? totalSteps;
  final VoidCallback? onStatusChange;

  const StatusHeader({
    super.key,
    required this.isMobile,
    required this.config,
    this.infoItems,
    this.showStatusAnimation = false,
    this.showProgressIndicator = false,
    this.currentStep,
    this.totalSteps,
    this.onStatusChange,
  });

  @override
  State<StatusHeader> createState() => _StatusHeaderState();
}

class _StatusHeaderState extends State<StatusHeader> with TickerProviderStateMixin {
  late AnimationController _statusController;
  late AnimationController _textController;
  late AnimationController _infoController;
  late AnimationController _progressController;

  late Animation<double> _statusAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _infoAnimation;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _infoSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador principal para el ícono de estado
    _statusController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Controlador para el texto (título y subtítulo)
    _textController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Controlador para la tarjeta de información
    _infoController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Controlador para el indicador de progreso
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Animaciones de escala y opacidad
    _statusAnimation = CurvedAnimation(
      parent: _statusController,
      curve: Curves.elasticOut,
    );

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutBack,
    );

    _infoAnimation = CurvedAnimation(
      parent: _infoController,
      curve: Curves.easeOutQuart,
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOut,
    );

    // Animaciones de deslizamiento
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(_textAnimation);

    _infoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_infoAnimation);

    // Iniciar secuencia de animaciones
    _startAnimationSequence();
  }

  Future<void> _startAnimationSequence() async {
    // 1. Animar ícono de estado
    await _statusController.forward();

    // 2. Animar texto con un pequeño delay
    await Future.delayed(const Duration(milliseconds: 100));
    await _textController.forward();

    // 3. Animar tarjeta de información
    await Future.delayed(const Duration(milliseconds: 150));
    await _infoController.forward();

    // 4. Animar indicador de progreso si está presente
    if (widget.showProgressIndicator) {
      await Future.delayed(const Duration(milliseconds: 100));
      await _progressController.forward();
    }
  }

  void _resetAndReplayAnimations() {
    _statusController.reset();
    _textController.reset();
    _infoController.reset();
    _progressController.reset();
    _startAnimationSequence();
  }

  @override
  void didUpdateWidget(StatusHeader oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si cambia la configuración de estado, reiniciar animaciones
    if (oldWidget.config.title != widget.config.title || oldWidget.config.icon != widget.config.icon) {
      _resetAndReplayAnimations();
    }

    // Si se muestra/oculta el indicador de progreso
    if (oldWidget.showProgressIndicator != widget.showProgressIndicator) {
      if (widget.showProgressIndicator) {
        _progressController.forward();
      } else {
        _progressController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _statusController.dispose();
    _textController.dispose();
    _infoController.dispose();
    _progressController.dispose();
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
              // Ícono de estado animado
              AnimatedBuilder(
                animation: _statusAnimation,
                builder: (context, child) {
                  final scale = _statusAnimation.value;
                  final opacity = (_statusAnimation.value).clamp(0.0, 1.0);
                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: StatusIcon(
                        size: widget.isMobile ? 50 : 60,
                        backgroundColor: widget.config.iconBackgroundColor,
                        icon: widget.config.icon,
                        iconColor: widget.config.iconColor,
                        borderWidth: widget.isMobile ? 4 : 6,
                        animation: _statusAnimation,
                        isRotating: widget.config.icon == FluentIcons.arrow_sync_24_regular,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: widget.isMobile ? 16 : 20),

              // Texto animado con deslizamiento
              AnimatedBuilder(
                animation: _textAnimation,
                builder: (context, child) {
                  return SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textAnimation,
                      child: AnimatedSwitcher(
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
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: widget.isMobile ? 14 : 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: widget.isMobile ? 20 : 32),

              // Tarjeta de información animada
              AnimatedBuilder(
                animation: _infoAnimation,
                builder: (context, child) {
                  return SlideTransition(
                    position: _infoSlideAnimation,
                    child: FadeTransition(
                      opacity: _infoAnimation,
                      child: Transform.scale(
                        scale: 0.8 + (0.2 * _infoAnimation.value),
                        child: InfoCard(
                          items: widget.infoItems ?? [],
                          isMobile: widget.isMobile,
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Indicador de progreso animado
              if (widget.showProgressIndicator && widget.currentStep != null && widget.totalSteps != null) ...[
                SizedBox(height: widget.isMobile ? 16 : 20),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _progressAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - _progressAnimation.value)),
                        child: StatusProgressIndicator(
                          currentStep: widget.currentStep!,
                          totalSteps: widget.totalSteps!,
                          isMobile: widget.isMobile,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
