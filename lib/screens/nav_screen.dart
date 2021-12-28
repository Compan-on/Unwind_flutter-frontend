import 'package:flutter/material.dart';
import "./home_screen.dart";

import "../widgets/user_drawer.dart";

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _selectedIndex = 0;

  var screens = [
    HomeScreen(),
    Container(child: const Center(child: const Text("Coming Soon"))),
    Container(child: const Center(child: const Text("Coming Soon"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UnW;nd"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message_rounded)),
        ],
      ),
      drawer: UserDrawer(),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: ""),
        ],
      ),
    );
  }
}