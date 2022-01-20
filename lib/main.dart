import 'package:companion/navigation/navigation.dart';
import "package:flutter/services.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'services/auth.dart';
import 'utils/constants.dart';
import 'utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<userModel?>.value(
      value: FirebaseService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.title,
        initialRoute: '/',
        routes: Navigate.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
