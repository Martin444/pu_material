import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';

class PuInputTags extends StatefulWidget {
  final TextEditingController controller;
  final Function(List<String>)? onSubmitTag;

  const PuInputTags({
    super.key,
    required this.controller,
    this.onSubmitTag,
  });

  @override
  State<PuInputTags> createState() => _PuInputTagsState();
}

class _PuInputTagsState extends State<PuInputTags> {
  List<String> tags = ["Todos"];
  FocusNode focusTagInput = FocusNode();

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              flex: 3,
              child: PUInput(
                controller: widget.controller,
                focusNode: focusTagInput,
                hintText: 'Agrega los ingredientes',
                onSubmited: (value) {
                  if (value.isNotEmpty) {
                    _addTag(value);
                    widget.controller.clear();
                    focusTagInput.requestFocus();
                    widget.onSubmitTag!(tags);
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              child: ButtonPrimary(
                title: 'Agregar',
                onPressed: () {
                  if (widget.controller.text.isNotEmpty) {
                    _addTag(widget.controller.text);
                    widget.controller.clear();
                    focusTagInput.requestFocus();
                    widget.onSubmitTag!(tags);
                  }
                },
                load: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6.0,
          children: tags.map((tag) {
            return Chip(
              label: Text(tag),
              deleteIcon: const Icon(Icons.cancel),
              onDeleted: () => _removeTag(tag),
            );
          }).toList(),
        ),
      ],
    );
  }
}
