import 'package:flutter/material.dart';

/// Template base para la página de órdenes
class OrdersTemplate extends StatelessWidget {
  final Widget toolbar;
  final Widget body;

  const OrdersTemplate({
    super.key,
    required this.toolbar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: toolbar,
      ),
      body: SafeArea(child: body),
    );
  }
}
