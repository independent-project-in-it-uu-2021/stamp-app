import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/services/database.dart';

class StudentProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentProfileState();
  }
}

class StudentProfileState extends State<StudentProfile> {
  String _userName = '';
  String _userNumber = '';
  String _userEmail = '';
  String _userBio = '';

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TODO: Check if an email is already used

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<User>(context);
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(userId: _currentUser.uid).userData,
      builder: (context, snapshot) {
        _userName = snapshot.data['userName'];
        _userNumber = snapshot.data['userPhoneNumber'];
        _userEmail = snapshot.data['userEmail'];
        _userBio = snapshot.data['userProgram'];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title:
                Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
            //centerTitle: true,
            backgroundColor: Colors.red.shade900,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              //TODO: This does nothing now
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Tillbaka',
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Text(
                      'Din profil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
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
                      padding: EdgeInsets.only(top: 15),
                    ),
                    Text(
                      _userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/profilbild.png',
                      fit: BoxFit.cover,
                      scale: 1.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
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
                      padding: EdgeInsets.only(top: 12),
                    ),
                    Text(
                      _userNumber,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
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
                      padding: EdgeInsets.only(top: 12),
                    ),
                    Text(
                      _userEmail,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
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
                      padding: EdgeInsets.only(top: 12),
                    ),
                    Text(
                      _userBio,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
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
                    Text(
                      'Senaste Jobb',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                    Text(
                      'Jobb 1',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                    Text(
                      'Jobb 2',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                    Text(
                      'Jobb 3',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: TextButton(
                          child: Text(
                            'Redigera profil',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccount()),
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
