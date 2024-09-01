import 'package:flutter/material.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';

class PUInputDropDown<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final String? errorText;
  final List<DropdownMenuItem<T>> items;
  final T? initialItem;
  final String? Function(T?)? validator;

  final Function(T) onSelect;

  const PUInputDropDown({
    super.key,
    required this.items,
    required this.onSelect,
    required this.label,
    required this.hintText,
    required this.errorText,
    this.initialItem,
    this.validator,
  });

  @override
  State<PUInputDropDown<T>> createState() => _InputDropDownState<T>();
}

class _InputDropDownState<T> extends State<PUInputDropDown<T>> {
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<T>(
          value: selectedValue ?? widget.initialItem,
          iconEnabledColor: PUColors.iconColor,
          decoration: InputDecoration(
            fillColor: PUColors.bgInput,
            hoverColor: PUColors.bgInput,
            focusColor: PUColors.bgInput,
            hintText: widget.hintText,
            hintStyle: PuTextStyle.hintTextStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            isCollapsed: false,
            alignLabelWithHint: false,
            errorText: widget.errorText,
            errorStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PUColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: PUColors.borderInputColor),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PUColors.borderInputColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          focusColor: Colors.transparent,
          style: PuTextStyle.hintTextStyle,
          validator: widget.validator,
          hint: Text(
            widget.hintText,
            style: PuTextStyle.hintTextStyle,
          ),
          items: widget.items,
          onChanged: (T? newValue) {
            if (newValue != null) {
              widget.onSelect(newValue);
              setState(() {
                selectedValue = newValue;
              });
            }
          },
        ),
      ],
    );
  }
}
