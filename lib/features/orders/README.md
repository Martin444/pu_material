# Orders Feature - Sistema de Órdenes

Este módulo implementa un sistema completo de visualización de órdenes siguiendo el patrón de diseño Atomic Design. Es totalmente responsive y escalable.

## Estructura

```
lib/features/orders/
├── models/
│   └── order.dart                      # Modelo de datos de orden
├── ui/
│   ├── atoms/                          # Componentes básicos
│   │   ├── badge.dart                  # Badge personalizado (OrderBadge)
│   │   ├── cell_text.dart              # Texto para celdas
│   │   ├── currency_text.dart          # Texto formateado de moneda
│   │   └── table_cell_atom.dart        # Celda básica de tabla
│   ├── molecules/                      # Componentes compuestos
│   │   ├── status_badge.dart           # Badge de estado con colores
│   │   └── order_compact_card.dart     # Tarjeta compacta para móvil
│   ├── organisms/                      # Componentes complejos
│   │   └── orders_table.dart           # Tabla responsive de órdenes
│   ├── templates/                      # Plantillas de página
│   │   └── orders_template.dart        # Template base
│   ├── pages/                          # Páginas completas
│   │   └── orders_page.dart            # Página principal
│   └── examples/                       # Ejemplos de uso
│       └── orders_example.dart         # Ejemplos de integración
└── utils/
    └── time_ago.dart                   # Utilidad para formatear fechas
```

## Características

### ✅ Responsive Design
- **Móvil (< 600px)**: Lista de tarjetas expandibles
- **Tablet (600-1024px)**: Tabla con columnas esenciales
- **Desktop (> 1024px)**: Tabla completa con todas las columnas

### ✅ Componentes Modulares
- Siguie el patrón Atomic Design
- Componentes reutilizables e independientes
- Fácil personalización y extensión

### ✅ Características Técnicas
- Scroll horizontal automático cuando es necesario
- Formateo automático de moneda (AR)
- Formateo relativo de fechas
- Estados de orden con colores específicos
- Accesibilidad mejorada

## Uso Básico

### Importar el módulo
```dart
import 'package:pu_material/pu_material.dart';
```

### Uso simple
```dart
class MyOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const OrdersPage(); // Página completa con datos de ejemplo
  }
}
```

### Uso personalizado
```dart
class CustomOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = [
      Order(
        numero: '001',
        detalle: 'Descripción del pedido...',
        estado: 'Pendiente',
        creado: DateTime.now(),
        alias: 'Cliente123',
        idCliente: 'Juan Pérez',
        totalCentavos: 150000, // $1,500.00
      ),
    ];

    return Scaffold(
      body: OrdersTable(data: orders),
    );
  }
}
```

## Componentes Individuales

### StatusBadge
```dart
StatusBadge('Pendiente')  // Amarillo
StatusBadge('En curso')   // Azul
StatusBadge('Completado') // Verde
StatusBadge('Cancelado')  // Rojo
```

### CurrencyText
```dart
CurrencyText(150000) // Muestra: $1.500,00
```

### OrderBadge (componente genérico)
```dart
OrderBadge(
  label: 'Custom',
  color: Colors.purple,
  textColor: Colors.white,
)
```

## Estados Soportados

- **Pendiente**: Color amarillo/ámbar
- **En curso**: Color azul
- **Completado**: Color verde
- **Cancelado**: Color rojo
- **Otros**: Color primario del tema

## Personalización

### Colores de Estado
Edita `StatusBadge._colorFor()` en `status_badge.dart`:

```dart
Color _colorFor(String s, BuildContext context) {
  switch (s.toLowerCase()) {
    case 'nuevo_estado':
      return Colors.purple.shade600;
    // ... otros casos
  }
}
```

### Columnas de Tabla
Modifica `OrdersTable._getColumns()` en `orders_table.dart` para agregar/quitar columnas:

```dart
// Nueva columna
yield ColumnDescriptor<Order>(
  id: 'nueva_columna',
  label: 'Nueva',
  minWidth: 100,
  cellBuilder: (context, order) => CellText('Valor'),
);
```

### Breakpoints
Ajusta los valores en `OrdersTable.build()`:

```dart
final isMobile = w < 768;  // Cambia de 600 a 768
final isDesktop = w >= 1200; // Nuevo breakpoint
```

## Extensiones Futuras

### 🔄 Ordenamiento
Agregar `Comparator<T>? sortBy` a `ColumnDescriptor` y manejar clics en headers.

### 🔍 Filtros
Implementar filtros por estado, fecha, cliente, etc.

### ✅ Selección
Agregar checkboxes para selección múltiple.

### 📱 Acciones
Implementar menús contextuales con acciones (ver, editar, cancelar).

### 🎨 Theming
Soporte completo para modo oscuro y temas personalizados.

### 📊 Paginación
Implementar paginación para grandes conjuntos de datos.

## Dependencias

- `flutter/material.dart`: Componentes UI
- `intl: ^0.19.0`: Formateo de moneda y fechas
- Fuentes: Sansation (Bold, Regular, Light)

## Notas de Desarrollo

- **OrderBadge vs Badge**: Se renombró para evitar conflictos con `Badge` de Flutter
- **Responsive**: La tabla se adapta automáticamente al ancho disponible
- **Performance**: Usa `ListView.builder` para listas grandes en móvil
- **Accesibilidad**: Incluye tooltips y semántica apropiada
