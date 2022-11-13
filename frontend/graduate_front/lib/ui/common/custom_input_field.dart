import 'package:flutter/material.dart';
import 'package:graduate_front/core/utils/styles.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String? value)? onSave;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final void Function(String value)? onFieldSubmited;
  final String label;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final bool obscure;
  final Color? fillColor;
  final Widget? suffix;
  final int maxLines;
  const CustomInputField({
    Key? key,
    this.onSave,
    this.validator,
    this.onTap,
    this.onFieldSubmited,
    required this.label,
    this.controller,
    this.focusNode,
    this.hintText = "",
    this.obscure = false,
    this.fillColor,
    this.suffix,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty) buildLabel(),
          TextFormField(
            textDirection: TextDirection.ltr,
            onTap: widget.onTap,
            onSaved: widget.onSave,
            validator: widget.validator,
            obscureText: widget.obscure,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            style: TStyles.mediumText,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintTextDirection: TextDirection.ltr,
              hintStyle: TStyles.smallText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: widget.suffix,
            ),
            onFieldSubmitted: widget.onFieldSubmited,
          ),
        ],
      ),
    );
  }

  Widget buildLabel() {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Text(
        widget.label,
        style: TStyles.smallText.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
