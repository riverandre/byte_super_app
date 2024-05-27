import 'package:flutter/material.dart';

class PdvTextformfieldBlueWidget extends StatelessWidget {
  final TextEditingController? controller;

  final double size;
  final ValueChanged<String>? onChange;
  final bool enabledValue;
  final Color color;
  final FocusNode? focus;

  const PdvTextformfieldBlueWidget(
      {required this.controller,
      required this.size,
      this.onChange,
      required this.enabledValue,
      required this.color,
      this.focus,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      enabled: enabledValue,
      autofocus: enabledValue,
      focusNode: focus,
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      textAlign: TextAlign.end,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: '0,00',
        hintStyle:
            TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
        isDense: true,
        labelStyle:
            TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0XFFADDFFB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0XFFADDFFB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0XFFADDFFB)),
        ),
        filled: true,
        fillColor: const Color(0XFFADDFFB),
      ),
    );
  }
}
