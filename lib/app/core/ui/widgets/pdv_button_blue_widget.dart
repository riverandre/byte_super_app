import 'package:flutter/material.dart';

class PdvButtonBlueWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double size;
  final IconData icon;
  final Color color;
  final Color textColor;

  const PdvButtonBlueWidget({
    required this.onPressed,
    required this.label,
    required this.size,
    required this.color,
    required this.textColor,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  color,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: size,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
