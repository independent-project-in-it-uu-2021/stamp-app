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
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              iconSize: 45,
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              icon: Icon(Icons.favorite),
              // TODO: Change onpressed
              onPressed: null,
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
