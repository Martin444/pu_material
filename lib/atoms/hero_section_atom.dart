import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';
import '../utils/style/pu_style_fonts.dart';

/// HeroSection Atom - Banner principal del catálogo/restaurante
///
/// Átomo atómico para mostrar banner hero con imagen, título y CTA.
/// Uso: HomePage, Landing pages, Promociones especiales.
///
/// Follows atomic design principles:
/// - Single responsibility: Display hero banner with call-to-action
/// - Agnostic: Works with any business type
/// - Composable: Can be wrapped by molecules/organisms
class HeroSectionAtom extends StatelessWidget {
  const HeroSectionAtom({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.ctaText,
    this.onCtaTap,
    this.height = 280,
    this.ctaColor,
    this.ctaTextColor,
    this.titleColor,
    this.subtitleColor,
    this.overlayColor,
    this.overlayOpacity = 0.5,
  });

  /// Título principal del hero
  final String title;

  /// Subtítulo opcional (descripción breve)
  final String? subtitle;

  /// URL de la imagen de fondo
  final String? imageUrl;

  /// Texto del botón de acción
  final String? ctaText;

  /// Callback al presionar CTA
  final VoidCallback? onCtaTap;

  /// Altura del hero
  final double height;

  /// Color del botón CTA
  final Color? ctaColor;

  /// Color del texto del botón
  final Color? ctaTextColor;

  /// Color del título
  final Color? titleColor;

  /// Color del subtítulo
  final Color? subtitleColor;

  /// Color de la capa overlay
  final Color? overlayColor;

  /// Opacidad del overlay (0.0 - 1.0)
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: imageUrl == null ? PUColors.restaurantPrimary : null,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
                onError: (_, __) {},
              )
            : null,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Overlay para légibilidade del texto
          if (imageUrl != null)
            Container(
              color: overlayColor?.withValues(alpha: overlayOpacity) ??
                  Colors.black.withValues(alpha: overlayOpacity),
            ),

          // Contenido
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title,
                  style: PuTextStyle.title1.copyWith(
                    color: titleColor ?? Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),

                // Subtítulo
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    subtitle!,
                    style: PuTextStyle.subtitle.copyWith(
                      color: subtitleColor ?? Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // CTA Button
                if (ctaText != null && onCtaTap != null) ...[
                  const SizedBox(height: 24),
                  _buildCtaButton(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el botón CTA con accesibilidad
  Widget _buildCtaButton() {
    return Semantics(
      label: 'Botón $ctaText',
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onCtaTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              color: ctaColor ?? PUColors.restaurantSecondary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              ctaText!,
              style: PuTextStyle.buttonTextStyle.copyWith(
                color: ctaTextColor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Variante simple del hero con solo título (para negocios pequeños)
class HeroSimpleAtom extends StatelessWidget {
  const HeroSimpleAtom({
    super.key,
    required this.title,
    this.subtitle,
    this.height = 200,
  });

  final String title;
  final String? subtitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PUColors.restaurantPrimary,
            PUColors.restaurantPrimaryDark,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: PuTextStyle.title1.copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: PuTextStyle.subtitle.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}