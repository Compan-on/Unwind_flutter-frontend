import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/models/user.dart';
import 'package:companion/services/auth.dart';
import 'package:companion/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Database{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference usernameCollection = FirebaseFirestore.instance.collection('usernames');

    String? uid = FirebaseAuth.instance.currentUser!.uid;
    storageService _storage = storageService();
    String profileImageURL = '';

    storeUserData({required String userName, required String profileImage}) async {
    
    //   void getUID() async{
    //   userModel? currentUser = await FirebaseService().signUp();
    //   uid = currentUser!.uid;
    // }
    profileImageURL = await _storage.uploadFile(profileImage, uid!);
     
    DocumentReference documentReferencer = userCollection.doc(uid);

    DocumentReference documentReferencer2 = usernameCollection.doc(userName);

    userModel user = userModel.overloadedConstructor(uid!, userName, profileImageURL);

    var data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      print("User data added");
    }).catchError((e) => print(e));

    
    await documentReferencer2.set(data).whenComplete(() {
      print("Username added");
    }).catchError((e) => print(e));
      
  }
   userModel? _userFromFirebaseSnapshot(DocumentSnapshot snapshot){

        if(snapshot != null){
            Map<String, dynamic> data = new HashMap();
            data['uid'] = snapshot.id;
            data['name'] = snapshot['name'];
            data['profileImage'] = snapshot['profileImage'];

            return userModel.fromJson(data);
        }
        return null;
      }

    Stream<userModel?> getUser(uid){
        return FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .snapshots()
            .map(_userFromFirebaseSnapshot);
      }

     
}