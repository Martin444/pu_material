import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/image_debug_utils.dart';

class PuRobustNetworkImage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Verificar si la URL es válida
    if (imageUrl.isEmpty) {
      print('Empty URL provided');
      return _buildErrorWidget();
    }

    final cleanedUrl = _cleanUrl(imageUrl);
    final processedUrl = _preprocessUrl(cleanedUrl);

    if (!_isValidUrl(processedUrl)) {
      print('Invalid URL after processing: $processedUrl');
      return _buildErrorWidget();
    }

    return CachedNetworkImage(
      imageUrl: processedUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => placeholder ?? _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWithFallback(url, error),
      httpHeaders: const {
        'User-Agent': 'Flutter App',
        'Accept': 'image/*',
        'Cache-Control': 'no-cache',
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      maxHeightDiskCache: 1000,
      maxWidthDiskCache: 1000,
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 50,
          ),
        );
  }

  Widget _buildErrorWithFallback(String url, dynamic error) {
    print('Error loading image: $url - Error: $error');

    // Debug detallado de la URL usando utilidades
    ImageDebugUtils.analyzeUrl(url);

    // Limpiar caché si está habilitado
    if (clearCacheOnError) {
      _clearImageCache(url);
    }

    // Extraer URL original si está usando proxy
    String originalUrl = _extractOriginalUrl(url);

    // Validar que la URL original sea válida
    if (!ImageDebugUtils.isValidImageUrl(originalUrl)) {
      print('Invalid URL after extraction: $originalUrl');
      return _buildErrorWidget();
    }

    // Si tenemos una URL diferente (sin proxy), intentar cargarla
    if (originalUrl != url) {
      print('Attempting fallback with original URL: $originalUrl');
      return _buildMultiStrategyImage(originalUrl);
    }

    // Si la URL original es la misma, intentar con diferentes estrategias
    return _buildMultiStrategyImage(originalUrl);
  }

  void _clearImageCache(String url) {
    try {
      CachedNetworkImage.evictFromCache(url);
      print('Cleared cache for URL: $url');
    } catch (e) {
      print('Error clearing cache for $url: $e');
    }
  }

  Widget _buildMultiStrategyImage(String url) {
    return FutureBuilder<Widget>(
      future: _attemptImageLoad(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        }

        if (snapshot.hasData) {
          return snapshot.data!;
        }

        return _buildErrorWidget();
      },
    );
  }

  Future<Widget> _attemptImageLoad(String url) async {
    try {
      // Estrategia 1: Image.network con headers básicos
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        headers: const {
          'User-Agent': 'Flutter App',
          'Accept': 'image/*',
        },
        errorBuilder: (context, error, stackTrace) {
          print('Image.network failed for $url: $error');
          throw error;
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
      );
    } catch (e) {
      print('All image loading strategies failed for $url: $e');
      rethrow;
    }
  }

  // Extraer la URL original si está usando proxy
  String _extractOriginalUrl(String proxyUrl) {
    try {
      final uri = Uri.parse(proxyUrl);
      if (uri.queryParameters.containsKey('url')) {
        return Uri.decodeComponent(uri.queryParameters['url']!);
      }
    } catch (e) {
      print('Error extracting original URL: $e');
    }
    return proxyUrl;
  }

  // Validar si una URL es válida
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Limpiar URL removiendo espacios y caracteres extraños
  String _cleanUrl(String url) {
    return url.trim().replaceAll(RegExp(r'\s+'), '');
  }

  // Preprocesar URL para manejar proxies y URLs problemáticas
  String _preprocessUrl(String url) {
    // Si detectamos un proxy localhost, extraer la URL original inmediatamente
    if (url.contains('localhost') && url.contains('image-proxy')) {
      print('Detected localhost proxy URL, extracting original: $url');
      String extracted = _extractOriginalUrl(url);
      print('Extracted URL: $extracted');
      return extracted;
    }

    // Si la URL ya es una URL directa de Cloudinary, mantenerla
    if (url.contains('res.cloudinary.com')) {
      return url;
    }

    return url;
  }
}
