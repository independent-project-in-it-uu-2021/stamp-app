import 'package:flutter/material.dart';

class InactiveHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(
          'Meny',
          style: TextStyle(fontSize: 33),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Text(
          'Ditt konto behöver aktiveras',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
