/// Lightweight UI model for events.
class EventUiModel {
  final String id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? imageUrl;
  final String venueId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EventUiModel({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    required this.venueId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isDraft => status == 'draft';
  bool get isPublished => status == 'published';
  bool get isCancelled => status == 'cancelled';
  bool get hasEnded => DateTime.now().isAfter(endDate);
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
  bool get isUpcoming => DateTime.now().isBefore(startDate);
}
