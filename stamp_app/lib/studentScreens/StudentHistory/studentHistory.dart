import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/iconForWorkFeed.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';

class StudentHistory extends StatefulWidget {
  @override
  _StudentHistoryState createState() => _StudentHistoryState();
}

class _StudentHistoryState extends State<StudentHistory> {
  Map _studentJobs = {};

  //Builds all the job that are older than today
  Widget _buildOldStudentJobs(String currentUserID) {
    final allTheJobs = Provider.of<List<Jobs>>(context) ?? [];
    DateTime dateNow = DateTime.now();
    String todaysDate = '${dateNow.day}-${dateNow.month}-${dateNow.year}';

    List studentJobsKey = _studentJobs.keys.toList();
    List<Jobs> studentJobs = [];
    List<Jobs> oldJobs = [];

    if (studentJobsKey.length == 0) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 12,
        ),
        // TODO: Maybe change the this
        Text(
          'Inget historik att visa',
          style: TextStyle(fontSize: 18.0),
        )
      ]);
    } else {
      // Filter out the jobs that the student is either selected or reserved
      studentJobsKey.forEach((curJobID) {
        List<Jobs> curJob =
            allTheJobs.where((curJob) => curJob.jobID == curJobID).toList();
        studentJobs.addAll(curJob);
      });
      // Sort according to job date
      studentJobs.sort((a, b) {
        return a.date.compareTo(b.date);
      });

      oldJobs.addAll(studentJobs);
      studentJobs.forEach((curJob) {
        /*print(

            'Compare todays date with curJob ${curJob.date.compareTo(todaysDate)}');*/
        if (todaysDate.compareTo(curJob.date) == 1) {
          print('Inside if-statement');
          oldJobs.add(curJob);
        }
      });

      //print('OldJobs length is: ${oldJobs.length}');

      // Build a listview
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //TODO: Change the length below
          itemCount: studentJobsKey.length,
          itemBuilder: (BuildContext context, int index) {
            String curTitle = studentJobs[index].title;
            String curDate = studentJobs[index].date;
            String curTime = studentJobs[index].time;
            String curEndTime = studentJobs[index].endTime;
            String curLocation = studentJobs[index].location;
            String curJobCategory = studentJobs[index].category;
            String msg;

            // If user is accepted Antaget message is shown otherwise Reserv
            (studentJobs[index].currentAccepted.containsKey(currentUserID))
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
                        curJob: studentJobs[index],
                      ),
                    ),
                  );
                },
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final streamJobs = Provider.of<List<Jobs>>(context) ?? [];
    return FutureBuilder(
      future:
          locator.get<DatabaseService>().getUserFromDatabase(currentUser.uid),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          //String name = snapshot.data['userName'];
          UserData userData = snapshot.data;
          _studentJobs = snapshot.data.jobs;

          return Scaffold(
            appBar: AppBar(
              title: Text('Historik'),
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
                      'Avslutade  Jobb',
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
                    //_buildOldStudentJobs(currentUser.uid),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      'Ingen historik att visa',
                      style: TextStyle(fontSize: 25),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                  ],
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
