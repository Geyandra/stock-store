import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/botnav.dart';
import 'package:mini_project/create.dart';
import 'package:mini_project/details.dart';
import 'package:mini_project/homepage.dart';
import 'package:mini_project/login.dart';
import 'package:mini_project/profiles.dart';
import 'package:mini_project/register.dart';
import 'package:mini_project/selected_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: Register.nameRoute, routes: {
      LoginPage.nameRoute: (context) => LoginPage(),
      Register.nameRoute: (context) => Register(),
      Profiles.nameRoute: (context) => Profiles(),
      SelectedData.nameRoute: (context) => SelectedData(),
      BottomNavBar.nameRoute: (context) => BottomNavBar(),
      Homepage.nameRoute: (context) => Homepage(),
      AddProduct.nameRoute: (context) => AddProduct(),
      DetailsProduct.nameRoute: (context) => DetailsProduct(),
    });
  }
}
