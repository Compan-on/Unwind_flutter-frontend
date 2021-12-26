import 'package:companion/screens/home_page.dart';
import 'package:companion/screens/sign_in_page.dart';
import 'package:companion/screens/welcome_page.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/sign-in': (context) => SignInPage(),
    '/home': (context) => HomePage()
  };
}
