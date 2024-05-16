import 'package:flutter/material.dart';
import 'package:pu_material/pu_material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

class PUInput extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? isPassword;
  final String? errorText;
  final TextEditingController controller;

  const PUInput({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.isPassword,
    this.onChanged,
    this.errorText,
    this.validator,
  });

  @override
  State<PUInput> createState() => _PUInputState();
}

class _PUInputState extends State<PUInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: widget.isPassword ?? false,
        validator: widget.validator,
        decoration: InputDecoration(
          fillColor: PUColors.bgInput,
          labelText: widget.labelText,
          hintText: widget.hintText,
          floatingLabelStyle: PuTextStyle.textLabel1,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          isCollapsed: false,
          alignLabelWithHint: false,
          errorText: widget.errorText,
          errorStyle: const TextStyle(
            fontWeight: FontWeight.w800,
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
    );
  }
}
