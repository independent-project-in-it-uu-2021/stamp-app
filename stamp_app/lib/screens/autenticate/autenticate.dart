import 'package:flutter/material.dart';
import 'package:stamp_app/screens/login/loggain.dart';
import 'package:stamp_app/screens/createAccount/create-acount.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  //Function used to toggle between create acound and login screen
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogIn(toggleFunc: toggleView);
    } else {
      return CreateAccount(toggleFunc: toggleView);
    }
  }
}
