import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/studentScreens/studentJobs/studentjobs.dart';
import 'package:stamp_app/models/jobsModel.dart';

var icon = ''; //TODO: oklart hur detta ska fungera
var title = 'Lego Workshop';
var date = '2017-07-11';
var time = '13:00 - 15:00';
var location = 'Uppsala';
var count = '3/4 st';

//Detta ska egentligen hämtas från databasen
List<Map<String, dynamic>> _menuItem = [
  {
    'title': '$title',
    'icon': Icon(Icons.home),
    'subtitle': '$date \n$time \n$location \n$count',
  },
  {
    'title': 'Teams',
    'icon': Icon(Icons.people),
    'subtitle': '$date \n$time \n$location \n$count',
  },
  {
    'title': 'Test',
    'icon': Icon(Icons.lightbulb),
    'subtitle': '$date \n$time \n$location \n$count',
  },
];

class Works extends StatelessWidget {
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
          return Card(
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text(allJobs[index].title),
              //subtitle: Text(allJobs[index].),
              /*child: Align(
                alignment: Alignment.topRight,
                child: Text('TESTING TESTING'),
              ),*/
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
    );
  }
}
