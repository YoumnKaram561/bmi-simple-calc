import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 28,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}