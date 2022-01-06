import 'package:companion/services/auth.dart';
import 'package:companion/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseService _authService = FirebaseService();

  bool isLoading = false;
  String email = "";
  String password = "";
  GlobalKey globalKey = GlobalKey();

 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.kPrimaryColor,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          //GoogleSignIn(),
          buildRowDivider(size: size),
          Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
          SizedBox(
            width: size.width * 0.8,
            key: globalKey,
            child: TextField(
              onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            RenderObject? object = globalKey.currentContext?.findRenderObject();
                            object?.showOnScreen();
                          },
                onChanged: (val) => setState(() {
                  email = val;
                }),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    enabledBorder: border,
                    focusedBorder: border)),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: TextField(
              onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            RenderObject? object = globalKey.currentContext!.findRenderObject();
                            object!.showOnScreen();
                          },
              onChanged: (val) => setState(() {
                password = val;
              }),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                enabledBorder: border,
                focusedBorder: border,
                suffixIcon: Padding(
                  child: FaIcon(
                    FontAwesomeIcons.eye,
                    size: 15,
                  ),
                  padding: EdgeInsets.only(top: 15, left: 15),
                ),
              ),
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
                //FirebaseService service = new FirebaseService();
                try {
                  await _authService.signUp(email, password);
                  Navigator.pushNamed(
                      context, Constants.registerPage1);
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    print(e);
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
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton(
              onPressed: () async {
                _authService.signIn(email,password);
                Navigator.pushNamed(context, Constants.homeNavigate);
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
          
        ])));
  }

  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
              style: TextStyle(color: Constants.kDarkGreyColor),
            )),
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
      ]),
    );
  }
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
