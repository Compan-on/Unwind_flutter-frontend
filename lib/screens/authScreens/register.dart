import 'package:companion/services/auth.dart';
import 'package:companion/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  
  final Function toggleView;
  RegisterPage({required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseService _authService = FirebaseService();

  bool isLoading = false;
  bool _isEditing = false;

  String email = "";
  String password = "";

  late TextEditingController textControllerPassword;
  late TextEditingController textControllerEmail;

  final _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    textControllerEmail = TextEditingController(text: email);
    textControllerPassword = TextEditingController(text: password);
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.kPrimaryColor,
        body: SingleChildScrollView(
          child: Center(
              child:
                  Form(
                    key: _formKey,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(height: size.height * 0.5),
                              Image.asset("assets/images/sign-in.png"),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: Constants.textSignInTitle,
                        style: TextStyle(
                          color: Constants.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                                  ])),
                              SizedBox(height: size.height * 0.01),
                              Text(
                                Constants.textSmallSignIn,
                                style: TextStyle(color: Constants.kDarkGreyColor),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                              SizedBox(
                                width: size.width * 0.8,
                                child: TextFormField(
                                  validator:(val) => val!.isEmpty ? 'Enter an email' : null,
                                  controller: textControllerEmail,
                                   
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        enabledBorder: border,
                        focusedBorder: border,
                        labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                      ),
                        ),
                        onChanged: (val) => setState(() {
                      _isEditing = true;
                      email = val;
                    }),
                        ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                width: size.width * 0.8,
                                child: TextFormField(
                                  validator: (val) => val!.length < 6 ? 'Enter a password atleast 6 characters long':null,
                                  obscureText: true,
                                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    enabledBorder: border,
                    focusedBorder: border,
                     labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                      ),
                    suffixIcon: Padding(
                      child: FaIcon(
                        FontAwesomeIcons.eye,
                        size: 15,
                      ),
                      padding: EdgeInsets.only(top: 15, left: 15),
                    ),
                                  ),
                                  onChanged: (val) => setState(() {
                    _isEditing = true;
                    password = val;
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                width: size.width * 0.8,
                                child: OutlinedButton(
                                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if(_formKey.currentState!.validate()){
                        dynamic result = await _authService.signUp(email, password);
                        if(result == null){
                            ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: 
                                      Text("Invalid email or password.")));
                        }else{
                          Navigator.pushReplacementNamed(context, Constants.registerPage1);
                        }
                    }
                    
                    setState(() {
                      isLoading = false;
                    });
                                  },
                                  child: Text(Constants.textSignUp),
                                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Constants.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                                ),
                              ),
                             Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                              SizedBox(
                                width: size.width * 0.8),
                                InkWell(
                                  onTap: () {
                                      widget.toggleView();
                                  },
                                  child: Row(
                                    mainAxisAlignment : MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an account? "),
                                      Text(
                                        'Sign in.',
                                        style: TextStyle(
                                          color : Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ), 
                            ]),
                  )),
        ));
  }

}