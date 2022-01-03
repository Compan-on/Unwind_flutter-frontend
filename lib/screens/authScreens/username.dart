import 'package:companion/services/database.dart';
import 'package:companion/utils/constants.dart';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.kPrimaryColor,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: Constants.textUsername1,
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      TextSpan(
                          text: Constants.textUsername2,
                          style: TextStyle(
                              color: Constants.kDarkBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0)),
                    ])),
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

                                    await database
                                        .storeUserData(userName: textControllerName.text)
                                        .whenComplete(() => Navigator.pushNamed(context, Constants.registerPage2))
                                        .catchError(
                                          (e) => print('Error in storing data: $e'),
                                        );

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
  
}