import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pu_material/pu_material.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';
import '../../models/venue_ui_model.dart';

class EventCreateTemplate extends StatelessWidget {
  final int currentStep;
  final bool isLoading;
  final String? errorMessage;

  // Step 1 controllers
  final TextEditingController nameController;
  final String? nameError;
  final TextEditingController descriptionController;
  final Uint8List? selectedImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final DateTime? startDate;
  final String? startDateError;
  final DateTime? endDate;
  final String? endDateError;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;

  // Step 2 controllers
  final List<VenueUiModel> venues;
  final String? selectedVenueId;
  final String? selectedVenueError;
  final Function(String?) onSelectVenue;
  final TextEditingController venueNameController;
  final TextEditingController venueAddressController;
  final TextEditingController venueCapacityController;
  final bool isCreatingVenue;
  final VoidCallback onCreateVenue;

  // Step 3 controllers
  final List<Map<String, dynamic>> ticketTypesDraft;
  final TextEditingController ticketNameController;
  final String? ticketNameError;
  final TextEditingController ticketPriceController;
  final String? ticketPriceError;
  final TextEditingController ticketQuantityController;
  final String? ticketQuantityError;
  final TextEditingController ticketMaxPerUserController;
  final DateTime? ticketSaleStart;
  final DateTime? ticketSaleEnd;
  final String? ticketSaleError;
  final VoidCallback onPickTicketSaleStart;
  final VoidCallback onPickTicketSaleEnd;
  final VoidCallback onAddTicketType;
  final Function(int) onRemoveTicketType;

  final VoidCallback onNextStep;
  final VoidCallback onPreviousStep;
  final VoidCallback onSubmit;
  final VoidCallback onClose;

