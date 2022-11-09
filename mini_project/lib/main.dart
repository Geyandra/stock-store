import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/Providers/orders_provider.dart';
import 'package:mini_project/Providers/products_provider.dart';
import 'package:mini_project/Widgets/botnav.dart';
import 'package:mini_project/Views/create.dart';
import 'package:mini_project/Views/details.dart';
import 'package:mini_project/Views/homepage.dart';
import 'package:mini_project/Views/login.dart';
import 'package:mini_project/Views/profiles.dart';
import 'package:mini_project/Views/register.dart';
import 'package:mini_project/Views/selected_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ProductsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrdersProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Register.nameRoute,
        routes: {
          LoginPage.nameRoute: (context) => LoginPage(),
          Register.nameRoute: (context) => Register(),
          Profiles.nameRoute: (context) => Profiles(),
          SelectedData.nameRoute: (context) => SelectedData(),
          BottomNavBar.nameRoute: (context) => BottomNavBar(),
          Homepage.nameRoute: (context) => Homepage(),
          AddProduct.nameRoute: (context) => AddProduct(),
          DetailsProduct.nameRoute: (context) => DetailsProduct(data: null),
        });
  }
}
