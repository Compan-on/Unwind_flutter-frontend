import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/screens/authScreens/username.dart';
import 'package:companion/screens/mainScreens/home_screen.dart';
import 'package:companion/services/database.dart';
import 'package:companion/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:companion/models/user.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  userModel? _userFromFirebase(User? user){
    return user != null ? userModel(uid: user.uid) : null;
  }

  Stream<userModel?> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<userModel?> signInwithGoogle() async {
   User? user;
    final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
    try {
        final UserCredential userCredential =
              await _auth.signInWithCredential(credential);

        user = userCredential.user;
        if(userCredential.additionalUserInfo!.isNewUser){
          if(user != null){
            usernamePage();
          }
        }
        else{
          HomeScreen();
        }
    } 
    on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }

    return _userFromFirebase(user);
    
  }


  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  
}

