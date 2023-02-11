import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;
  final double size;
  const CustomButton({
    Key? key,
    required this.label,
    this.color = Colors.blue,
    this.size = double.infinity,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: size,
        height: 50,
        decoration: BoxDecoration(
          color: filled ? color : null,
          border: Border.all(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: filled ? Colors.white : color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
