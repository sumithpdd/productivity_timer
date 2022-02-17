import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  const ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.size,
      required this.onPressed})
      : super(key: key);
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text, style: const TextStyle(color: Colors.white)),
      onPressed: onPressed,
      color: color,
      minWidth: size,
    );
  }
}
