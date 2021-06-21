import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';

class FinalChoice extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  final title;
  final description;
  final date;
  final time;
  final endTime;
  final location;
  final count;
  final maxCount;
  final reserveCount;

  FinalChoice({
    Key key,
    @required this.title,
    @required this.description,
    @required this.date,
    @required this.time,
    @required this.endTime,
    @required this.location,
    @required this.count,
    @required this.maxCount,
    @required this.reserveCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Icon(
                          Icons.smart_toy,
                          size: 70,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.title.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                                'Tid: ' +
                                    this.time.toString() +
                                    '-' +
                                    this.endTime.toString(),
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left),
                            Text('Datum: ' + this.date.toString(),
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left),
                            Text(
                              'Studenter: ' +
                                  this.count.toString() +
                                  '/' +
                                  this.maxCount.toString() +
                                  ' st',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Reserver: ' +
                                  this.reserveCount.toString() +
                                  ' st',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                    //Padding(padding: EdgeInsets.only(top: 40)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 30)),
                    Expanded(
                      child: Text(
                        this.description.toString(),
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                  'Valda',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),

                //Padding(padding: EdgeInsets.only(top: 20)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                //---------------
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Kalle Hansson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.only(top: 20),
                ),
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Agnes Brorson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.only(top: 20),
                ),
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Sixten Andersson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  'Reserver',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),

                Padding(padding: EdgeInsets.only(top: 20)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                //---------------
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Kalle Hansson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.only(top: 20),
                ),
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Agnes Brorson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.only(top: 20),
                ),
                FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: Colors.white,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      Image.asset(
                        'assets/images/profilbild.png',
                        fit: BoxFit.cover,
                        scale: 3,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                      Text(
                        'Sixten Andersson',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                  padding: EdgeInsets.only(top: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green[400],
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: Text(
                'Bekräfta',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
      ),
    );
  }
}
