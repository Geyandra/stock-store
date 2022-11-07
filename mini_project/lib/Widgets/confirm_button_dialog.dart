import 'package:flutter/material.dart';

class RGButtonDialog extends StatelessWidget {
  final String text;
  final Color color;
  final margin;
  final VoidCallback pressed;
  const RGButtonDialog({
    required this.text,
    required this.color,
    this.margin,
    required this.pressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      margin: margin,
      child: ElevatedButton(
          onPressed: pressed,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text)),
    );
  }
}
