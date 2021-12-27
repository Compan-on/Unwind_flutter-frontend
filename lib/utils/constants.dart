import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF000000);
  static const kDarkGreyColor = Color(0xFF9E9E9E);
  static const kDarkBlueColor = Color(0xFF6057FF);
  static const kBorderColor = Color(0xFFEFEFEF);

  //text
  static const title = "Google Sign In";
  static const textIntro = "Sharing how you feel \n";
  static const textIntroDesc1 = "is easier \n ";
  static const textIntroDesc2 = "than you think!";
  static const textSmallSignUp = "Sign up takes only 2 minutes!";
  static const textSignIn = "Sign In";
  static const textStart = "Continue";
  static const textSignInTitle = "Welcome back!";
  static const textSmallSignIn = "We are here to listen";
  static const textSignInGoogle = "Sign In With Google";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "Sign Up here";
  static const textHome = "Home";
  static const textContinue = 'Continue';
  static const textUsername1 = "Enter a name that defines \n";
  static const textUsername2 = "YOU";

  //navigate
  static const signInNavigate = '/sign-in';
  static const homeNavigate = '/home';
  static const registerPage1 = 'register1';

  static const statusBarColor = SystemUiOverlayStyle(
      statusBarColor: Constants.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark);
}