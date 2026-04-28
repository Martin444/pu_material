class CartItemModel {
  final String? id;
  final String? photoUrl;
  final String? name;
  final double? price;
  final int? quantity;
  final int? deliveryTime;

  CartItemModel({
    this.id,
    this.photoUrl,
    this.name,
    this.price,
    this.quantity,
    this.deliveryTime,
  });

  CartItemModel copyWith({
    String? id,
    String? photoUrl,
    String? name,
    double? price,
    int? quantity,
    int? deliveryTime,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  // Método para convertir una instancia de CartItemModel en un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoURL': photoUrl,
      'name': name,
      'price': price,
      'quantity': quantity,
      'deliveryTime': deliveryTime,
    };
  }

  // Método para convertir un mapa (JSON) en una instancia de CartItemModel
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String?,
      photoUrl: json['photoURL'] as String?,
      name: json['name'] as String?,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      quantity: json['quantity'] as int?,
      deliveryTime: json['deliveryTime'] as int?,
    );
  }
}
