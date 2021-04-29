import 'package:flutter/material.dart';
import 'package:stamp_app/screens/createAccount/create-acount.dart';
//import 'package:stamp_app/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Wrapper(),
      title: 'Registrera konto',
      home: CreateAccount(),
    );
  }
}
