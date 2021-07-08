import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/imageForListView.dart';

class Choice extends StatefulWidget {
  final Jobs curJob;
  final List<UserJob> usersInterestList;

  Choice({
    Key key,
    @required this.curJob,
    this.usersInterestList,
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
  List<UserJob> userThatShownInterest = [];
  int amountSelected;
  int amountReserved;

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
    userThatShownInterest = shownInterestList(showInterestUser);
    amountSelected = widget.curJob.count;
    amountReserved = widget.curJob.reserveCount;
  }

  // Creates a list of Userjob object, which is easier to work with
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
            isReserve: false,
          ),
        );
      },
    );
    return theList;
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
    return ListViewImage(imageUrl: imageUrl);
  }

  // Build the listview for users that have shown interest for the job
  Widget _buildUserShowIntereset() {
    String userID;
    String userName;
    String userProfilePicUrl;
    List userIDList = showInterestUser.keys.toList();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: userIDList.length,
        itemBuilder: (context, index) {
          userID = userThatShownInterest[index].userID;
          userName = userThatShownInterest[index].userName;
          userProfilePicUrl = userThatShownInterest[index].profilePickLink;

          return Card(
            child: ListTile(
              leading: _userProfilePic(userProfilePicUrl),
              title: Text(userName),
              subtitle: Row(
                key: UniqueKey(),
                children: <Widget>[
                  ElevatedButton(
                    // Unique key is used in order to change color
                    // when the button is pressed
                    key: UniqueKey(),
                    style: ElevatedButton.styleFrom(
                      primary: userThatShownInterest[index].isSelected
                          ? Colors.green
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                    onPressed: () {
                      changeState('selected', index);
                      //changeState(index);
                    },
                    child: Text(
                      'Acceptera',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                  ),
                  ElevatedButton(
                    // Key added inorder to change button color
                    // when pressed
                    key: UniqueKey(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        userThatShownInterest[index].isReserve
                            ? Colors.green
                            : Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      changeState('reserve', index);
                    },
                    child: Text(
                      'Reservera',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Change the state if user is selected or is accepted as reserve
  void changeState(String adminChoice, int i) {
    UserJob curUserInfo = userThatShownInterest[i];
    bool nonSelect =
        curUserInfo.isReserve == false && curUserInfo.isSelected == false;
    bool selectedSelected = curUserInfo.isSelected == true;
    bool reserveSelected = curUserInfo.isReserve == true;
    setState(() {
      if (adminChoice == 'selected' && reserveSelected) {
        curUserInfo.isSelected = !curUserInfo.isSelected;
        curUserInfo.isReserve = !curUserInfo.isReserve;

        amountSelected++;
        amountReserved--;
      } else if (adminChoice == 'reserve' && selectedSelected) {
        curUserInfo.isReserve = !curUserInfo.isReserve;
        curUserInfo.isSelected = !curUserInfo.isSelected;

        amountReserved++;
        amountSelected--;
      } else if (adminChoice == 'selected' && nonSelect) {
        curUserInfo.isSelected = !curUserInfo.isSelected;

        amountSelected++;
      } else if (adminChoice == 'reserve' && nonSelect) {
        curUserInfo.isReserve = !curUserInfo.isReserve;

        amountReserved++;
      }

      print(amountSelected);
    });
  }

  Widget buildInfoText() {
    if (amountSelected == maxCount + 1) {
      return Text(
        'Kan inte acceptera mer än $maxCount',
        style:
            TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final allJobs = Provider.of<List<Jobs>>(context) ?? [];

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
              buildInfoText(),
              _buildUserShowIntereset(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Accepterade',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Reserver',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
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
