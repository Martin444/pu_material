import 'package:flutter/material.dart';

/// Total Row Molecule - A row displaying label and amount for totals
class TotalRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isFinal;
  final Color? color;
  final EdgeInsetsGeometry padding;

  const TotalRow({
    super.key,
    required this.label,
    required this.amount,
    this.isFinal = false,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isFinal ? 22 : 15,
              fontWeight: isFinal ? FontWeight.w700 : FontWeight.normal,
              color: isFinal ? const Color(0xFF1976d2) : (color ?? const Color(0xFF666666)),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isFinal ? 22 : 15,
              fontWeight: isFinal ? FontWeight.w700 : FontWeight.w600,
              color: isFinal ? const Color(0xFF1976d2) : (color ?? const Color(0xFF2e7d32)),
            ),
          ),
        ],
      ),
    );
  }
}
