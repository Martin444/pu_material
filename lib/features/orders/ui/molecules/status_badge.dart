import 'package:flutter/material.dart';
import '../atoms/badge.dart';

/// Widget molecular para mostrar el estado de una orden con colores específicos
class StatusBadge extends StatelessWidget {
  final String estado;

  const StatusBadge(this.estado, {super.key});

  Color _colorFor(String s, BuildContext context) {
    switch (s.toLowerCase()) {
      case 'pendiente':
        return Colors.amber.shade700;
      case 'en curso':
        return Colors.blue.shade600;
      case 'completado':
        return Colors.green.shade700;
      case 'cancelado':
        return Colors.red.shade600;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _colorFor(estado, context);
    return OrderBadge(label: estado, color: c);
  }
}
