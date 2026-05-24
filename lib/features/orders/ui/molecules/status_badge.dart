import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/ui/atoms/badge.dart' as atoms;

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge(this.status);

  Color get _color {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'confirmado':
        return Colors.blue;
      case 'processing':
      case 'en curso':
        return Colors.orange;
      case 'shipped':
      case 'enviado':
        return Colors.indigo;
      case 'delivered':
      case 'entregado':
      case 'completed':
      case 'completado':
        return Colors.green;
      case 'pending':
      case 'pendiente':
        return Colors.amber;
      case 'cancelled':
      case 'cancelado':
        return Colors.red;
      case 'failed':
      case 'fallido':
        return Colors.red.shade700;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) => atoms.Badge(label: status, color: _color);
}