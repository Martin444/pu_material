import 'package:flutter/material.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

class PuDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const PuDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: PuTextStyle.title2),
      content: content,
      actions: actions,
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget> actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => PuDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}
