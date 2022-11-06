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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 300,
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
                        Navigator.of(context).pushNamed(BottomNavBar.nameRoute);
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
