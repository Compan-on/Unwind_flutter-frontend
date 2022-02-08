import 'package:flutter/material.dart';

import 'package:companion/services/auth.dart';
import 'package:companion/utils/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

import "package:shared_preferences/shared_preferences.dart";

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  void confirmLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm Logout"),
            content: Text("Do you want to log out of your account?"),
            actions: [
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Confirm")),
              FlatButton(
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel")),
            ],
          );
        }).then((value) async {
      if (value) {
        FirebaseService service = new FirebaseService();
        await service.signOut();
        Navigator.pushReplacementNamed(context, Constants.signInNavigate);
      }
    });
  }

  String userName = "";
  String userAvatar = "";

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((s) {
      print("hello");
      setState(() {
        userName = s.getString("name") as String;
        userAvatar = s.getString("profileImage") as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(83, 109, 254, 1),
            ),
            child: Column(
              children: [
                SizedBox(height: AppBar().preferredSize.height),
                ListTile(
                  // tileColor: Color.fromRGBO(83, 109, 254, 1),
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userAvatar),
                  ),
                  title: Text(
                    userName,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.person,
          //     color: Color.fromRGBO(83, 109, 254, 1),
          //   ),
          //   title: const Text("Profile"),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, Constants.profilePage);
          //   },
          // ),
          ListTile(
            leading: const Icon(
              AntDesign.logout,
              color: Color.fromRGBO(83, 109, 254, 1),
            ),
            title: const Text("Logout"),
            onTap: () {
              confirmLogout(context);
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'UnW;ind',
                  style: TextStyle(
                    color: Color.fromRGBO(83, 109, 254, 1),
                    fontSize: 25,
                    fontFamily: "Rancho",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
