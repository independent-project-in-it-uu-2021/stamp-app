import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.red.shade900,
        title: Row(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _firebaseAuth.signOutUser();
              },
              icon: Icon(Icons.person),
              label: Text('Logga ut'),
            ),
            Text('Meny'),
            FlatButton.icon(
              padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
              onPressed: () async {
                await _firebaseAuth.signOutUser();
              },
              icon: Icon(Icons.chat_bubble_rounded),
              label: Text(''),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red.shade900,
    );
  }
}
