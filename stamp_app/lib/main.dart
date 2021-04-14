import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
          centerTitle: true,
          backgroundColor: Colors.red.shade900,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            // TODO: Change this
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Tillbaka',
          ),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
