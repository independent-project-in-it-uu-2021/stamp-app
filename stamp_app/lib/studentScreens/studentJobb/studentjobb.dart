import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';
import 'package:stamp_app/sharedWidget/iconForWorkFeed.dart';

class StudentWork extends StatelessWidget {
  // Returns a listviewbuilder for all the jobs
  Widget _buildAllJobs(List<Jobs> allJobs, String userID) {
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
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalStudentChoice(
                      curJob: allJobs[index],
                    ),
                  ),
                )
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
  }
}
