import 'package:pu_material/utils/formaters/currency_converter.dart';

/// Lightweight UI model for ticket types.
class TicketTypeUiModel {
  final String id;
  final String eventId;
  final String name;
  final double price;
  final int totalQuantity;
  final int soldQuantity;
  final DateTime saleStartDate;
  final DateTime saleEndDate;
  final int maxPerUser;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TicketTypeUiModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.price,
    required this.totalQuantity,
    this.soldQuantity = 0,
    required this.saleStartDate,
    required this.saleEndDate,
    required this.maxPerUser,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  int get remainingQuantity => totalQuantity - soldQuantity;
  bool get isSoldOut => remainingQuantity <= 0;
  bool get isOnSale {
    final now = DateTime.now();
    return now.isAfter(saleStartDate) &&
        now.isBefore(saleEndDate) &&
        !isSoldOut &&
        status == 'active';
  }

  String get formattedPrice => price.toCurrency();
  double get soldPercentage =>
      totalQuantity > 0 ? soldQuantity / totalQuantity : 0.0;
}
