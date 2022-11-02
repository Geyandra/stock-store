import 'package:flutter/material.dart';

class SelectedData extends StatelessWidget {
  const SelectedData({super.key});
  static const nameRoute = 'Selected Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            leading: Text(
              "ID",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title: Text("Nama Toko"),
            subtitle: Text("Tanggal Datang"),
            trailing: Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            leading: Text(
              "ID",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title: Text("Nama Toko"),
            subtitle: Text("Tanggal Datang"),
            trailing: Icon(
              Icons.list_alt,
              color: Colors.red.shade300,
            ),
          ),
        ),
      ],
    ));
  }
}
