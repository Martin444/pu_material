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

    // Validar que la URL sea válida
    if (!ImageDebugUtils.isValidImageUrl(url)) {
      print('Invalid URL: $url');
      return _buildErrorWidget();
    }

    // Intentar con diferentes estrategias
    return _buildMultiStrategyImage(url);
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
    // Lista de URLs a intentar (en orden de preferencia)
    final urlsToTry = <String>[];

    // Primero intentar con la URL original
    urlsToTry.add(url);

    // Si es un proxy, también intentar con la URL directa extraída
    if (url.contains('image-proxy') && url.contains('url=')) {
      try {
        final uri = Uri.parse(url);
        final encodedUrl = uri.queryParameters['url'];
        if (encodedUrl != null) {
          final directUrl = Uri.decodeComponent(encodedUrl);
          if (directUrl != url && !urlsToTry.contains(directUrl)) {
            urlsToTry.add(directUrl);
          }
        }
      } catch (e) {
        print('Error parsing proxy URL: $e');
      }
    }

    // Intentar cada URL en orden
    for (int i = 0; i < urlsToTry.length; i++) {
      final currentUrl = urlsToTry[i];
      print('Intentando cargar imagen (${i + 1}/${urlsToTry.length}): $currentUrl');

      try {
        return await _loadImageWithUrl(currentUrl);
      } catch (e) {
        print('Falló carga ${i + 1}/${urlsToTry.length} para $currentUrl: $e');

        // Si es el último intento, lanzar el error
        if (i == urlsToTry.length - 1) {
          rethrow;
        }
      }
    }

    throw Exception('No se pudo cargar ninguna URL de imagen');
  }

  Future<Widget> _loadImageWithUrl(String url) async {
    try {
      // Estrategia: Image.network con headers básicos
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
      print('Image loading failed for $url: $e');
      rethrow;
    }
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

  // Preprocesar URL para manejar URLs problemáticas
  String _preprocessUrl(String url) {
    // Si detectamos un proxy localhost, extraer la URL de Cloudinary directamente
    if (url.contains('localhost') && url.contains('image-proxy') && url.contains('url=')) {
      try {
        final uri = Uri.parse(url);
        final encodedUrl = uri.queryParameters['url'];
        if (encodedUrl != null) {
          final decodedUrl = Uri.decodeComponent(encodedUrl);
          print('Proxy localhost detectado, usando URL directa: $decodedUrl');
          return decodedUrl;
        }
      } catch (e) {
        print('Error extrayendo URL del proxy: $e');
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
        print('Error extrayendo URL del proxy API: $e');
      }
    }

    // Si la URL ya es una URL directa de Cloudinary, mantenerla
    if (url.contains('res.cloudinary.com')) {
      return url;
    }

    return url;
  }
}
