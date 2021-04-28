import 'package:flutter/material.dart';
import 'package:stamp_app/screens/wrapper.dart';
import './loggain.dart';

import './create-acount.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
      title: 'Registrera konto',
      //home: CreateAccount(),
    );
  }
}
