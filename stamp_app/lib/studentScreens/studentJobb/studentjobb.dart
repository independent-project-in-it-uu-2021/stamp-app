import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';
import 'package:stamp_app/sharedWidget/iconForWorkFeed.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/services/database.dart';

class StudentWork extends StatefulWidget {
  @override
  _StudentWorkState createState() => _StudentWorkState();
}

class _StudentWorkState extends State<StudentWork> {
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

  Widget showTheStudentJobs() {
    List<Jobs> theStudentJobs = [];

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String curTitle = theStudentJobs[index].title;
          //String curDescription = allJobs[index].description;
          String curDate = theStudentJobs[index].date;
          String curTime = theStudentJobs[index].time;
          String curEndTime = theStudentJobs[index].endTime;
          String curLocation = theStudentJobs[index].location;
          int curCount = theStudentJobs[index].count;
          int curMaxCount = theStudentJobs[index].maxCount;
          int curReserveCount = theStudentJobs[index].reserveCount;
          String curJobCategory = theStudentJobs[index].category;
          return Card(
            child: ListTile(
              leading: IconForWorkFeed(jobCategory: curJobCategory),
              subtitle: Text(
                  '$curTime - $curEndTime \n$curLocation \nStudenter: $curCount/$curMaxCount \nReserver: $curReserveCount'),
              onTap: () {},
            ),
          );
        });
  }

  // Returns a listviewbuilder for all the jobs
  Widget _buildAllJobs(List<Jobs> allJobs, String userID) {
    allJobs.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: allJobs.length,
        itemBuilder: (BuildContext context, int index) {
          String curTitle = allJobs[index].title;
          //String curDescription = allJobs[index].description;
          String curDate = allJobs[index].date;
          String curTime = allJobs[index].time;
          String curEndTime = allJobs[index].endTime;
          String curLocation = allJobs[index].location;
          int curCount = allJobs[index].count;
          int curMaxCount = allJobs[index].maxCount;
          int curReserveCount = allJobs[index].reserveCount;
          String curJobCategory = allJobs[index].category;
          return Card(
            child: ListTile(
              //leading: Icon(Icons.arrow_forward_ios),
              leading: IconForWorkFeed(
                jobCategory: curJobCategory,
              ),
              title: Text('$curDate $curTitle'), //Aligna med hjälp av textspan
              subtitle: Text(
                  '$curTime - $curEndTime \n$curLocation \nStudenter: $curCount/$curMaxCount \nReserver: $curReserveCount'),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalStudentChoice(
                      curJob: allJobs[index],
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
    return Container(
      child: FutureBuilder(
          future: locator.get<DatabaseService>().getAllUsers(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
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
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),*/
                        Padding(
                          padding: EdgeInsets.only(top: 10),
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
                        Padding(
                          padding: EdgeInsets.only(top: 30),
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
                        _buildAllJobs(allJobsFromDatabase, curUser.uid),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return LoadingScreen();
            }
          }),
    );
  }
}
