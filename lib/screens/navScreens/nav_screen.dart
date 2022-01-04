import 'package:flutter/material.dart';
import '../mainScreens/home_screen.dart';

import "package:provider/provider.dart";
import "../../providers/post.dart";

import '../../widgets/user_drawer.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _selectedIndex = 0;

  var screens = [
    HomeScreen(),
    Container(child: const Center(child: Text("Coming Soon"))),
    Container(child: const Center(child: Text("Coming Soon"))),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) {
            return Posts();
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("UnW;nd"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.message_rounded)),
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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services), label: ""),
            ],
          ),
        ));
  }
}
