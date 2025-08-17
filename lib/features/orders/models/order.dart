/// Modelo de datos para una orden
class Order {
  final String numero; // "01"
  final String detalle; // "1 Rompe vientos, 2 Air box, 3 R..."
  final String estado; // "Pendiente" | "En curso" | "Completado" | etc.
  final DateTime creado; // timestamp real
  final String alias; // "Juan pedro2020"
  final String idCliente; // "Martín"
  final int totalCentavos; // 38232 * 100 o la representación que uses

  const Order({
    required this.numero,
    required this.detalle,
    required this.estado,
    required this.creado,
    required this.alias,
    required this.idCliente,
    required this.totalCentavos,
  });

  /// Factory constructor para crear una orden de ejemplo
  factory Order.example({
    String? numero,
    String? detalle,
    String? estado,
    DateTime? creado,
    String? alias,
    String? idCliente,
    int? totalCentavos,
  }) {
    return Order(
      numero: numero ?? "01",
      detalle: detalle ?? "1 Rompe vientos, 2 Air box, 3 R...",
      estado: estado ?? "Pendiente",
      creado: creado ?? DateTime.now(),
      alias: alias ?? "Juan pedro2020",
      idCliente: idCliente ?? "Martín",
      totalCentavos: totalCentavos ?? 3823200,
    );
  }

  @override
  String toString() {
    return 'Order(numero: $numero, estado: $estado, alias: $alias, totalCentavos: $totalCentavos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order &&
        other.numero == numero &&
        other.detalle == detalle &&
        other.estado == estado &&
        other.creado == creado &&
        other.alias == alias &&
        other.idCliente == idCliente &&
        other.totalCentavos == totalCentavos;
  }

  @override
  int get hashCode {
    return numero.hashCode ^
        detalle.hashCode ^
        estado.hashCode ^
        creado.hashCode ^
        alias.hashCode ^
        idCliente.hashCode ^
        totalCentavos.hashCode;
  }
}
