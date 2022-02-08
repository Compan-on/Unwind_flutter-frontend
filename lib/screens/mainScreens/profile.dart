import 'package:companion/models/user.dart';
import 'package:companion/services/database.dart';
import 'package:companion/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  Database _databaseService = Database();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

    return MultiProvider(
        providers: [
          StreamProvider.value(
            value: _databaseService
                .getUser(FirebaseAuth.instance.currentUser!.uid),
            initialData: null,
          )
        ],
        child: Scaffold(
            backgroundColor: Constants.kPrimaryColor,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.network(
                    Provider.of<userModel>(context).profileImage ?? '',
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Text(
                      Provider.of<userModel>(context).name ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]))));
  }
}
