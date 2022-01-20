import 'package:companion/services/auth.dart';
import 'package:companion/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  
  final Function toggleView;
  SignInPage({required this.toggleView});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                      SizedBox(height: size.height * 0.1),
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
                        dynamic result = await _authService.signIn(email, password);
                        if(result == null){
                            ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: 
                                      Text("Invalid email or password. Try signing up if you are a new user.")));
                        }
                        else{
                          Navigator.pushNamed(context, Constants.homeNavigate);
                         }
                    }
                    
                    setState(() {
                      isLoading = false;
                    });
                                  },
                                  child: Text(Constants.textSignIn),
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
                                      Text("Do not have an account yet? "),
                                      Text(
                                        'Sign up.',
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

  // Widget buildRowDivider({required Size size}) {
  //   return SizedBox(
  //     width: size.width * 0.8,
  //     child: Row(children: <Widget>[
  //       Expanded(child: Divider(color: Constants.kDarkGreyColor)),
  //       Padding(
  //           padding: EdgeInsets.only(left: 8.0, right: 8.0),
  //           child: Text(
  //             "Or",
  //             style: TextStyle(color: Constants.kDarkGreyColor),
  //           )),
  //       Expanded(child: Divider(color: Constants.kDarkGreyColor)),
  //     ]),
  //   );
  // }
}

// class GoogleSignIn extends StatefulWidget {
//   GoogleSignIn({Key? key}) : super(key: key);

//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }

// class _GoogleSignInState extends State<GoogleSignIn> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return !isLoading
//         ? SizedBox(
//             width: size.width * 0.8,
//             child: OutlinedButton.icon(
//               icon: FaIcon(FontAwesomeIcons.google),
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 FirebaseService service = new FirebaseService();
//                 try {
//                   await service.signInwithGoogle();
//                   Navigator.pushNamed(
//                       context, Constants.registerPage1);
//                 } catch (e) {
//                   if (e is FirebaseAuthException) {
//                     showMessage(e.message!);
//                   }
//                 }
//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               label: Text(
//                 Constants.textSignInGoogle,
//                 style: TextStyle(
//                     color: Constants.kBlackColor, fontWeight: FontWeight.bold),
//               ),
//               style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Constants.kGreyColor),
//                   side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
//             ),
//           )
//         : CircularProgressIndicator();
//   }

//   void showMessage(String message) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
