import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';

class ShowWork extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Välj Studentambassadörer'),
        backgroundColor: Colors.red.shade900,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: null,
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 120),
                ),
                Text(
                  '[Jobbinformation]',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 130),
                ),
                Text(
                  'Intresseanmälningar',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 26),
                    primary: Colors.blue,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OthersProfile()),
                    )
                  },
                  child: const Text('[Studentambassadörer]'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
