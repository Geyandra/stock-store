import 'package:flutter/material.dart';
import 'package:mini_project/Widgets/botnav.dart';
import 'package:mini_project/Widgets/field.dart';
import 'package:mini_project/Widgets/passfield.dart';
import 'package:mini_project/Views/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const nameRoute = 'Login';

  final controlEmail = TextEditingController();
  final controlPassword= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("logo.png"))),
              ),
            ),
            SizedBox(
              height: 100,
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
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 50),
              child: ElevatedButton(
                  onPressed: () {
                  Navigator.of(context).pushNamed(BottomNavBar.nameRoute);},
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
