import 'package:flutter/material.dart';

import 'package:companion/services/auth.dart';
import 'package:companion/utils/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: AppBar().preferredSize.height),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn1.vectorstock.com/i/1000x1000/31/95/user-sign-icon-person-symbol-human-avatar-vector-12693195.jpg"),
            ),
            title: Text("Shivam Arora"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("User Profile"),
            onTap: () {
              Navigator.pushReplacementNamed(context, Constants.profilePage);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              confirmLogout(context);
            },
          ),
        ],
      ),
    );
  }
}
