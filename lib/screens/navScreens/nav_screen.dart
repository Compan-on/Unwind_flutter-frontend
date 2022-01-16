import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import "package:provider/provider.dart";
import "../../providers/post.dart";

import '../../widgets/user_drawer.dart';
import "../../widgets/navigation_bar.dart";
import "../mainScreens/create_post.dart";

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  bool showAppbar = true;

  // void toggleNavbar(bool flag) {
  //   setState(() {
  //     showAppbar = flag;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) {
            return Posts();
          }),
        ],
        child: Scaffold(
          appBar: showAppbar
              ? AppBar(
                  iconTheme:
                      const IconThemeData(color: Color.fromRGBO(0, 0, 0, 1)),
                  title: const Text("UnW;nd",
                      style: TextStyle(
                        color: Color.fromRGBO(83, 109, 254, 1),
                        fontFamily: "Rancho",
                        fontSize: 33,
                      )),
                  centerTitle: true,
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(AntDesign.message1)),
                    ])
              : null,
          drawer: UserDrawer(),
          body: NavigationBarUnwind(),
          // body: MaterialApp(
          //   home: NavigationBarUnwind(),
          //   routes: {
          //     "/edit_post": (ctx) => CreatePost(false),
          //   },
          // ),
        ));
  }
}
