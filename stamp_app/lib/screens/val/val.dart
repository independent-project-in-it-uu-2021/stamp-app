import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/models/jobsModel.dart';

class Choice extends StatefulWidget {
  final Jobs curJob;

  Choice({
    Key key,
    @required this.curJob,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChoiceState();
  }
}

class ChoiceState extends State<Choice> {
  // Job information attribute
  String jobID;
  String title;
  String description;
  String date;
  String time;
  String endTime;
  String location;
  int count;
  int maxCount;
  int reserveCount;
  String category;
  Map showInterestUser;

  @override
  void initState() {
    super.initState();
    jobID = widget.curJob.jobID;
    title = widget.curJob.title;
    description = widget.curJob.description;
    date = widget.curJob.date;
    time = widget.curJob.time;
    endTime = widget.curJob.endTime;
    location = widget.curJob.location;
    count = widget.curJob.count;
    maxCount = widget.curJob.maxCount;
    reserveCount = widget.curJob.reserveCount;
    category = widget.curJob.category;
    showInterestUser = widget.curJob.currentInterest;
  }

  // Returns different typ of icon depending on category
  Widget _buildCategoryIcon(String jobCategory) {
    if (jobCategory != null && jobCategory.isNotEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        switch (jobCategory) {
          case 'Workshop':
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          case 'Studiebesök':
            return Icon(
              Icons.ac_unit_sharp,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          default:
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
        }
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Icon(
          Icons.smart_toy,
          size: MediaQuery.of(context).size.height * 0.07,
          color: Colors.black,
        );
      });
    }
  }

  Widget _buildJobInformation() {
    MediaQueryData screenSize = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            _buildCategoryIcon(category),
            Padding(padding: EdgeInsets.only(left: 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenSize.size.width * 0.055,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text('Tid: ' + time + '-' + endTime,
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
                Text('Datum: ' + date,
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
                Text(
                  'Studenter: ' +
                      count.toString() +
                      '/' +
                      maxCount.toString() +
                      ' st',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Reserver: ' + reserveCount.toString() + ' st',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
          ],
        ),
      ],
    );
  }

  // Check if user has profileimage or not
  // returns userprofile image or icon
  Widget _userProfilePic(String imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return CircleAvatar(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Icon(
                Icons.account_circle,
                size: constraints.biggest.height,
                color: Colors.black,
              );
            },
          ),
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    } else {
      return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    }
  }

  //Builds listview for the users that have shown instereset for the job
  Widget _buildUserShowIntereset() {
    String userID;
    String userName;
    String userProfilePicUrl;
    List userIDList = showInterestUser.keys.toList();
    List userInterestList = showInterestUser.values.toList();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: userIDList.length,
        itemBuilder: (context, index) {
          userID = userIDList[index];
          userName = userInterestList[index]['userName'];
          userProfilePicUrl = userInterestList[index]['userProfilePicUrl'];

          return Card(
            child: ListTile(
              leading: _userProfilePic(userProfilePicUrl),
              title: Text(userName),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final allJobs = Provider.of<List<Jobs>>(context) ?? [];
    List<bool> isSelected = [false, false];
    print(' ');
    //print('Show interest map : ' +
    //  showInterestUser.values.toList()[0].toString());
    //print(
    //    'Show interest map : ' + showInterestUser.keys.elementAt(0).toString());

    // Size of the screen used to the text size is responsive
    MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Välj Studentambassadörer'),
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
                padding: EdgeInsets.only(top: 20),
              ),
              _buildJobInformation(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Intresseanmälningar',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              _buildUserShowIntereset(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              ToggleButtons(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Acceptera'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Reservera'),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                  },
                  isSelected: isSelected),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green[400],
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
              ),
              child: Text(
                'Nästa Steg',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              onPressed: () => {
                //TODO: Fixed this
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinalChoice(
                          title: widget.title,
                          description: widget.description,
                          date: widget.date,
                          time: widget.time,
                          endTime: widget.endTime,
                          location: widget.location,
                          count: widget.count,
                          maxCount: widget.maxCount,
                          reserveCount: widget.reserveCount)),
                ),*/
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
      ),
    );
  }
}
