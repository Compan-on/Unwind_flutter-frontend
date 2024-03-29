import 'package:flutter/material.dart';

class userModel {
  String? uid;
  String? name;
  String? age;
  String? gender;
  String? profileImage;
  
  userModel({
    required this.uid,
  });

  userModel.overloadedConstructor(String uid, String name, String profileImage){
    this.uid = uid;
    this.name = name;
    this.profileImage = profileImage;
  }

  userModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;

    return data;
  }
}
