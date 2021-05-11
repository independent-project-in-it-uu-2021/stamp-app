import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    // Streamproivder listen to stream and exposes its content to child
    return StreamProvider<QuerySnapshot>.value(
      // TODO: Take care of the null value below
      initialData: null,
      value: DatabaseService().curDocument,
      child: Scaffold(
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
      ),
    );
  }
}
