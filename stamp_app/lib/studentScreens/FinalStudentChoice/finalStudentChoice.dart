import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';

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

  // Returns different typ of icon depending on category
  Widget _buildCategoryIcon(String jobCategory) {
    if (jobCategory != null && jobCategory.isNotEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        switch (jobCategory) {
          case 'Workshop':
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          case 'Studiebesök':
            return Icon(
              Icons.ac_unit_sharp,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          default:
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
        }
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Icon(Icons.smart_toy);
      });
    }
  }

  // Build method for show job information
  Widget _buildJobInformation() {
    // Size of the screen used to the text size is responsive
    MediaQueryData screenSize = MediaQuery.of(context);
    double fontSizeJobInfo = screenSize.size.width * 0.046;
    return Column(
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
                _buildCategoryIcon(category),
                Padding(padding: EdgeInsets.only(left: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenSize.size.width * 0.055,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text('Tid: ' + time + '-' + endTime,
                        style: TextStyle(fontSize: fontSizeJobInfo),
                        textAlign: TextAlign.left),
                    Text('Datum: ' + date,
                        style: TextStyle(fontSize: fontSizeJobInfo),
                        textAlign: TextAlign.left),
                    Text(
                      'Studenter: ' +
                          count.toString() +
                          '/' +
                          maxCount.toString() +
                          ' st',
                      style: TextStyle(fontSize: fontSizeJobInfo),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Reserver: ' + reserveCount.toString() + ' st',
                      style: TextStyle(fontSize: fontSizeJobInfo),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 30)),
                Expanded(
                  child: Text(
                    description.toString(),
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
      ],
    );
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
                      // Calls the method from above, shows job information
                      _buildJobInformation(),

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
