import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pu_material/pu_material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

import '../../utils/formaters/upercase_first_letter.dart';

class PUInput extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? formaters;
  final void Function(String)? onChanged;
  final bool? isPassword;
  final String? errorText;
  final TextEditingController controller;

  const PUInput({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.textInputType,
    this.textInputAction,
    this.formaters,
    this.isPassword,
    this.onChanged,
    this.errorText,
    this.validator,
  });

  @override
  State<PUInput> createState() => _PUInputState();
}

class _PUInputState extends State<PUInput> {
  List<TextInputFormatter> getFormatForTypeInput() {
    if (widget.formaters != null) return widget.formaters!;
    switch (widget.textInputType) {
      case TextInputType.name:
        return [UppercaseFirstLetterFormatter()];
      case TextInputType.number:
        return [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.labelText ?? '',
              style: PuTextStyle.textLabel1,
            ),
          ),
          TextFormField(
            obscureText: widget.isPassword ?? false,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            inputFormatters: getFormatForTypeInput(),
            decoration: InputDecoration(
              fillColor: PUColors.bgInput,
              hintText: widget.hintText,
              floatingLabelStyle: PuTextStyle.textLabel1,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              isCollapsed: false,
              alignLabelWithHint: false,
              errorText: widget.errorText,
              errorStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: widget.controller,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
