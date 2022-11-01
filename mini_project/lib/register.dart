import 'package:flutter/material.dart';
import 'package:mini_project/botnav.dart';
import 'package:mini_project/field.dart';
import 'package:mini_project/login.dart';
import 'package:mini_project/passfield.dart';

class Register extends StatelessWidget {
  Register({super.key});
  static const nameRoute = 'Register';

  final controlEmail = TextEditingController();
  final controlName = TextEditingController();
  final controlPassword= TextEditingController();
  final controlConfirmPassword= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("logo.png"))),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Field(
              hint: "name",
              icon: Icons.person,
              controller: controlName,
            ),
            Field(
              hint: "email",
              icon: Icons.email,
              controller: controlEmail,
            ),
            PassField(
              hint: "password",
              icon: Icons.lock,
              controller: controlPassword,
            ),
            PassField(
              hint: "confirm password",
              icon: Icons.lock,
              controller: controlConfirmPassword,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 50),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(BottomNavBar.nameRoute);
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
