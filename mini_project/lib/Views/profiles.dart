import 'package:flutter/material.dart';
import 'package:mini_project/Widgets/field_data.dart';

class Profiles extends StatelessWidget {
  Profiles({super.key});
  static const nameRoute = 'Profiles';

  final namacontrol = TextEditingController();
  final emailcontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FieldData(icon: Icons.person, label: "Name", controller: namacontrol),
        FieldData(icon: Icons.mail, label: "Email", controller: emailcontrol),
        Container(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text("Apakah Anda yakin ingin keluar ?"),
                          title: Text("Konfirmasi"),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade300),
                                    child: Text("Konfirm")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade300),
                                    child: Text("Cancel")),
                              ],
                            )
                          ],
                        ));
              },
              child: Text("Log Out")),
        )
      ],
    ));
  }
}
