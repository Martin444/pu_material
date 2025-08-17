import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pu_material/features/orders/models/order.dart';
import 'package:pu_material/features/orders/utils/time_ago.dart';
import 'package:pu_material/features/orders/ui/atoms/currency_text.dart';
import 'package:pu_material/features/orders/ui/molecules/status_badge.dart';

void main() {
  group('Orders Feature Tests', () {
    test('Order model should create correctly', () {
      final order = Order(
        numero: '001',
        detalle: 'Test order',
        estado: 'Pendiente',
        creado: DateTime.now(),
        alias: 'TestAlias',
        idCliente: 'Test Client',
        totalCentavos: 100000,
      );

      expect(order.numero, '001');
      expect(order.estado, 'Pendiente');
      expect(order.totalCentavos, 100000);
    });

    test('Order.example factory should work', () {
      final order = Order.example();

      expect(order.numero, '01');
      expect(order.estado, 'Pendiente');
      expect(order.totalCentavos, 3823200);
    });

    test('TimeAgo.format should format correctly', () {
      final now = DateTime.now();
      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      final twoHoursAgo = now.subtract(const Duration(hours: 2));
      final threeDaysAgo = now.subtract(const Duration(days: 3));

      expect(TimeAgo.format(fiveMinutesAgo), 'Hace 5 min');
      expect(TimeAgo.format(twoHoursAgo), 'Hace 2 horas');
      expect(TimeAgo.format(threeDaysAgo), 'Hace 3 días');
    });

    test('TimeAgo.formatShort should format correctly', () {
      final now = DateTime.now();
      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      final twoHoursAgo = now.subtract(const Duration(hours: 2));

      expect(TimeAgo.formatShort(fiveMinutesAgo), '5m');
      expect(TimeAgo.formatShort(twoHoursAgo), '2h');
    });

    testWidgets('CurrencyText should display correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CurrencyText(150000), // $1,500.00
          ),
        ),
      );

      // Verifica que el widget se construya sin errores
      expect(find.byType(CurrencyText), findsOneWidget);
    });

    testWidgets('StatusBadge should display correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatusBadge('Pendiente'),
          ),
        ),
      );

      expect(find.byType(StatusBadge), findsOneWidget);
      expect(find.text('Pendiente'), findsOneWidget);
    });
  });
}
