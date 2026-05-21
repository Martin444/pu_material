/// Lightweight UI model for venues.
class VenueUiModel {
  final String id;
  final String name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? capacity;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VenueUiModel({
    required this.id,
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.capacity,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasLocation => latitude != null && longitude != null;

  String get locationDisplay {
    if (address != null && address!.isNotEmpty) return address!;
    if (hasLocation) return '$latitude, $longitude';
    return 'Ubicación no especificada';
  }
}
