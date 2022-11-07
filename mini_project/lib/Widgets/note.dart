import 'package:flutter/material.dart';

class ListOrder extends StatelessWidget {
  final String title;
  final String trailing;
  ListOrder({Key? key, required this.title, required this.trailing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(title),
        trailing: Text(
          trailing,
          style: TextStyle(color: Color.fromARGB(228, 0, 0, 0)),
        ),
      ),
    );
  }
}