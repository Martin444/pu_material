import 'package:flutter/material.dart';
import '../../models/event_ui_model.dart';
import '../organisms/event_list_organism.dart';

class EventsDashboardTemplate extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<EventUiModel> events;
  final VoidCallback onRetry;
  final VoidCallback onCreateEvent;
  final Function(EventUiModel) onEventTap;
  final Function(EventUiModel)? onEventEdit;
  final Function(EventUiModel)? onEventDelete;

  const EventsDashboardTemplate({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.events,
    required this.onRetry,
    required this.onCreateEvent,
    required this.onEventTap,
    this.onEventEdit,
    this.onEventDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gestión de Eventos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ElevatedButton.icon(
                onPressed: onCreateEvent,
                icon: const Icon(Icons.add),
                label: const Text('Crear Evento'),
              ),
            ],
          ),
        ),
        if (errorMessage != null && errorMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(child: Text(errorMessage!)),
                    TextButton(onPressed: onRetry, child: const Text('Reintentar')),
                  ],
                ),
              ),
            ),
          ),
        Expanded(
          child: EventListOrganism(
            events: events,
            onEventTap: onEventTap,
            onEventEdit: onEventEdit,
            onEventDelete: onEventDelete,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
