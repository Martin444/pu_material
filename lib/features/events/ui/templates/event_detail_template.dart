import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event_ui_model.dart';
import '../../models/ticket_type_ui_model.dart';

class EventDetailTemplate extends StatelessWidget {
  final EventUiModel? event;
  final List<TicketTypeUiModel> ticketTypes;
  final bool isLoading;
  final bool isUpdatingStatus;
  final VoidCallback onBack;
  final VoidCallback onRefresh;
  final VoidCallback onPublish;
  final VoidCallback onCancel;
  final VoidCallback onDelete;
  final Function(TicketTypeUiModel)? onDeleteTicketType;

  const EventDetailTemplate({
    super.key,
    this.event,
    required this.ticketTypes,
    required this.isLoading,
    required this.isUpdatingStatus,
    required this.onBack,
    required this.onRefresh,
    required this.onPublish,
    required this.onCancel,
    required this.onDelete,
    this.onDeleteTicketType,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || event == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final ev = event!;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ev.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
          actions: [
            if (isUpdatingStatus)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  ),
                ),
              )
            else ...[
              if (ev.status == 'draft')
                IconButton(
                  icon: const Icon(Icons.publish),
                  tooltip: 'Publicar',
                  onPressed: onPublish,
                ),
              if (ev.status == 'published')
                IconButton(
                  icon: const Icon(Icons.cancel),
                  tooltip: 'Cancelar',
                  onPressed: onCancel,
                ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Eliminar',
                onPressed: onDelete,
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Actualizar',
                onPressed: onRefresh,
              ),
            ],
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info), text: 'Info'),
              Tab(icon: Icon(Icons.confirmation_number), text: 'Tickets'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInfoTab(ev, dateFormat),
            _buildTicketsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(EventUiModel ev, DateFormat dateFormat) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusChip(ev.status),
          const SizedBox(height: 16),
          if (ev.description != null && ev.description!.isNotEmpty) ...[
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(ev.description!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
          ],
          _buildInfoRow(Icons.calendar_today, 'Inicio', dateFormat.format(ev.startDate)),
          _buildInfoRow(Icons.calendar_today, 'Fin', dateFormat.format(ev.endDate)),
          _buildInfoRow(Icons.place, 'Venue ID', ev.venueId),
          _buildInfoRow(Icons.access_time, 'Creado', dateFormat.format(ev.createdAt)),
          _buildInfoRow(Icons.update, 'Actualizado', dateFormat.format(ev.updatedAt)),
        ],
      ),
    );
  }

  Widget _buildTicketsTab() {
    if (ticketTypes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No hay tipos de tickets', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: ticketTypes.length,
      itemBuilder: (context, index) {
        final t = ticketTypes[index];
        return Card(
          child: ListTile(
            title: Text(t.name),
            subtitle: Text(
              '${t.formattedPrice} · ${t.remainingQuantity} disponibles',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: t.isSoldOut ? Colors.red[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    t.isSoldOut ? 'Agotado' : 'Activo',
                    style: TextStyle(
                      color: t.isSoldOut ? Colors.red : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (onDeleteTicketType != null)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                    onPressed: () => onDeleteTicketType!(t),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text(value, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;
    switch (status) {
      case 'published':
        color = Colors.green;
        label = 'Publicado';
        break;
      case 'draft':
        color = Colors.orange;
        label = 'Borrador';
        break;
      case 'cancelled':
        color = Colors.red;
        label = 'Cancelado';
        break;
      case 'completed':
        color = Colors.grey;
        label = 'Finalizado';
        break;
      default:
        color = Colors.blue;
        label = status;
    }
    return Chip(
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color),
      label: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
