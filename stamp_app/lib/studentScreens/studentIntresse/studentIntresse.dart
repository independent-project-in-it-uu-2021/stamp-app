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

class StudentChoice extends StatefulWidget {
  final Jobs curJob;

  StudentChoice({
    Key key,
    @required this.curJob,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return StudentChoiceState();
  }
}

class StudentChoiceState extends State<StudentChoice> {
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
  List<UserJob> userThatShownInterest = [];
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
    // Create a list of users that have shown interest
    userThatShownInterest = _createUsersList(showInterestUser, false, false);
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

  // Shows text message if user has show interest for the job
  Widget _buildMsgWidget(String currentUserID) {
    bool checkIfUserHarShownInterest = userThatShownInterest
        .where((element) => element.userID == currentUserID)
        .isNotEmpty;
    if (showMsgToUser || checkIfUserHarShownInterest) {
      return Text(
        'Du har anmält intresse',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red.shade900,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildButtonWidget(
      String currentUserID, String curUserName, String curUserProfileImage) {
    bool checkIfUserHarShownInterest = userThatShownInterest
        .where((element) => element.userID == currentUserID)
        .isNotEmpty;
    // Withdraw button is shown in user has already shown interest
    if (showMsgToUser || checkIfUserHarShownInterest) {
      return FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () async {
          final result = await locator
              .get<DatabaseService>()
              .withDrawInterest(jobID, currentUserID);

          //print(result);
          if (userThatShownInterest
              .where((element) => element.userID == currentUserID)
              .isEmpty) {
            setState(() {
              showMsgToUser = false;
            });
          }
          if (result == null) {
            setState(() {
              showMsgToUser = false;
            });
          }
          Navigator.pop(context, 'Du har avanmält');
        },
        label: Text(
          'Avanmäla',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Roboto'),
        ),
      );
    } else {
      // Show interest button is shown
      return FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () async {
          final result = await locator.get<DatabaseService>().showInterestJob(
              jobID, currentUserID, curUserName, curUserProfileImage);

          //print(result);
          if (userThatShownInterest
              .where((element) => element.userID == currentUserID)
              .isNotEmpty) {
            setState(() {
              showMsgToUser = true;
            });
          }
          if (result == null) {
            setState(() {
              showMsgToUser = true;
            });
          }
          Navigator.pop(context, 'Du har anmält intresse');
        },
        label: Text(
          'Anmäl intresse',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Roboto'),
        ),
      );
    }
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

                      Text(
                        'Intresseanmälningar',
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
                      _buildMsgWidget(curUserID),

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

                      _buildUserShowIntereset(),

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
                      _buildButtonWidget(
                          curUserID, curUserName, curUserProfileImage),
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
