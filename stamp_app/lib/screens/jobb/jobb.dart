import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/iconForWorkFeed.dart';

class Work extends StatelessWidget {
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
          // Sort the jobs according to date
          allJobs.sort((a, b) {
            return a.date.compareTo(b.date);
          });
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

          return Card(
            child: ListTile(
              //leading: Icon(Icons.arrow_forward_ios),
              leading: IconForWorkFeed(jobCategory: jobCategory),
              title: Text(
                '$date $title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ), //Aligna med hjälp av textspan
              subtitle: Text(
                  '$time - $endTime \n$location \nStudenter: $count/$maxCount \nReserver: $reserveCount'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Choice(
                      curJob: allJobs[index],
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
