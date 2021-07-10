import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/buildJobInfor.dart';

class FinalStudentChoice extends StatefulWidget {
  final Jobs curJob;

  FinalStudentChoice({
    Key key,
    @required this.curJob,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FinalStudentChoiceState();
  }
}

class FinalStudentChoiceState extends State<FinalStudentChoice> {
  Jobs currentJob;
  String jobID;
  String title;
  String description;
  String date;
  String time;
  String endTime;
  String location;
  int count;
  int maxCount;
  int reserveCount;
  String category;

  @override
  void initState() {
    super.initState();
    currentJob = widget.curJob;
    jobID = widget.curJob.jobID;
    title = widget.curJob.title;
    description = widget.curJob.description;
    date = widget.curJob.date;
    time = widget.curJob.time;
    endTime = widget.curJob.endTime;
    location = widget.curJob.location;
    count = widget.curJob.count;
    maxCount = widget.curJob.maxCount;
    reserveCount = widget.curJob.reserveCount;
    category = widget.curJob.category;
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: _currentUser.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String curUserID = _currentUser.uid;
          String curUserName = snapshot.data.name;
          String curUserProfileImage = snapshot.data.imageUrl;
          return Scaffold(
            appBar: AppBar(
              title:
                  Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
              //centerTitle: true,
              backgroundColor: Colors.red.shade900,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
                      // Builds job information
                      BuildJobInformation(curJob: currentJob),

                      Text(
                        'Intresseanmälningar',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('Du har anmält intresse',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          )),
                      Padding(padding: EdgeInsets.only(top: 10)),
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
                      FlatButton(
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
                      FlatButton(
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
                      FloatingActionButton.extended(
                        backgroundColor: Colors.green,
                        onPressed: () async {
                          final result = await locator
                              .get<DatabaseService>()
                              .showInterestJob(jobID, curUserID, curUserName,
                                  curUserProfileImage);
                          print('Show interest button');
                          print(result);
                        },
                        label: Text(
                          'Anmäl intresse',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Roboto'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
