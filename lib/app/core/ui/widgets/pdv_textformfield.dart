import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PdvTextformfield extends StatelessWidget {
  final String label;
  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readyOnly;
  final bool enabledValue;
  final TextInputType? inputType;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputFormatter? inputMask;
  final bool autofocus;

  const PdvTextformfield({
    required this.label,
    this.labelText = '',
    this.obscureText = false,
    this.readyOnly = true,
    this.enabledValue = false,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.inputMask,
    this.focusNode,
    this.inputType,
    this.controller,
    this.validator,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChange,
          readOnly: readyOnly,
          enabled: enabledValue,
          obscureText: obscureText,
          cursorColor: Colors.black,
          keyboardType: inputType,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          autofocus: autofocus,
          inputFormatters: [inputMask ?? MaskTextInputFormatter(mask: '')],
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp('r[0-9]')),
          // ],
          decoration: InputDecoration(
            label: Text(label),
            isDense: true,
            labelStyle: const TextStyle(color: Colors.black),
            errorStyle: const TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
