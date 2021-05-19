import 'package:flutter/material.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/screens/profil/profil.dart';

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
      drawer: Drawer(
        child: Container(
          color: Colors.grey,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                enabled: true,
                contentPadding: EdgeInsets.only(left: 18.0, top: 20.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
