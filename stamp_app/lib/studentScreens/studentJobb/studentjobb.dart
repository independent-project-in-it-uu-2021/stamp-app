import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';
import 'package:stamp_app/studentScreens/studentIntresse/studentIntresse.dart';
import 'package:stamp_app/sharedWidget/iconForWorkFeed.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:stamp_app/services/database.dart';

class StudentWork extends StatefulWidget {
  @override
  _StudentWorkState createState() => _StudentWorkState();
}

class _StudentWorkState extends State<StudentWork> {
  Map studentsCurrentJob = {};
  String currentUserID;
  // Not in used
  // When use, MaterialApp has change to GetMaterialApp in main
  /*void topSnackBar() {
    Get.snackbar(
      'Test Test',
      '',
      duration: Duration(seconds: 4),
      animationDuration: Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey,
      
    );
  }*/

  // Builds the jobs where the student is either accepted or is reserved
  Widget showTheStudentJobs(List<Jobs> allTheJobs, Map studentJobs) {
    List studentJobsKey = studentJobs.keys.toList();
    List<Jobs> theStudentJobs = [];

    // Find all the jobs where the user is either accepted or is reserved
    studentJobsKey.forEach((studentJobID) {
      List<Jobs> curJob =
          allTheJobs.where((element) => element.jobID == studentJobID).toList();
      theStudentJobs.addAll(curJob);
    });

    // Sort the jobs according to date
    theStudentJobs.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: studentJobsKey.length,
        itemBuilder: (context, index) {
          String curTitle = theStudentJobs[index].title;
          String curDate = theStudentJobs[index].date;
          String curTime = theStudentJobs[index].time;
          String curEndTime = theStudentJobs[index].endTime;
          String curLocation = theStudentJobs[index].location;
          String curJobCategory = theStudentJobs[index].category;
          String msg;

          // If user is accepted Antaget message is shown otherwise Reserv
          (theStudentJobs[index].currentAccepted.containsKey(currentUserID))
              ? msg = 'Antagen'
              : msg = 'Reserv';

          return Card(
            child: ListTile(
              leading: IconForWorkFeed(jobCategory: curJobCategory),
              title: Text(
                '$curDate $curTitle',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('$curTime - $curEndTime \n$curLocation '),
                    Text(
                      msg,
                      style: TextStyle(
                          color: msg == 'Antagen'
                              ? Colors.green.shade600
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalStudentChoice(
                      curJob: theStudentJobs[index],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  // Returns a listviewbuilder for all the jobs
  Widget _buildAllJobs(List<Jobs> allJobs, String userID, Map studentJobs) {
    Map test = {};
    List studentKeyJobs = studentJobs.keys.toList();
    List<Jobs> vacantJobs = [];
    vacantJobs.addAll(allJobs);
    //List<Jobs> curJob = [];

    studentKeyJobs.forEach((curJobID) {
      vacantJobs.removeWhere((element) => element.jobID == curJobID);
    });

    print('Vacant jobs length ');
    print(vacantJobs.length);
    vacantJobs.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: vacantJobs.length,
        itemBuilder: (BuildContext context, int index) {
          String curTitle = vacantJobs[index].title;
          //String curDescription = allJobs[index].description;
          String curDate = vacantJobs[index].date;
          String curTime = vacantJobs[index].time;
          String curEndTime = vacantJobs[index].endTime;
          String curLocation = vacantJobs[index].location;
          int curCount = vacantJobs[index].count;
          int curMaxCount = vacantJobs[index].maxCount;
          int curReserveCount = vacantJobs[index].reserveCount;
          String curJobCategory = vacantJobs[index].category;
          return Card(
            child: ListTile(
              //leading: Icon(Icons.arrow_forward_ios),
              leading: IconForWorkFeed(
                jobCategory: curJobCategory,
              ),
              title: Text(
                '$curDate $curTitle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ), //Aligna med hjälp av textspan
              subtitle: Text(
                  '$curTime - $curEndTime \n$curLocation \nStudenter: $curCount/$curMaxCount \nReserver: $curReserveCount'),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentChoice(
                      curJob: vacantJobs[index],
                    ),
                  ),
                );
                if (result == 'Du har anmält intresse') {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.info(
                        message: '$result',
                        backgroundColor: Colors.grey,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Roboto'),
                        icon: Icon(
                          Icons.ac_unit,
                          size: 0,
                        )),
                  );
                }
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Stream of all the jobs from database
    final allJobsFromDatabase = Provider.of<List<Jobs>>(context) ?? [];
    final curUser = Provider.of<User>(context);
    currentUserID = curUser.uid;
    if (curUser != null) {
      return StreamBuilder<UserData>(
          stream: DatabaseService(userId: curUser.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              studentsCurrentJob = snapshot.data.jobs;

              return Scaffold(
                appBar: AppBar(
                  title: Text('Jobb'),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          'Dina Jobb',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.001,
                            width: MediaQuery.of(context).size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        showTheStudentJobs(
                            allJobsFromDatabase, studentsCurrentJob),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          'Lediga Jobb',
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
                        _buildAllJobs(allJobsFromDatabase, curUser.uid,
                            studentsCurrentJob),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return LoadingScreen();
            }
          });
    } else {
      return LoadingScreen();
    }
  }
}
