// import 'package:companion/screens/home_page.dart';
// import 'dart:js';

import 'package:companion/screens/authScreens/welcome_page.dart';
import 'package:companion/screens/authScreens/sign_in_page.dart';
import '../screens/navScreens/nav_screen.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in': (context) => SignInPage(),
    '/home': (context) => NavScreen(),
  };
}
