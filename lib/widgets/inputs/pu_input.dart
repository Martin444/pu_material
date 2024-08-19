import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pu_material/pu_material.dart';
import 'package:pu_material/utils/pu_assets.dart';
import 'package:pu_material/utils/pu_colors.dart';
import 'package:pu_material/utils/style/pu_style_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../utils/formaters/upercase_first_letter.dart';

class PUInput extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? formaters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmited;
  final bool? isPassword;
  final bool? visibleText;
  final String? errorText;
  final TextEditingController controller;

  const PUInput({
    super.key,
    required this.controller,
    this.visibleText,
    this.hintText,
    this.labelText,
    this.textInputType,
    this.textInputAction,
    this.formaters,
    this.isPassword,
    this.onChanged,
    this.errorText,
    this.onSubmited,
    this.validator,
  });

  @override
  State<PUInput> createState() => _PUInputState();
}

class _PUInputState extends State<PUInput> {
  bool isVisibleText = false;

  @override
  initState() {
    super.initState();

    isVisibleText = widget.isPassword ?? false;
  }

  Widget getIcon() {
    if (widget.isPassword ?? false) {
      return Container(
        margin: EdgeInsets.only(
          right: 5,
          top: widget.errorText != null ? 0 : 10,
          bottom: widget.errorText != null ? 18 : 0,
        ),
        child: GestureDetector(
          child: SvgPicture.asset(
            isVisibleText ? PUIcons.iconEyeOpen : PUIcons.iconEyeClose,
            height: 30,
          ),
          onTap: () {
            setState(() {
              isVisibleText = !isVisibleText;
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

  List<TextInputFormatter> getFormatForTypeInput() {
    if (widget.formaters != null) return widget.formaters!;
    switch (widget.textInputType) {
      case TextInputType.name:
        return [UppercaseFirstLetterFormatter()];
      case TextInputType.number:
      case TextInputType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.errorText != null ? Alignment.centerRight : Alignment.topRight,
      children: [
        TextFormField(
          obscureText: isVisibleText,
          validator: widget.validator,
          keyboardType: widget.textInputType,
          inputFormatters: getFormatForTypeInput(),
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
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            // contentPadding: const EdgeInsets.symmetric(
            //   horizontal: 10,
            //   vertical: 3,
            // ),
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
          style: PuTextStyle.hintTextStyle,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmited,
        ),
        getIcon(),
      ],
    );
  }
}
