import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/screens/profil/profil.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/buildJobInfor.dart';
import 'package:stamp_app/sharedWidget/imageForListView.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';

class FinalStudentChoice extends StatefulWidget {
  final Jobs curJob;

  FinalStudentChoice({
    Key key,
    @required this.curJob,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FinalStudentChoiceState();
  }
}

class FinalStudentChoiceState extends State<FinalStudentChoice> {
  Jobs currentJob;
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
  bool showMsgToUser = false;
  String currentUserID;

  @override
  void initState() {
    super.initState();
    currentJob = widget.curJob;
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
                // Show either its own profile page or other users
                userThatShownInterest[index].userID == currentUserID
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profil()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OthersProfile(
                            userID: userThatShownInterest[index].userID,
                          ),
                        ),
                      );
              },
              leading: _userProfilePic(userProfilePicUrl),
              title: Text(userName),
            ),
          );
        });
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

  // Shows text message if user has show interest for the job
  Widget _buildMsgWidget(String currentUserID) {
    bool userAccepted = userThatSelected
        .where((element) => element.userID == currentUserID)
        .isNotEmpty;

    String msg;
    userAccepted ? msg = 'Du är antagen' : msg = 'Du står som reserv';
    return Text(
      msg,
      style: TextStyle(
        fontSize: 20,
        color: Colors.red.shade900,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<User>(context);
    currentUserID = _currentUser.uid;

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: _currentUser.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String curUserID = _currentUser.uid;
          String curUserName = snapshot.data.name;
          String curUserProfileImage = snapshot.data.imageUrl;
          return Scaffold(
            appBar: AppBar(
              title:
                  Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
              //centerTitle: true,
              backgroundColor: Colors.red.shade900,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                tooltip: 'Tillbaka',
              ),
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
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Builds job information
                      BuildJobInformation(curJob: currentJob),
                      _buildMsgWidget(curUserID),
                      Text(
                        'Accepterad',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      /*Text('Du har anmält intresse',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          )),*/
                      showSelectedUsers(userThatSelected, 'selected'),

                      Padding(padding: EdgeInsets.only(top: 10)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.001,
                          width: MediaQuery.of(context).size.width * 0.83,
                          color: Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      //---------------

                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Reserv',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      showSelectedUsers(userThatReserved, 'reserve'),

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
                    ],
                  ),
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
