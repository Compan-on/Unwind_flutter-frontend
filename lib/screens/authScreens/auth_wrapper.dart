import 'package:companion/screens/authScreens/register.dart';
import 'package:companion/screens/authScreens/sign_in_page.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {

bool showSignIn = true;
void toggleView() {
  setState(() => showSignIn = !showSignIn);
}
  
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInPage(toggleView: toggleView);
    }
    else{
      return RegisterPage(toggleView: toggleView);
    }
  }
}