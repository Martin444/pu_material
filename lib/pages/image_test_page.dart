import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../widgets/pu_robust_network_image.dart';
import '../utils/image_debug_utils.dart';

/// Página de prueba para diagnosticar problemas con carga de imágenes
class ImageTestPage extends StatefulWidget {
  const ImageTestPage({super.key});

  @override
  State<ImageTestPage> createState() => _ImageTestPageState();
}

class _ImageTestPageState extends State<ImageTestPage> {
  // URL problemática del error que mencionaste
  final String problematicUrl =
      'http://localhost:3000/api/image-proxy/image?url=http%3A%2F%2Fres.cloudinary.com%2Fphotographer%2Fimage%2Fupload%2Fv1752925600%2Fn7bqg0sjmhgmaz9y1jtx.jpg';

  // URL original extraída
  final String originalUrl = 'http://res.cloudinary.com/photographer/image/upload/v1752925600/n7bqg0sjmhgmaz9y1jtx.jpg';

  // URL de prueba conocida
  final String testUrl = 'https://res.cloudinary.com/photographer/image/upload/v1707588911/catito_wuzsen.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test de Imágenes'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'URL Problemática (Con Proxy)',
              problematicUrl,
              Colors.red.shade100,
            ),
            const SizedBox(height: 20),
            _buildSection(
              'URL Original (Sin Proxy)',
              originalUrl,
              Colors.orange.shade100,
            ),
            const SizedBox(height: 20),
            _buildSection(
              'URL de Prueba (Conocida)',
              testUrl,
              Colors.green.shade100,
            ),
            const SizedBox(height: 30),
            _buildDiagnosticSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String url, Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'URL: $url',
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: PuRobustNetworkImage(
              imageUrl: url,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text('Cargando...'),
                    ],
                  ),
                ),
              ),
              errorWidget: Container(
                color: Colors.red.shade100,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.error_circle_24_regular, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text('Error al cargar imagen'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosticSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Diagnóstico Detallado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ImageDebugUtils.buildDiagnosticWidget(problematicUrl),
          const Divider(height: 30),
          const Text(
            'Posibles Soluciones:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '1. Verificar que no haya un proxy/tunnel activo en puerto 3000\n'
            '2. Usar directamente las URLs de Cloudinary sin proxy\n'
            '3. Revisar configuración de red del desarrollo\n'
            '4. Limpiar caché de imágenes\n'
            '5. Verificar configuración de CORS en el servidor',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Analizar URL en logs
              ImageDebugUtils.analyzeUrl(problematicUrl);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Análisis completo en logs (Ver Debug Console)'),
                ),
              );
            },
            child: const Text('Ejecutar Análisis Completo'),
          ),
        ],
      ),
    );
  }
}
