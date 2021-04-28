import 'package:flutter/material.dart';
import './loggain.dart';

import './create-acount.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrera konto',
      //home: CreateAccount(),
    );
  }
}
