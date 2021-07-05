import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/rendering/box.dart';

import 'package:stamp_app/models/jobsModel.dart';

class StudentWork extends StatelessWidget {
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
        return Icon(Icons.smart_toy);
      });
    }
  }

  // Returns a listviewbuilder for all the jobs
  Widget _buildAllJobs(List<Jobs> allJobs) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                      reserveCount: reserveCount,
                      category: jobCategory,
                    ),
                  ),
                )*/
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Stream of all the jobs from database
    final allJobsFromDatabase = Provider.of<List<Jobs>>(context) ?? [];
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
              /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowWork()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Reserv',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
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
              /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowWork()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Anmäld',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
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
              _buildAllJobs(allJobsFromDatabase),
            ],
          ),
        ),
      ),
    );
  }
}
