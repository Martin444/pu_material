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
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: PuTextStyle.title2),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: content,
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions,
                ),
              ],
            ],
          ),
        ),
      ),
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
