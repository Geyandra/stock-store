import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_akun.dart';
import 'package:mini_project/Views/register.dart';

class Profiles extends StatelessWidget {
  Profiles({super.key});
  static const nameRoute = 'Profiles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<Accounts>>(
          stream: readData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Ada Kesalahan ${snapshot.hasError}");
            } else if (snapshot.hasData) {
              final datas = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: datas.map(buildData).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget buildData(Accounts data) => Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    label: Text(data.Nama),
                    labelStyle: TextStyle(color: Colors.blue.shade600),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    label: Text(data.Email),
                    labelStyle: TextStyle(color: Colors.blue.shade600),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            LogOut()
          ],
        ),
      );
}

class LogOut extends StatelessWidget {
  const LogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
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
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushNamed(
                                      context, Register.nameRoute);
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
    );
  }
}

Stream<List<Accounts>> readData() => FirebaseFirestore.instance
    .collection("Akun")
    .where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email!)
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Accounts.fromJson(doc.data())).toList());
