import 'package:flutter/material.dart';

/// Utilidades para debugging de problemas con carga de imágenes
class ImageDebugUtils {
  /// Analiza una URL y proporciona información detallada sobre su estructura
  static void analyzeUrl(String url) {
    debugPrint('=== ANÁLISIS DETALLADO DE URL ===');
    debugPrint('URL Original: $url');
    debugPrint('Longitud: ${url.length}');
    debugPrint('Está vacía: ${url.isEmpty}');
    debugPrint('Contiene espacios: ${url.contains(' ')}');
    debugPrint('Contiene proxy: ${url.contains('image-proxy')}');
    debugPrint('Contiene localhost: ${url.contains('localhost')}');
    debugPrint('Es Cloudinary: ${url.contains('res.cloudinary.com')}');

    if (url.contains('localhost')) {
      debugPrint('⚠️  PROBLEMA DETECTADO: URL contiene localhost');
      debugPrint('   Esto indica que hay un proxy local interceptando las imágenes');
    }

    try {
      final uri = Uri.parse(url);
      debugPrint('Esquema: ${uri.scheme}');
      debugPrint('Host: ${uri.host}');
      debugPrint('Puerto: ${uri.port}');
      debugPrint('Ruta: ${uri.path}');

      if (uri.queryParameters.isNotEmpty) {
        debugPrint('Parámetros de consulta:');
        uri.queryParameters.forEach((key, value) {
          debugPrint('  $key: $value');
          if (key == 'url') {
            debugPrint('  📎 URL decodificada: ${Uri.decodeComponent(value)}');
          }
        });
      }
    } catch (e) {
      debugPrint('❌ Error parseando URI: $e');
    }

    debugPrint('=== FIN ANÁLISIS ===\n');
  }

  /// Intenta extraer la URL original de una URL de proxy
  static String extractOriginalUrl(String proxyUrl) {
    try {
      final uri = Uri.parse(proxyUrl);
      if (uri.queryParameters.containsKey('url')) {
        String original = Uri.decodeComponent(uri.queryParameters['url']!);
        debugPrint('✅ URL original extraída: $original');
        return original;
      }
    } catch (e) {
      debugPrint('❌ Error extrayendo URL original: $e');
    }
    return proxyUrl;
  }

  /// Valida si una URL es válida para carga de imágenes
  static bool isValidImageUrl(String url) {
    if (url.isEmpty) {
      debugPrint('❌ URL vacía');
      return false;
    }

    try {
      final uri = Uri.parse(url);

      if (!uri.hasScheme) {
        debugPrint('❌ URL sin esquema: $url');
        return false;
      }

      if (uri.scheme != 'http' && uri.scheme != 'https') {
        debugPrint('❌ Esquema inválido (${uri.scheme}): $url');
        return false;
      }

      if (uri.host.isEmpty) {
        debugPrint('❌ Host vacío: $url');
        return false;
      }

      if (uri.host == 'localhost' || uri.host == '127.0.0.1') {
        debugPrint('⚠️  URL apunta a localhost: $url');
        debugPrint('   Esto puede causar problemas en producción');
      }

      debugPrint('✅ URL válida: $url');
      return true;
    } catch (e) {
      debugPrint('❌ Error validando URL: $e');
      return false;
    }
  }

  /// Widget de prueba para diagnosticar problemas de carga de imágenes
  static Widget buildDiagnosticWidget(String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Diagnóstico para: $imageUrl', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FutureBuilder<void>(
          future: Future.delayed(Duration.zero, () => analyzeUrl(imageUrl)),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Válida: ${isValidImageUrl(imageUrl) ? "✅" : "❌"}'),
                Text('Tipo: ${_getUrlType(imageUrl)}'),
                if (imageUrl.contains('localhost'))
                  const Text('⚠️ Contiene localhost - Posible problema de proxy',
                      style: TextStyle(color: Colors.orange)),
                if (imageUrl.contains('image-proxy'))
                  Text('🔄 Proxy detectado - URL original: ${extractOriginalUrl(imageUrl)}'),
              ],
            );
          },
        ),
      ],
    );
  }

  static String _getUrlType(String url) {
    if (url.contains('res.cloudinary.com')) return 'Cloudinary';
    if (url.contains('localhost')) return 'Localhost/Desarrollo';
    if (url.contains('image-proxy')) return 'Proxy';
    if (url.startsWith('data:')) return 'Data URL';
    return 'URL estándar';
  }
}
