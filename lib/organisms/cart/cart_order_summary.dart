// Level: Organism
// Description: Resumen de orden puro y reutilizable. Muestra total y botón de acción.
import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:pu_material/widgets/buttons/button_primary.dart';
import 'package:pu_material/utils/formaters/currency_converter.dart';

class CartOrderSummary extends StatelessWidget {
  final double total;
  final VoidCallback onContinue;
  final String buttonTitle;
  final bool isLoading;

  const CartOrderSummary({
    super.key,
    required this.total,
    required this.onContinue,
    this.buttonTitle = 'Continuar',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: PuTextStyle.priceCartTOtal,
                ),
                Text(
                  total.toString().convertToCorrency(),
                  style: PuTextStyle.priceCartTOtal,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ButtonPrimary(
              title: buttonTitle,
              onPressed: onContinue,
              load: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
