import 'package:flutter/material.dart';

class FieldOrder extends StatelessWidget {
  final IconData icon;
  final String hint;
  final int? maxline;
  final TextEditingController? controller;
  final validator;
  FieldOrder({
    Key? key,
    required this.icon,
    required this.hint,
    this.validator,
    this.maxline,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: 1,
        decoration: InputDecoration(
          fillColor: Colors.blue.shade100,
          filled: true,
          hintText: hint,
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.blue,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
