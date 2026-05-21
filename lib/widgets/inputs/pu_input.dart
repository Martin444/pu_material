import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pu_material/pu_material.dart';

import '../../utils/formaters/upercase_first_letter.dart';

class PUInput extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? formaters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmited;
  final bool? isPassword;
  final bool? visibleText;
  final String? errorText;
  final TextEditingController controller;
  final bool compact;
  final Color? activeBorderColor;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final bool showLabel;

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
    this.focusNode,
    this.onSubmited,
    this.validator,
    this.compact = false,
    this.activeBorderColor,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.minLines,
    this.showLabel = true,
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
    return TextFormField(
      obscureText: isVisibleText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      inputFormatters: getFormatForTypeInput(),
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onTap: widget.onTap,
      decoration: InputDecoration(
        fillColor: PUColors.bgInput,
        hoverColor: PUColors.bgInput,
        focusColor: PUColors.bgInput,
        labelText: widget.showLabel ? widget.labelText : null,
        labelStyle: PuTextStyle.description1.copyWith(
          color: PUColors.textColorMuted,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        hintText: widget.hintText,
        hintStyle: widget.compact
            ? PuTextStyle.hintTextStyle.copyWith(fontSize: 13)
            : PuTextStyle.hintTextStyle.copyWith(color: Colors.grey.shade400),
        floatingLabelBehavior: widget.showLabel ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
        isCollapsed: widget.compact,
        alignLabelWithHint: false,
        errorText: widget.errorText,
        errorStyle: const TextStyle(fontWeight: FontWeight.w400),
        filled: true,
        contentPadding: widget.compact
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 0)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: (widget.isPassword ?? false)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleText = !isVisibleText;
                  });
                },
                icon: Icon(
                  isVisibleText
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                  size: 24,
                  color: PUColors.iconColor,
                ),
                splashRadius: 20,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.activeBorderColor ?? PUColors.primaryColor),
          borderRadius: BorderRadius.circular(widget.compact ? 8 : 12),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: PUColors.borderInputColor),
          borderRadius: BorderRadius.circular(widget.compact ? 8 : 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PUColors.borderInputColor),
          borderRadius: BorderRadius.circular(widget.compact ? 8 : 12),
        ),
      ),
      style: widget.compact ? PuTextStyle.hintTextStyle.copyWith(fontSize: 13) : PuTextStyle.hintTextStyle,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmited,
    );
  }
}
