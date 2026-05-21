import 'package:flutter/material.dart';
import '../../models/event_ui_model.dart';
import '../molecules/event_card_molecule.dart';

class EventListOrganism extends StatelessWidget {
  final List<EventUiModel> events;
  final Function(EventUiModel) onEventTap;
  final Function(EventUiModel)? onEventEdit;
  final Function(EventUiModel)? onEventDelete;
  final bool isLoading;

  const EventListOrganism({
    super.key,
    required this.events,
    required this.onEventTap,
    this.onEventEdit,
    this.onEventDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (events.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay eventos',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Crea tu primer evento para comenzar',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final isTablet = constraints.maxWidth > 768;

        if (isDesktop) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCardMolecule(
                event: event,
                onTap: () => onEventTap(event),
                onEdit: onEventEdit != null ? () => onEventEdit!(event) : null,
                onDelete: onEventDelete != null ? () => onEventDelete!(event) : null,
              );
            },
          );
        }

        if (isTablet) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCardMolecule(
                event: event,
                onTap: () => onEventTap(event),
                onEdit: onEventEdit != null ? () => onEventEdit!(event) : null,
                onDelete: onEventDelete != null ? () => onEventDelete!(event) : null,
              );
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EventCardMolecule(
                event: event,
                onTap: () => onEventTap(event),
                onEdit: onEventEdit != null ? () => onEventEdit!(event) : null,
                onDelete: onEventDelete != null ? () => onEventDelete!(event) : null,
              ),
            );
          },
        );
      },
    );
  }
}
