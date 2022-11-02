import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final validator;
  const Field({
    Key? key,
    this.validator,
    required this.controller,
    required this.hint,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            filled: true,
            fillColor: Colors.grey.shade200),
      ),
    );
  }
}
