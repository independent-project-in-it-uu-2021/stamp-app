import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            ),
            Text(
              'Meny',
              style: TextStyle(
                fontSize: 33,
              ),
            ),
            FlatButton.icon(
              padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
              onPressed: () async {
                await _firebaseAuth.signOutUser();
              },
              icon: Icon(
                Icons.chat_bubble_rounded,
                color: Colors.white,
                size: 35,
              ),
              label: Text(''),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            ),
            //Button to go to Job page
            Container(
              height: 100,
              width: 330,
              child: FlatButton(
                onPressed: () => {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: Colors.white,
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Icon(
                      Icons.event_rounded,
                      size: 60,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(45, 0, 0, 0)),
                    Text(
                      "Jobb",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            //Button to get to Profile page
            Container(
              height: 100,
              width: 330,
              child: FlatButton(
                onPressed: () => {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: Colors.white,
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Icon(
                      Icons.person,
                      size: 60,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(45, 0, 0, 0)),
                    Text(
                      "Profil",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            //Button for previous jobs
            Container(
              height: 100,
              width: 330,
              child: FlatButton(
                onPressed: () => {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: Colors.white,
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Icon(
                      Icons.done,
                      size: 60,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(45, 0, 0, 0)),
                    Text(
                      "Historik",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            //Button for Accounts
            Container(
              height: 100,
              width: 330,
              child: FlatButton(
                onPressed: () => {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: Colors.white,
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                    Icon(
                      Icons.person_add,
                      size: 60,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                    Text(
                      "Hantera konton",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
