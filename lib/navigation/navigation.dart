// import 'package:companion/screens/home_page.dart';

import 'package:companion/screens/authScreens/username.dart';
import 'package:companion/screens/authScreens/welcome_page.dart';
import 'package:companion/screens/authScreens/sign_in_page.dart';
import 'package:companion/screens/mainScreens/profile.dart';
import '../screens/navScreens/nav_screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in': (context) => SignInPage(),
    '/home': (context) => NavScreen(),
    '/register1': (context) => usernamePage(),
    '/profilePage': (context) => profilePage(),
  };
}
