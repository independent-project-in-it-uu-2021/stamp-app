import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';

class Work extends StatelessWidget {
  // Returns different typ of icon depending on category
  Widget _buildCategoryIcon(String jobCategory) {
    if (jobCategory != null && jobCategory.isNotEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        switch (jobCategory) {
          case 'Workshop':
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
            break;
          case 'Studiebesök':
            return Icon(
              Icons.ac_unit_sharp,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
            break;
          default:
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
        }
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Icon(
          Icons.account_balance_sharp,
          size: MediaQuery.of(context).size.height * 0.07,
          color: Colors.black,
        );
      });
    }
  }

  // Creates a list of userJob (i.e. userid, username and if selected) object
  List<UserJob> shownInterestList(Map userMap) {
    List<UserJob> theList = [];
    userMap.forEach(
      (key, value) {
        theList.add(
          UserJob(
            userID: key,
            userName: value['userName'],
            profilePickLink: value['userProfilePicUrl'],
            isSelected: false,
          ),
        );
      },
    );
    return theList;
  }

  @override
  Widget build(BuildContext context) {
    final allJobs = Provider.of<List<Jobs>>(context) ?? [];

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
      body: ListView.builder(
        itemCount: allJobs.length,
        itemBuilder: (BuildContext context, int index) {
          String title = allJobs[index].title;
          String description = allJobs[index].description;
          String date = allJobs[index].date;
          String time = allJobs[index].time;
          String endTime = allJobs[index].endTime;
          String location = allJobs[index].location;
          int count = allJobs[index].count;
          int maxCount = allJobs[index].maxCount;
          int reserveCount = allJobs[index].reserveCount;
          String jobCategory = allJobs[index].category;
          List<UserJob> curUsersInterestList =
              shownInterestList(allJobs[index].currentInterest);

          return Card(
            child: ListTile(
              //leading: Icon(Icons.arrow_forward_ios),
              leading: _buildCategoryIcon(jobCategory),
              title: Text('$date $title'), //Aligna med hjälp av textspan
              subtitle: Text(
                  '$time - $endTime \n$location \nStudenter: $count/$maxCount \nReserver: $reserveCount'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Choice(
                      curJob: allJobs[index],
                      //usersInterestList: curUsersInterestList,
                    ),
                  ),
                )
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateJob()),
          )
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
