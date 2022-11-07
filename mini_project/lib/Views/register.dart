import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_akun.dart';
import 'package:mini_project/Widgets/botnav.dart';
import 'package:mini_project/Widgets/field.dart';
import 'package:mini_project/Views/login.dart';
import 'package:mini_project/Widgets/passfield.dart';

class Register extends StatelessWidget {
  Register({super.key});
  static const nameRoute = 'Register';

  final controlEmail = TextEditingController();
  final controlName = TextEditingController();
  final controlPassword = TextEditingController();
  final controlConfirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Field(
                    hint: "Name",
                    icon: Icons.person,
                    controller: controlName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please fill field");
                      } else {
                        return null;
                      }
                    },
                  ),
                  Field(
                    hint: "Email",
                    icon: Icons.email,
                    controller: controlEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please fill field");
                      } else {
                        return null;
                      }
                    },
                  ),
                  PassField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: controlPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please fill field");
                      } else {
                        return null;
                      }
                    },
                  ),
                  PassField(
                    hint: "Confirm Password",
                    icon: Icons.lock,
                    controller: controlConfirmPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("please fill field");
                      } else if (controlPassword.text !=
                          controlConfirmPassword.text) {
                        return ("Password not valid");
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 50),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: controlEmail.text,
                                      password: controlPassword.text)
                                  .then((value) => {
                                        Navigator.of(context)
                                            .pushNamed(BottomNavBar.nameRoute)
                                      });
                            } on FirebaseAuthException catch (e) {
                              print(e);
                            }
                          }
                          final data = Accounts(
                              Nama: controlName.text,
                              Email: controlEmail.text,
                              Password: controlPassword.text);
                          createData(data);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), minimumSize: Size(340, 50)),
                        child: Text("Submit")),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginPage.nameRoute);
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Positioned(
              top: -27,
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("logo.png"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future createData(Accounts data) async {
  final docData = FirebaseFirestore.instance.collection("Akun").doc();
  data.Id = docData.id;
  final json = data.toJson();
  docData.set(json);
}
