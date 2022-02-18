import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      this.size = 80,
      required this.onPressed})
      : super(key: key);
  final Color color;
  final String text;
  double size = 80;
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

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {Key? key,
      this.color,
      this.text,
      this.value,
      this.setting,
      this.callback})
      : super(key: key);
  final Color? color;
  final String? text;
  final int? value;
  final String? setting;
  final CallbackSetting? callback;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text!, style: const TextStyle(color: Colors.white)),
      onPressed: () => callback!(setting!, value!),
      color: color,
    );
  }
}
