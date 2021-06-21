import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';
import 'package:stamp_app/models/jobsModel.dart';

bool _pressedButton1 = false;
bool _pressedButton2 = false;
bool _pressedButton3 = false;
bool _pressedButton4 = false;
bool _pressedButton5 = false;
bool _pressedButton6 = false;

class Choice extends StatefulWidget {
  final title;
  final description;
  final date;
  final time;
  final endTime;
  final location;
  final count;
  final maxCount;
  final reserveCount;

  Choice({
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
  State<StatefulWidget> createState() {
    return ChoiceState();
  }
}

class ChoiceState extends State<Choice> {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    final allJobs = Provider.of<List<Jobs>>(context) ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Välj Studentambassadörer'),
        backgroundColor: Colors.red.shade900,
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
                          children: [
                            Text(
                              widget.title.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.date.toString(),
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              widget.time.toString() +
                                  ' - ' +
                                  widget.endTime.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.location.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Expanded(
                          child: Text(
                            widget.description.toString(),
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),

                Text(
                  'Intresseanmälningar',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Studenter: ' +
                      widget.count.toString() +
                      ' / ' +
                      widget.maxCount.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Reserver: ' + widget.reserveCount.toString(),
                  style: TextStyle(fontSize: 20),
                ),

                /*TextButton(
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
                ),*/
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 209,
                      child: FlatButton(
                        onPressed: () => {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: Colors.white,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            Image.asset(
                              'assets/images/profilbild.png',
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                            Text(
                              'Sixten Andersson',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Acceptera',
                              style: TextStyle(
                                  color: _pressedButton1
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton1
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton1 = !_pressedButton1;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Reservera',
                              style: TextStyle(
                                  color: _pressedButton2
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton2
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton2 = !_pressedButton2;
                              })
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 209,
                      child: FlatButton(
                        onPressed: () => {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: Colors.white,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            Image.asset(
                              'assets/images/profilbild.png',
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                            Text(
                              'Kalle Hansson',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Acceptera',
                              style: TextStyle(
                                  color: _pressedButton3
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton3
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton3 = !_pressedButton3;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Reservera',
                              style: TextStyle(
                                  color: _pressedButton4
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton4
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton4 = !_pressedButton4;
                              })
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 209,
                      child: FlatButton(
                        onPressed: () => {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: Colors.white,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            Image.asset(
                              'assets/images/profilbild.png',
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                            Text(
                              'Agnes Brorson',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Acceptera',
                              style: TextStyle(
                                  color: _pressedButton5
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton5
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton5 = !_pressedButton5;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Container(
                          width: 85,
                          height: 35,
                          child: RaisedButton(
                            child: new Text(
                              'Reservera',
                              style: TextStyle(
                                  color: _pressedButton6
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,

                            // 2
                            color: _pressedButton6
                                ? Colors.red.shade900
                                : Colors.white,

                            // 3
                            onPressed: () => {
                              setState(() {
                                _pressedButton6 = !_pressedButton6;
                              })
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
              ),
              child: Text(
                'Nästa Steg',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinalChoice(
                          title: widget.title,
                          description: widget.description,
                          date: widget.date,
                          time: widget.time,
                          endTime: widget.endTime,
                          location: widget.location,
                          count: widget.count,
                          maxCount: widget.maxCount,
                          reserveCount: widget.reserveCount)),
                ),
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
      ),
    );
  }
}
