import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

//screens
import "../screens/mainScreens/home_screen.dart";
import "../screens/mainScreens/create_post.dart";

class NavigationBarUnwind extends StatefulWidget {
  const NavigationBarUnwind({Key? key}) : super(key: key);

  @override
  _NavigationBarUnwindState createState() => _NavigationBarUnwindState();
}

class _NavigationBarUnwindState extends State<NavigationBarUnwind> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _hideNavBar = false;

  List<Widget> _screens() {
    return [
      HomeScreen(),
      Container(child: const Center(child: Text("Coming Soon"))),
      CreatePost(),
      Container(child: const Center(child: Text("Coming Soon"))),
      Container(child: const Center(child: Text("Coming Soon"))),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Ionicons.md_book),
        title: "Library",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: " ",
        activeColorPrimary: const Color.fromRGBO(38, 50, 56, 1),
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.medical_services),
        title: "Therapy",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book),
        title: "Feed",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar: _hideNavBar,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      margin: EdgeInsets.all(0.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: (MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight) +
          3,
      decoration: NavBarDecoration(
          colorBehindNavBar: const Color.fromRGBO(238, 240, 254, 1),
          borderRadius: BorderRadius.circular(20.0)),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style16,
    );
  }
}
