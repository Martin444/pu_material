# PuRobustNetworkImage - Widget para Carga de Imágenes con Isolates

Este proyecto utiliza **isolates por defecto** para el procesamiento de URLs de imágenes, optimizando el rendimiento y evitando bloqueos en el hilo principal de UI.

## PuRobustNetworkImage (Con Isolates por Defecto)
**Archivo:** `pu_material/lib/widgets/pu_robust_network_image.dart`

### Características:
- ✅ Procesamiento asíncrono en isolate separado
- ✅ **No bloquea el hilo principal de UI**
- ✅ Detección automática de proxies (localhost y Heroku)
- ✅ Extracción automática de URLs directas de Cloudinary
- ✅ Sistema de fallback automático
- ✅ Limpieza de caché en errores
- ✅ Headers HTTP optimizados
- ✅ Timeout de 5 segundos para procesamiento
- ✅ Fallback automático si el isolate falla
- ✅ **Optimizado para aplicaciones con muchas imágenes**

### Uso:
```dart
import 'package:pu_material/widgets/pu_robust_network_image.dart';

PuRobustNetworkImage(
  imageUrl: 'https://menucom-api-60e608ae2f99.herokuapp.com/image-proxy?url=...',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
  clearCacheOnError: true,
  placeholder: CircularProgressIndicator(),
  errorWidget: Icon(Icons.error),
)
```

### Beneficios de Usar Isolates:
- ✅ **UI siempre responsiva**: El procesamiento de URLs no bloquea la interfaz
- ✅ **Mejor rendimiento**: Especialmente en listas largas con muchas imágenes
- ✅ **Procesamiento en paralelo**: Múltiples imágenes se procesan simultáneamente
- ✅ **Manejo robusto de errores**: Si el isolate falla, usa fallback automático


## Versión Alternativa: PuRobustNetworkImageWithIsolate
**Archivo:** `pu_material/lib/widgets/pu_robust_network_image_isolate.dart`

Si quieres usar una versión con nombre específico para isolates, también está disponible `PuRobustNetworkImageWithIsolate` con exactamente la misma funcionalidad.

```dart
import 'package:pu_material/widgets/pu_robust_network_image_isolate.dart';

PuRobustNetworkImageWithIsolate(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
)
```

## Configuraciones Recomendadas

### Para Desarrollo:
```dart
PuRobustNetworkImage(
  imageUrl: imageUrl,
  clearCacheOnError: true, // Limpia caché en desarrollo
  // ... otros parámetros
)
```

### Para Producción:
```dart
PuRobustNetworkImage(
  imageUrl: imageUrl,
  clearCacheOnError: false, // Mantiene caché en producción
  // ... otros parámetros
)
```

## Solución de Problemas Comunes

### Error: `The method 'PuRobustNetworkImage' isn't defined`
1. Verifica que el import sea correcto:
   ```dart
   import 'package:pu_material/widgets/pu_robust_network_image.dart';
   ```

2. O usa el import general de pu_material:
   ```dart
   import 'package:pu_material/pu_material.dart';
   ```

3. Asegúrate de que `pu_material` esté en el `pubspec.yaml`

### URLs de Proxy no funcionan
El widget detecta automáticamente URLs de proxy y las convierte a URLs directas:
- ✅ `localhost:3000/image-proxy?url=...`
- ✅ `menucom-api-60e608ae2f99.herokuapp.com/image-proxy?url=...`

### Imágenes no cargan
1. Verifica la URL en logs de consola
2. El widget intentará automáticamente con URLs de fallback
3. Revisa que `clearCacheOnError: true` esté configurado durante desarrollo

### Monitoreo del Rendimiento de Isolates
Puedes ver en la consola:
```
Processing image URL in isolate: <URL>
Isolate processing completed in: <tiempo>ms
Fallback to main thread due to isolate timeout
```

## Exports en pu_material.dart

El widget principal está exportado en `pu_material/lib/pu_material.dart`:
```dart
export 'package:pu_material/widgets/pu_robust_network_image.dart';
```

## Migración Completa a Isolates ✅

**Estado actual**: Todas las imágenes en la aplicación ahora usan isolates por defecto.

- ✅ `menu_tile.dart` - Usa PuRobustNetworkImage con isolates
- ✅ `clothing_tile.dart` - Usa PuRobustNetworkImage con isolates  
- ✅ `owner_info_widget.dart` - Usa PuRobustNetworkImage con isolates
- ✅ `cart_tile.dart` - Usa PuRobustNetworkImage con isolates

**Beneficio**: La UI permanece responsiva incluso con muchas imágenes cargando simultáneamente.
