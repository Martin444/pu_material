import 'dart:isolate';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/image_debug_utils.dart';

// Clase para pasar datos al isolate
class ImageProcessingData {
  final String imageUrl;
  final SendPort sendPort;

  ImageProcessingData({
    required this.imageUrl,
    required this.sendPort,
  });
}

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

// Función que se ejecuta en el isolate para procesar URLs de imágenes
void imageProcessingIsolate(ImageProcessingData data) {
  try {
    // Limpiar URL
    final cleanedUrl = data.imageUrl.trim().replaceAll(RegExp(r'\s+'), '');

    // Procesar URL y generar fallbacks
    final processedUrl = _processUrlInIsolate(cleanedUrl);
    final fallbackUrls = _generateFallbackUrls(cleanedUrl);

    // Validar URL
    final isValid = _isValidUrlInIsolate(processedUrl);

    final result = ImageProcessingResult(
      processedUrl: processedUrl,
      fallbackUrls: fallbackUrls,
      isValid: isValid,
    );

    data.sendPort.send(result);
  } catch (e) {
    final result = ImageProcessingResult(
      processedUrl: data.imageUrl,
      fallbackUrls: [data.imageUrl],
      isValid: false,
      error: e.toString(),
    );
    data.sendPort.send(result);
  }
}

// Función helper para procesar URLs en isolate
String _processUrlInIsolate(String url) {
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

// Función helper para generar URLs de fallback
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

// Función helper para validar URLs en isolate
bool _isValidUrlInIsolate(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
  } catch (e) {
    return false;
  }
}

class PuRobustNetworkImageWithIsolate extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool clearCacheOnError;

  const PuRobustNetworkImageWithIsolate({
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
  State<PuRobustNetworkImageWithIsolate> createState() => _PuRobustNetworkImageWithIsolateState();
}

class _PuRobustNetworkImageWithIsolateState extends State<PuRobustNetworkImageWithIsolate> {
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
  void didUpdateWidget(PuRobustNetworkImageWithIsolate oldWidget) {
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
      // Crear ReceivePort para recibir datos del isolate
      final receivePort = ReceivePort();

      // Crear el isolate
      final isolate = await Isolate.spawn(
        imageProcessingIsolate,
        ImageProcessingData(
          imageUrl: widget.imageUrl,
          sendPort: receivePort.sendPort,
        ),
      );

      // Escuchar el resultado con un timeout
      final result = await receivePort.first.timeout(
        const Duration(seconds: 5),
        onTimeout: () => ImageProcessingResult(
          processedUrl: widget.imageUrl,
          fallbackUrls: [widget.imageUrl],
          isValid: true,
          error: 'Processing timeout',
        ),
      ) as ImageProcessingResult;

      // Limpiar el isolate
      isolate.kill(priority: Isolate.immediate);
      receivePort.close();

      if (mounted) {
        setState(() {
          _processingResult = result;
          _currentUrl = result.processedUrl;
          _isProcessing = false;
        });
      }
    } catch (e) {
      debugPrint('Error processing image URL in isolate: $e');
      if (mounted) {
        setState(() {
          _processingResult = ImageProcessingResult(
            processedUrl: widget.imageUrl,
            fallbackUrls: [widget.imageUrl],
            isValid: true, // Asumir válida para intentar cargar
            error: e.toString(),
          );
          _currentUrl = widget.imageUrl;
          _isProcessing = false;
        });
      }
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
    return CachedNetworkImage(
      imageUrl: _currentUrl!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.cover,
      placeholder: (context, url) => widget.placeholder ?? _buildPlaceholder(),
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
      width: widget.width,
      height: widget.height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return widget.errorWidget ??
        Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey[300],
          child: const Icon(
            FluentIcons.image_off_24_regular,
            color: Colors.grey,
            size: 50,
          ),
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
