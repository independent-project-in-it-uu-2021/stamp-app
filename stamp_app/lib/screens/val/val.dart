import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';

import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/imageForListView.dart';
import 'package:stamp_app/sharedWidget/buildJobInfor.dart';

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
  Map showSelectedUser;
  Map showReservedUser;
  List<UserJob> userThatShownInterest = [];
  List<UserJob> userThatSelected = [];
  List<UserJob> userThatReserved = [];
  int amountSelected;
  int amountReserved;
  bool showErrorMsg = false;

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
    showSelectedUser = widget.curJob.currentAccepted;
    showReservedUser = widget.curJob.currentReserve;

    // Create a list of users that have shown interest
    userThatShownInterest = _createUsersList(showInterestUser, false, false);
    // List of users that are accepted
    userThatSelected = _createUsersList(showSelectedUser, true, false);
    // List of users that are reserved
    userThatReserved = _createUsersList(showReservedUser, false, true);
    amountSelected = widget.curJob.count;
    amountReserved = widget.curJob.reserveCount;
  }

  // Creates a list of Userjob object, which is easier to work with
  List<UserJob> _createUsersList(Map userMap, bool select, bool reserve) {
    List<UserJob> theList = [];
    userMap.forEach(
      (key, value) {
        theList.add(
          UserJob(
            userID: key,
            userName: value['userName'],
            profilePickLink: value['userProfilePicUrl'],
            isSelected: select,
            isReserve: reserve,
          ),
        );
      },
    );
    return theList;
  }

  // Check if user has profileimage or not
  // returns userprofile image or icon
  Widget _userProfilePic(String imageUrl) {
    return ListViewImage(imageUrl: imageUrl);
  }

  Widget showSelectedUsers(List<UserJob> usersList, String msgText) {
    String userID;
    String userName;
    String userProfilePicUrl;

    if (usersList.isEmpty) {
      msgText == 'selected'
          ? msgText = 'Ingen accepterade'
          : msgText = 'Ingen reserver';
      return Text(
        msgText,
        style: TextStyle(fontSize: 15),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: usersList.length,
        itemBuilder: (context, index) {
          userID = usersList[index].userID;
          userName = usersList[index].userName;
          userProfilePicUrl = usersList[index].profilePickLink;
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OthersProfile(
                      userID: userID,
                    ),
                  ),
                );
              },
              leading: _userProfilePic(userProfilePicUrl),
              title: Text(userName),
              //subtitle:
            ),
          );
        });
  }

  // Build the listview for users that have shown interest for the job
  Widget _buildUserShowIntereset() {
    String userID;
    String userName;
    String userProfilePicUrl;
    List userIDList = showInterestUser.keys.toList();

    if (userIDList.isEmpty) {
      return Text(
        'Ingen intresseanmälningar',
        style: TextStyle(fontSize: 15),
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: userIDList.length,
        itemBuilder: (context, index) {
          userID = userThatShownInterest[index].userID;
          userName = userThatShownInterest[index].userName;
          userProfilePicUrl = userThatShownInterest[index].profilePickLink;

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OthersProfile(
                      userID: userID,
                    ),
                  ),
                );
              },
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
                      'Reserver',
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
      // Checks if user has choosen any reserv or accepted anyone
      showErrorMsg = false;
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
    });
  }

  // Show text message if user choose more than allowed amount of student
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

  // Shows text message if user has not selected anyone
  Widget buildMsgText() {
    if (showErrorMsg == true) {
      return Text(
        'Välj någon att acceptera eller som reserv ',
        style:
            TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  }

  // Logic and build widget for the bottombar button
  Widget buildBottomBar() {
    return BottomAppBar(
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
              if (reserveCount == amountReserved && count == amountSelected)
                {
                  setState(() {
                    showErrorMsg = true;
                  })
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalChoice(
                        curJob: widget.curJob,
                        usersList: userThatShownInterest,
                      ),
                    ),
                  ),
                }
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 60))
        ],
      ),
    );
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
              BuildJobInformation(curJob: widget.curJob),
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
              buildMsgText(),
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
              showSelectedUsers(userThatSelected, 'selected'),
              SizedBox(
                height: 20,
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
              showSelectedUsers(userThatReserved, 'reserve'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
