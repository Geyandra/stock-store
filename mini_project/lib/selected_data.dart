import 'package:flutter/material.dart';

class SelectedData extends StatelessWidget {
  const SelectedData({super.key});
  static const nameRoute = 'Selected Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Selected Data"),),
    );
  }
}