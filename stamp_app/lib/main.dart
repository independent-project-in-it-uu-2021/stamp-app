import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Image.asset('assets/images/uuLoga.png'),
              onPressed: () => exit(0),
            ),
          ],
          //title: Text('Welcome to Flutter'),
          backgroundColor: Colors.red.shade900,
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