  const EventCreateTemplate({
    super.key,
    required this.currentStep,
    required this.isLoading,
    this.errorMessage,
    required this.nameController,
    this.nameError,
    required this.descriptionController,
    this.selectedImage,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.startDate,
    this.startDateError,
    required this.endDate,
    this.endDateError,
    required this.onPickStartDate,
    required this.onPickEndDate,
    required this.venues,
    required this.selectedVenueId,
    this.selectedVenueError,
    required this.onSelectVenue,
    required this.venueNameController,
    required this.venueAddressController,
    required this.venueCapacityController,
    required this.isCreatingVenue,
    required this.onCreateVenue,
    required this.ticketTypesDraft,
    required this.ticketNameController,
    this.ticketNameError,
    required this.ticketPriceController,
    this.ticketPriceError,
    required this.ticketQuantityController,
    this.ticketQuantityError,
    required this.ticketMaxPerUserController,
    required this.ticketSaleStart,
    required this.ticketSaleEnd,
    this.ticketSaleError,
    required this.onPickTicketSaleStart,
    required this.onPickTicketSaleEnd,
    required this.onAddTicketType,
    required this.onRemoveTicketType,
    required this.onNextStep,
    required this.onPreviousStep,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Evento'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Stepper(
                    currentStep: currentStep,
                    onStepContinue: onNextStep,
                    onStepCancel: onPreviousStep,
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            if (currentStep < 2)
                              ButtonPrimary(
                                title: 'Siguiente',
                                onPressed: details.onStepContinue,
                                load: false,
                              )
                            else
                              ButtonPrimary(
                                title: 'Crear Evento',
                                onPressed: onSubmit,
                                load: false,
                              ),
                            if (currentStep > 0) ...[
                              const SizedBox(width: 12),
                              ButtonSecundary(
                                title: 'Atrás',
                                onPressed: details.onStepCancel,
                                load: false,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                    steps: [
                      Step(
                        title: const Text('Información Básica'),
                        isActive: currentStep >= 0,
                        state: currentStep > 0 ? StepState.complete : StepState.indexed,
                        content: _buildStep1(dateFormat),
                      ),
                      Step(
                        title: const Text('Venue'),
                        isActive: currentStep >= 1,
                        state: currentStep > 1 ? StepState.complete : StepState.indexed,
                        content: _buildStep2(),
                      ),
                      Step(
                        title: const Text('Tipos de Tickets'),
                        isActive: currentStep >= 2,
                        state: StepState.indexed,
                        content: _buildStep3(dateFormat),
                      ),
                    ],
                  ),
                ),
                if (errorMessage != null && errorMessage!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildStep1(DateFormat dateFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PUInput(
          controller: nameController,
          labelText: 'Nombre del evento *',
          hintText: 'Ej: Concierto de Rock',
          errorText: nameError,
        ),
        const SizedBox(height: 12),
        PUInput(
          controller: descriptionController,
          labelText: 'Descripción',
          hintText: 'Describe tu evento...',
          maxLines: 3,
          minLines: 3,
        ),
        const SizedBox(height: 12),
        _buildImagePicker(),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PUInput(
                controller: TextEditingController(
                  text: startDate != null ? dateFormat.format(startDate!) : '',
                ),
                labelText: 'Fecha de inicio *',
                hintText: 'Seleccionar...',
                readOnly: true,
                onTap: onPickStartDate,
                errorText: startDateError,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PUInput(
                controller: TextEditingController(
                  text: endDate != null ? dateFormat.format(endDate!) : '',
                ),
                labelText: 'Fecha de fin *',
                hintText: 'Seleccionar...',
                readOnly: true,
                onTap: onPickEndDate,
                errorText: endDateError,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Banner del evento',
          style: PuTextStyle.description1.copyWith(
            color: PUColors.textColorMuted,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        if (selectedImage != null) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  selectedImage!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onRemoveImage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(4),
                  ),
                ),
              ),
            ],
          ),
        ] else ...[
          GestureDetector(
            onTap: onPickImage,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: PUColors.bgInput,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: PUColors.borderInputColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: PUColors.textColor3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tocá para subir una imagen',
                    style: PuTextStyle.description1.copyWith(
                      color: PUColors.textColor3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'JPG, PNG (máx. 5MB)',
                    style: PuTextStyle.description1.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStep2() {
    final selectedVenue = selectedVenueId != null
        ? venues.where((v) => v.id == selectedVenueId).firstOrNull
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Venues existentes ──
        if (venues.isNotEmpty) ...[
          Text(
            'Tus venues',
            style: PuTextStyle.title5.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          PUInputDropDown<String>(
            label: 'Seleccioná un venue',
            hintText: 'Elegir venue...',
            errorText: selectedVenueError,
            initialItem: selectedVenueId,
            items: venues.map((v) {
              return DropdownMenuItem(
                value: v.id,
                child: Text(
                  v.address != null && v.address!.isNotEmpty
                      ? '${v.name} - ${v.address}'
                      : v.name,
                ),
              );
            }).toList(),
            onSelect: (value) => onSelectVenue(value),
          ),
          if (selectedVenue != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '"${selectedVenue.name}" seleccionado. Podés continuar al siguiente paso.',
                      style: PuTextStyle.description1.copyWith(
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(color: PUColors.borderInputColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '¿No encontrás tu venue?',
                  style: PuTextStyle.description1.copyWith(
                    color: PUColors.textColor3,
                  ),
                ),
              ),
              Expanded(child: Divider(color: PUColors.borderInputColor)),
            ],
          ),
          const SizedBox(height: 16),
        ] else ...[
          // ── Sin venues: explicar por qué crea uno ──
          Text(
            'Creá el venue para tu evento',
            style: PuTextStyle.title5.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'El venue es el lugar donde se realizará el evento. Podés reutilizarlo en eventos futuros.',
            style: PuTextStyle.description1.copyWith(color: PUColors.textColor3),
          ),
          const SizedBox(height: 16),
        ],

        // ── 2. Formulario de creación ──
        PUInput(
          controller: venueNameController,
          labelText: 'Nombre del venue *',
          hintText: 'Ej: Estadio Luna Park',
        ),
        const SizedBox(height: 12),
        PUInput(
          controller: venueAddressController,
          labelText: 'Dirección',
          hintText: 'Ej: Av. Madero 420, CABA',
        ),
        const SizedBox(height: 12),
        PUInput(
          controller: venueCapacityController,
          labelText: 'Capacidad',
          hintText: 'Ej: 5000',
          textInputType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ButtonPrimary(
            title: venues.isEmpty
                ? 'Crear Venue y continuar'
                : 'Crear nuevo venue',
            onPressed: isCreatingVenue ? null : onCreateVenue,
            load: isCreatingVenue,
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(DateFormat dateFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ticketTypesDraft.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tickets configurados (${ticketTypesDraft.length})',
                  style: PuTextStyle.title5.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Total: ${(ticketTypesDraft.fold<double>(0, (sum, t) => sum + (t['price'] as double) * (t['totalQuantity'] as int))).toCurrency()}',
                style: PuTextStyle.description1.copyWith(
                  color: PUColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...ticketTypesDraft.asMap().entries.map((entry) {
            final index = entry.key;
            final draft = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: PUColors.primaryColor.withOpacity(0.1),
                  child: Text(
                    '${index + 1}',
                    style: PuTextStyle.description1.copyWith(
                      color: PUColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  draft['name'] as String,
                  style: PuTextStyle.description1.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '${(draft['price'] as double).toCurrency()} por unidad · ${draft['totalQuantity']} unidades disponibles',
                      style: PuTextStyle.description1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Máx. ${draft['maxPerUser']} por persona · Venta: ${DateFormat('dd/MM').format(draft['saleStartDate'] as DateTime)} - ${DateFormat('dd/MM').format(draft['saleEndDate'] as DateTime)}',
                      style: PuTextStyle.description1.copyWith(
                        color: PUColors.textColor3,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => onRemoveTicketType(index),
                  tooltip: 'Eliminar este tipo de ticket',
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Divider(color: PUColors.borderInputColor),
          const SizedBox(height: 16),
        ],
        Text(
          'Agregar tipo de ticket',
          style: PuTextStyle.title5.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        PUInput(
          controller: ticketNameController,
          labelText: 'Nombre del ticket *',
          hintText: 'Ej: General, VIP, Platea',
          errorText: ticketNameError,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PUInput(
                controller: ticketPriceController,
                labelText: 'Precio unitario *',
                hintText: '0.00',
                textInputType: const TextInputType.numberWithOptions(decimal: true),
                errorText: ticketPriceError,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PUInput(
                controller: ticketQuantityController,
                labelText: 'Cantidad total *',
                hintText: 'Ej: 100',
                textInputType: TextInputType.number,
                errorText: ticketQuantityError,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        PUInput(
          controller: ticketMaxPerUserController,
          labelText: 'Máximo por usuario',
          hintText: 'Ej: 10',
          textInputType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PUInput(
                controller: TextEditingController(
                  text: ticketSaleStart != null ? dateFormat.format(ticketSaleStart!) : '',
                ),
                labelText: 'Inicio de venta *',
                hintText: 'Seleccionar fecha...',
                readOnly: true,
                onTap: onPickTicketSaleStart,
                errorText: ticketSaleError,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PUInput(
                controller: TextEditingController(
                  text: ticketSaleEnd != null ? dateFormat.format(ticketSaleEnd!) : '',
                ),
                labelText: 'Fin de venta *',
                hintText: 'Seleccionar fecha...',
                readOnly: true,
                onTap: onPickTicketSaleEnd,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Los campos marcados con * son obligatorios',
          style: PuTextStyle.description1.copyWith(
            color: PUColors.textColor3,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ButtonSecundary(
            title: 'Agregar a la lista',
            onPressed: onAddTicketType,
            load: false,
          ),
        ),
      ],
    );
  }
}
