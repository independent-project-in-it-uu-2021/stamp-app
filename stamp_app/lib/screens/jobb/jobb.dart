import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/models/jobsModel.dart';

class Work extends StatelessWidget {
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
          case 'Studie besök':
            return Icon(Icons.ac_unit_sharp);
            break;
          default:
            return Icon(Icons.smart_toy);
        }
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Icon(Icons.smart_toy);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Inside works build');

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

          return Card(
            child: ListTile(
              //leading: Icon(Icons.arrow_forward_ios),
              leading: _buildCategoryIcon(jobCategory),
              title: Text('$date $title'), //Aligna med hjälp av textspan
              subtitle: Text(
                  '$time - $endTime \n$location \nStudenter: $count/$maxCount \nReserver: $reserveCount'),
              onTap: () => {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Choice(
                        title: title,
                        description: description,
                        date: date,
                        time: time,
                        endTime: endTime,
                        location: location,
                        count: count,
                        maxCount: maxCount,
                        reserveCount: reserveCount),
                  ),
                )*/
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
