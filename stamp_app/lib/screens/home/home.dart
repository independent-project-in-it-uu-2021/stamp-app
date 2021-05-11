import 'package:flutter/material.dart';

import 'package:stamp_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    // Streamproivder listen to stream and exposes its content to child
    return Scaffold(
      appBar: AppBar(
        title: Text('Hem'),
        backgroundColor: Colors.red.shade900,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _firebaseAuth.signOutUser();
            },
            icon: Icon(Icons.person),
            label: Text('Logga ut'),
          )
        ],
      ),
    );
  }
}
