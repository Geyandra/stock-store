import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Widgets/botnav.dart';
import 'package:mini_project/Widgets/field.dart';
import 'package:mini_project/Widgets/passfield.dart';
import 'package:mini_project/Views/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const nameRoute = 'Login';

  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();
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
                    height: 300,
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
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 50),
                    child: ElevatedButton(
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: controlEmail.text, password: controlPassword.text)
                              .then((value) => {
                              Navigator.of(context).pushNamed(BottomNavBar.nameRoute)
                              });
                            }on FirebaseAuthException catch (e) {
                              print(e);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), minimumSize: Size(340, 50)),
                        child: Text("Submit")),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Register.nameRoute);
                      },
                      child: Text(
                        "REGISTER",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Positioned(
              top: -30,
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                    image: DecorationImage(image: AssetImage("logo.png"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
