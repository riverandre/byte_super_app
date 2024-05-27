import 'package:flutter/material.dart';

class PdvRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double fontSize;
  final Color color;

  const PdvRoundedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.color,
      this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
