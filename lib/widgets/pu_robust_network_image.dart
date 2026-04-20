// Level: Atom
// Description: Widget de imagen de red robusto con soporte de fallbacks y manejo de errores.
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/image_debug_utils.dart';

// Resultado del procesamiento de imagen
class ImageProcessingResult {
  final String processedUrl;
  final List<String> fallbackUrls;
  final bool isValid;
  final String? error;

  ImageProcessingResult({
    required this.processedUrl,
    required this.fallbackUrls,
    required this.isValid,
    this.error,
  });
}

class PuRobustNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool clearCacheOnError;

  const PuRobustNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.clearCacheOnError = true,
  });

  @override
  State<PuRobustNetworkImage> createState() => _PuRobustNetworkImageState();
}

class _PuRobustNetworkImageState extends State<PuRobustNetworkImage> {
  ImageProcessingResult? _processingResult;
  bool _isProcessing = true;
  String? _currentUrl;
  int _currentFallbackIndex = 0;

  @override
  void initState() {
    super.initState();
    _processImageUrl();
  }

  @override
  void didUpdateWidget(PuRobustNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _isProcessing = true;
      _processingResult = null;
      _currentUrl = null;
      _currentFallbackIndex = 0;
      _processImageUrl();
    }
  }

  Future<void> _processImageUrl() async {
    if (widget.imageUrl.isEmpty) {
      setState(() {
        _processingResult = ImageProcessingResult(
          processedUrl: '',
          fallbackUrls: [],
          isValid: false,
          error: 'Empty URL provided',
        );
        _isProcessing = false;
      });
      return;
    }

    try {
      ImageProcessingResult result;

      // En Flutter Web, usar procesamiento síncrono
      if (kIsWeb) {
        result = await _processUrlSynchronously(widget.imageUrl);
      } else {
        // En plataformas nativas, intentar usar isolates
        result = await _processUrlWithIsolateIfAvailable(widget.imageUrl);
      }

      if (mounted) {
        setState(() {
          _processingResult = result;
          _currentUrl = result.processedUrl;
          _isProcessing = false;
        });
      }
    } catch (e) {
      debugPrint('Error processing image URL: $e');
      if (mounted) {
        setState(() {
          _processingResult = ImageProcessingResult(
            processedUrl: widget.imageUrl,
            fallbackUrls: [widget.imageUrl],
            isValid: true,
            error: e.toString(),
          );
          _currentUrl = widget.imageUrl;
          _isProcessing = false;
        });
      }
    }
  }

  Future<ImageProcessingResult> _processUrlSynchronously(String url) async {
    try {
      // Limpiar URL
      final cleanedUrl = url.trim().replaceAll(RegExp(r'\s+'), '');

      // Procesar URL y generar fallbacks
      final processedUrl = _processUrl(cleanedUrl);
      final fallbackUrls = _generateFallbackUrls(cleanedUrl);

      // Validar URL
      final isValid = _isValidUrl(processedUrl);

      return ImageProcessingResult(
        processedUrl: processedUrl,
        fallbackUrls: fallbackUrls,
        isValid: isValid,
      );
    } catch (e) {
      return ImageProcessingResult(
        processedUrl: url,
        fallbackUrls: [url],
        isValid: false,
        error: e.toString(),
      );
    }
  }

  Future<ImageProcessingResult> _processUrlWithIsolateIfAvailable(String url) async {
    try {
      // Intentar usar isolates si están disponibles
      if (!kIsWeb) {
        // Importar isolates dinámicamente solo en plataformas nativas
        final isolate = await _createIsolateIfAvailable(url);
        if (isolate != null) {
          return isolate;
        }
      }

      // Fallback a procesamiento síncrono
      return await _processUrlSynchronously(url);
    } catch (e) {
      debugPrint('Error with isolate processing, falling back to sync: $e');
      return await _processUrlSynchronously(url);
    }
  }

  Future<ImageProcessingResult?> _createIsolateIfAvailable(String url) async {
    try {
      // Esta función se implementaría usando isolates en plataformas nativas
      // Por ahora, siempre usar procesamiento síncrono para evitar problemas
      return null;
    } catch (e) {
      debugPrint('Isolate not available: $e');
      return null;
    }
  }

  String _processUrl(String url) {
    // Si detectamos un proxy localhost, extraer la URL de Cloudinary directamente
    if (url.contains('localhost') && url.contains('image-proxy') && url.contains('url=')) {
      try {
        final uri = Uri.parse(url);
        final encodedUrl = uri.queryParameters['url'];
        if (encodedUrl != null) {
          final decodedUrl = Uri.decodeComponent(encodedUrl);
          return decodedUrl;
        }
      } catch (e) {
        // Si falla, devolver URL original
      }
    }

    // Si detectamos proxy de API Heroku, extraer la URL de Cloudinary directamente
    if (url.contains('menucom-api') && url.contains('image-proxy') && url.contains('url=')) {
      try {
        final uri = Uri.parse(url);
        final encodedUrl = uri.queryParameters['url'];
        if (encodedUrl != null) {
          final decodedUrl = Uri.decodeComponent(encodedUrl);
          return decodedUrl;
        }
      } catch (e) {
        // Si falla, devolver URL original
      }
    }

    // Si la URL ya es una URL directa de Cloudinary, mantenerla
    if (url.contains('res.cloudinary.com')) {
      return url;
    }

    return url;
  }

  List<String> _generateFallbackUrls(String originalUrl) {
    final urls = <String>[];

    // Agregar URL original
    urls.add(originalUrl);

    // Si es un proxy, también intentar con la URL directa extraída
    if (originalUrl.contains('image-proxy') && originalUrl.contains('url=')) {
      try {
        final uri = Uri.parse(originalUrl);
        final encodedUrl = uri.queryParameters['url'];
        if (encodedUrl != null) {
          final directUrl = Uri.decodeComponent(encodedUrl);
          if (directUrl != originalUrl && !urls.contains(directUrl)) {
            urls.add(directUrl);
          }
        }
      } catch (e) {
        // Si falla, continuar con las URLs que tenemos
      }
    }

    return urls;
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar placeholder mientras se procesa
    if (_isProcessing) {
      return _buildPlaceholder();
    }

    // Si no hay resultado o la URL no es válida, mostrar error
    if (_processingResult == null || !_processingResult!.isValid) {
      return _buildErrorWidget();
    }

    // Usar CachedNetworkImage con la URL procesada
    // Procesar la URL para optimización en Cloudinary (solo si es una URL de Cloudinary)
    String optimizedUrl = _getOptimizedImageUrl(_currentUrl!);

    if (kIsWeb) {
      return Image.network(
        optimizedUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorWithFallback(optimizedUrl, error),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
        headers: const {
          'Accept': 'image/*',
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: optimizedUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.cover,
      // Optimización de memoria crítica para Flutter Web / CanvasKit
      memCacheWidth: (widget.width != null && widget.width!.isFinite && widget.width! > 0)
          ? (widget.width! * 1.2).round().clamp(1, 3000)
          : null,
      memCacheHeight: (widget.height != null && widget.height!.isFinite && widget.height! > 0)
          ? (widget.height! * 1.2).round().clamp(1, 3000)
          : null,
      maxWidthDiskCache: 1000,
      maxHeightDiskCache: 1000,
      placeholder: (context, url) => widget.placeholder ?? _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWithFallback(url, error),
      httpHeaders: const {
        'User-Agent': 'Flutter App',
        'Accept': 'image/*',
        'Cache-Control': 'no-cache',
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }

  /// Optimiza la URL si es de Cloudinary para reducir el consumo de memoria
  String _getOptimizedImageUrl(String url) {
    if (!url.contains('res.cloudinary.com')) return url;
    
    // Si ya tiene parámetros de transformación, no tocamos nada por seguridad
    if (url.contains('/upload/v') && !url.contains('/upload/q_auto,f_auto,w_800/')) {
      // Insertar optimización: calidad automática, formato automático y ancho máximo de 800px
      // Esto reduce drásticamente los errores de memoria en CanvasKit
      return url.replaceFirst('/upload/', '/upload/q_auto,f_auto,w_800/');
    }
    
    return url;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    final errorMsg = _processingResult?.error ?? 'No se pudo cargar la imagen.';

    return LayoutBuilder(
      builder: (context, constraints) {
        final double h = constraints.maxHeight;

        // Tamaños adaptativos para evitar overflow
        final double iconSize = (h * 0.5).clamp(20.0, 50.0);
        final bool showText = h >= 80;

        return widget.errorWidget ??
            Container(
              width: widget.width,
              height: widget.height,
              color: Colors.grey[200],
              padding: const EdgeInsets.all(4),
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FluentIcons.image_off_24_regular,
                        color: Colors.grey[400],
                        size: iconSize,
                      ),
                      if (showText) ...[
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            errorMsg,
                            style: TextStyle(
                              fontSize: (h * 0.12).clamp(8.0, 11.0),
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }

  Widget _buildErrorWithFallback(String url, dynamic error) {
    debugPrint('Error loading image: $url - Error: $error');

    // Debug detallado de la URL
    ImageDebugUtils.analyzeUrl(url);

    // Limpiar caché si está habilitado
    if (widget.clearCacheOnError) {
      _clearImageCache(url);
    }

    // Intentar con la siguiente URL de fallback
    if (_processingResult != null && _currentFallbackIndex < _processingResult!.fallbackUrls.length - 1) {
      _currentFallbackIndex++;
      final nextUrl = _processingResult!.fallbackUrls[_currentFallbackIndex];

      debugPrint(
          'Trying fallback URL ${_currentFallbackIndex + 1}/${_processingResult!.fallbackUrls.length}: $nextUrl');

      // Actualizar la URL actual y reconstruir
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _currentUrl = nextUrl;
          });
        }
      });

      return _buildPlaceholder();
    }

    // Si no hay más fallbacks, mostrar error
    return _buildErrorWidget();
  }

  void _clearImageCache(String url) {
    try {
      CachedNetworkImage.evictFromCache(url);
      debugPrint('Cleared cache for URL: $url');
    } catch (e) {
      debugPrint('Error clearing cache for $url: $e');
    }
  }
}
