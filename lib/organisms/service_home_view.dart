import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:pu_material/pu_material.dart';

class ServiceHomeView extends StatelessWidget {
  const ServiceHomeView({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 24.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: PUColors.bgItem,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: isMobile ? 8 : 16),
          Icon(
            FluentIcons.wrench_24_regular,
            size: 56,
            color: PUColors.iconColor,
          ),
          const SizedBox(height: 12),
          Text(
            'Área de Servicios',
            style: PuTextStyle.title2.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: PUColors.textColor3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Aquí podrás gestionar las tareas y solicitudes asignadas al equipo de servicio.',
            style: PuTextStyle.description1.copyWith(
              fontSize: 14,
              color: PUColors.textColor1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(FluentIcons.clipboard_task_list_ltr_24_regular),
            label: const Text('Ver solicitudes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: PUColors.bgButton,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
