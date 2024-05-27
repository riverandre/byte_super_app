import 'package:flutter/material.dart';

class PdvButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final Color? color;
  final Color? colorText;

  const PdvButtonWidget(
      {required this.onPressed,
      required this.label,
      this.width,
      this.height,
      this.color,
      this.colorText = Colors.black,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorText,
          ),
        ),
      ),
    );
  }
}
