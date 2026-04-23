import 'package:flutter/material.dart';
import '../../../../utils/pu_colors.dart';
import '../atoms/badge.dart';

/// Widget molecular para mostrar el estado de una orden con colores específicos
class StatusBadge extends StatelessWidget {
  final String estado;

  const StatusBadge(this.estado, {super.key});

  Color _colorFor(String s, BuildContext context) {
    switch (s.toLowerCase()) {
      case 'pendiente':
        return const Color(0xFFD97706); // Amber-600
      case 'en curso':
        return const Color(0xFF2563EB); // Royal Blue
      case 'completado':
        return const Color(0xFF059669); // Emerald-600
      case 'cancelado':
        return const Color(0xFFDC2626); // Red-600
      case 'confirmado':
      case 'confirmed':
        return const Color(0xFF4F46E5); // Indigo-600
      default:
        return PUColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _colorFor(estado, context);
    return OrderBadge(label: estado, color: c);
  }
}
