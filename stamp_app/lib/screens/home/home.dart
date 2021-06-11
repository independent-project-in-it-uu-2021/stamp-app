import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/screens/profil/profil.dart';
import 'package:stamp_app/screens/konton/hanteraKonton.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/profil/profil.dart';
import 'package:stamp_app/screens/historik/historik.dart';
import 'package:stamp_app/studentScreens/StudentHome/studentHome.dart';
import 'package:stamp_app/screens/jobb/jobs.dart';

class Home extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    // Streamproivder listen to stream and exposes its content to child
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.red.shade900,
        title: Text(
          'Meny',
          style: TextStyle(
            fontSize: 33,
          ),
        ),
        centerTitle: true,
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
        /*actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: null,
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],*/
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            ),

            //Button to go to Job page
            Container(
              height: 100,
              width: 330,
              child: FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Works()),
                  ),
                },
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  )
                },
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  )
                },
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
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageAccount()),
                  )
                },
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
            Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
