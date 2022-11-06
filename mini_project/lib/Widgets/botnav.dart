import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Views/homepage.dart';
import 'package:mini_project/Views/profiles.dart';
import 'package:mini_project/Views/selected_data.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static const nameRoute = 'BotNav';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

int index = 0;
final page = [Homepage(), SelectedData(), Profiles()];

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.blue,
        color: Colors.blue.shade200,
        items: [
          Icon(Icons.home),
          Icon(Icons.list_alt),
          Icon(Icons.person),
        ],
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.linear,
      ),
      body: page[index],
    );
  }
}
