import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade900,
        appBar: AppBar(
          title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
          centerTitle: true,
          backgroundColor: Colors.red.shade900,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            // TODO: Change this
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Tillbaka',
          ),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60, bottom: 20),
          child: Text(
            'Registrera Konto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
