import 'package:flutter/material.dart';

import 'package:stamp_app/services/auth.dart';

class InactiveHome extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        leadingWidth: 117,
        leading: TextButton.icon(
          onPressed: () async {
            await _firebaseAuth.signOutUser();
          },
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          label: Text(
            'Logga ut',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
