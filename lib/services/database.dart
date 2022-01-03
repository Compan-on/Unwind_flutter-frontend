import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/models/user.dart';
import 'package:companion/services/auth.dart';
import 'package:flutter/cupertino.dart';

class Database{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

    //Future<User?> currentUser = FirebaseService().signInwithGoogle();
    String? uid;
    void getUID() async{
      userModel? currentUser = await FirebaseService().signInwithGoogle();
      uid = currentUser!.uid;
    }
    
    storeUserData({required String userName}) async {
    
    DocumentReference documentReferencer = userCollection.doc(uid);

    userModel user = userModel.overloadedConstructor(uid!, userName);

    var data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      print("User data added");
    }).catchError((e) => print(e));



    Stream<QuerySnapshot> retrieveUsers() {
      Stream<QuerySnapshot> queryUsers = userCollection
          .orderBy('userName', descending: true)
          .snapshots();

      return queryUsers;
    }

  }
}