import 'package:flutter/material.dart';

import '../../core/utils/styles.dart';

class CustomDropDownButtonForm<T> extends StatefulWidget {
  final void Function(dynamic)? onSave;
  final String Function(dynamic)? validator;
  final void Function()? onTap;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final void Function(String value)? onFieldSubmited;
  final String label;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final bool obscure;
  final Color? fillColor;
  final Widget? suffix;
  final int maxLines;
  const CustomDropDownButtonForm({
    Key? key,
    this.onSave,
    this.validator,
    this.onTap,
    required this.items,
    required this.onChanged,
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
  _CustomDropDownButtonFormState createState() =>
      _CustomDropDownButtonFormState();
}

class _CustomDropDownButtonFormState extends State<CustomDropDownButtonForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.label.isNotEmpty) buildLabel(),
        DropdownButtonFormField(
          validator: widget.validator,
          focusNode: widget.focusNode,
          style: TStyles.mediumText,
          items: widget.items,
          onChanged: widget.onChanged,
          onSaved: widget.onSave,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintTextDirection: TextDirection.ltr,
            hintStyle: TStyles.smallText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            filled: true,
            fillColor: Colors.white,
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
          ),
        )
      ]),
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
