import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hem'),
        backgroundColor: Colors.red.shade900,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _firebaseAuth.SignOutUser();
            },
            icon: Icon(Icons.person),
            label: Text('Logga ut'),
          )
        ],
      ),
    );
  }
}
