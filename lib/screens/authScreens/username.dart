import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/services/database.dart';
import 'package:companion/utils/constants.dart';
import 'package:companion/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class usernamePage extends StatefulWidget {
  usernamePage({Key? key}) : super(key: key);

  @override
  _usernamePageState createState() => _usernamePageState();
}

class _usernamePageState extends State<usernamePage> {

  @override
  Database database = Database();

  late TextEditingController textControllerName;
  late FocusNode textFocusNode;
  bool _isEditing = false;
  bool _isStoring = false;


  String imagePath = "assets/images/profileImage01.jpg";
  var name;

  String? _validateString(String value) {
    value = value.trim();

    if (textControllerName.text != null) {
      if (value.isEmpty) {
        return 'Name can\'t be empty';
      }
    }

    return null;
  }

  @override
  void initState() {
    textControllerName = TextEditingController(text: name);
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));


    return GestureDetector(
      onTap: () {
        textFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Constants.kPrimaryColor,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(imagePath),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                          focusNode: textFocusNode,
                          keyboardType: TextInputType.text,
                          controller: textControllerName,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              enabledBorder: border,
                              focusedBorder: border,
                              labelText: 'Name',
                                    labelStyle: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                    ),
                                    hintText: 'Enter a name',
                                    hintStyle: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                    errorText: _isEditing ? _validateString(textControllerName.text) : null,
                                    errorStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent,
                                    ),
                              ),
                              
                          onChanged: (value){
                            setState(() {
                              _isEditing = true;
                            });
                          },
                          onSubmitted: (value){
                            setState( () {
                              _isEditing = true;
                            });
                          },
                          
                        ),

                    ),
          SizedBox(
            height: size.height * 0.01,
          ),
          
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),

          SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton(
              onPressed: textControllerName.text.isNotEmpty
                                ? () async {
                                  textFocusNode.unfocus();
                                    setState(() {
                                      _isStoring = true;
                                    });

                                  final bool? valid = await usernameCheck(name);
                                  if(valid!){
                                    ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: 
                                      Text("Username already exists.Choose another.")));
                                  }
                                  else{
                                    
                                    await database
                                        .storeUserData(userName: textControllerName.text, profileImage: imagePath)
                                        .whenComplete(() => Navigator.pushReplacementNamed(context, Constants.homeNavigate))
                                        .catchError(
                                          (e) => print('Error in storing data: $e'),
                                        );
                                    await UserPreferences.storeUsername(textControllerName.text);
                                    await UserPreferences.storeProfileURL(imagePath);

                                  }
                                   setState(() {
                                      _isStoring = false;
                                    });
                                  }
                                : null,
              child: Text(Constants.textContinue),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.kBlackColor),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
            ),
          ),
          
        ]))));
  }

  Future<bool?> usernameCheck(String username) async {
    
    await Future.delayed(Duration(seconds: 1));
    if(username != name){
      print('No need to check');
      return null;
    }
    
    //final result = await FirebaseFirestore.instance.collection('users').get();
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: username)
          .limit(1)
          .get());
    
    final List<DocumentSnapshot> documents = result.docs;
    if(documents.length == 1){
      print("Username already exists");
      return false;
    }
    else{
      print("Username available");
      return true;
    }
  }
}