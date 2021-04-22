import 'package:flutter/material.dart';

import './create-acount.dart';
import './create-jobb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skapa jobb',
      home: CreateJob(),
    );
  }
}
