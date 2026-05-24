class Order {
  final String numero;
  final String detalle;
  final String estado;
  final DateTime created;
  final String alias;
  final String idCliente;
  final int totalCentavos;
  final String? paymentUrl;
  final String? customerEmail;
  final String? customerPhone;
  final String? operationId;
  final List<OrderItem> fullItems;

  // Nuevos campos de transparencia
  final String statusRaw;
  final int subtotalCentavos;
  final double marketplaceFeePercentage;
  final int marketplaceFeeAmountCentavos;
  final int? mpProcessingFeeCentavos;
  final int? netAmountCentavos;
  final String? paymentStatus;

  Order({
    required this.numero,
    required this.detalle,
    required this.estado,
    required this.created,
    required this.alias,
    required this.idCliente,
    required this.totalCentavos,
    this.paymentUrl,
    this.customerEmail,
    this.customerPhone,
    this.operationId,
    this.fullItems = const [],
    this.statusRaw = '',
    this.subtotalCentavos = 0,
    this.marketplaceFeePercentage = 0,
    this.marketplaceFeeAmountCentavos = 0,
    this.mpProcessingFeeCentavos,
    this.netAmountCentavos,
    this.paymentStatus,
  });

  factory Order.example() {
    return Order(
      numero: '01',
      detalle: '2x Hamburguesa, 1x Papa Frita, 1x Gaseosa',
      estado: 'Pendiente',
      created: DateTime(2024, 1, 15),
      alias: 'Juan',
      idCliente: 'juan@email.com',
      totalCentavos: 3823200,
    );
  }
}

class OrderItem {
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}