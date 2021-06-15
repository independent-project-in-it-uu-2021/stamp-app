import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/studentScreens/studentJobs/studentjobs.dart';
import 'package:stamp_app/models/jobsModel.dart';

class Work extends StatelessWidget {
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
          var title = allJobs[index].title;
          var date = allJobs[index].date;
          var time = allJobs[index].time;
          var location = allJobs[index].location;
          var count = allJobs[index].count;
          return Card(
            child: ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('$date $title'), //Aligna med hjälp av textspan
              subtitle: Text('$date \n$time - 13:30 \n$location \n$count'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Choice()),
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
