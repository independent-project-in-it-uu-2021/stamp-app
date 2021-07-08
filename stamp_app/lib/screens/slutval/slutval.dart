import 'package:flutter/material.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/imageForListView.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:stamp_app/screens/slutval/slutval.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';
import 'package:stamp_app/sharedWidget/buildJobInfor.dart';
import 'package:stamp_app/studentScreens/FinalStudentChoice/finalStudentChoice.dart';

class FinalChoice extends StatelessWidget {
  final Jobs curJob;
  final List<UserJob> usersList;
  List<UserJob> selectedUsers = [];
  List<UserJob> reservedUsers = [];

  FinalChoice({
    Key key,
    this.curJob,
    this.usersList,
  }) : super(key: key);

  Widget _userProfilePic(String imageUrl) {
    return ListViewImage(imageUrl: imageUrl);
  }

  // ListView for all the users that are selected
  Widget buildSelectUserListView() {
    selectedUsers =
        usersList.where((element) => element.isSelected == true).toList();
    String userID;
    String userName;
    String userProfilePicUrl;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: selectedUsers.length,
      itemBuilder: (context, index) {
        userID = selectedUsers[index].userID;
        userName = selectedUsers[index].userName;
        userProfilePicUrl = selectedUsers[index].profilePickLink;
        return Card(
          child: ListTile(
            leading: _userProfilePic(userProfilePicUrl),
            title: Text(userName),
          ),
        );
      },
    );
  }

  // ListView for all the users that are reserved
  Widget buildReservedListView() {
    reservedUsers =
        usersList.where((element) => element.isReserve == true).toList();

    String userID;
    String userName;
    String userProfilePicUrl;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: selectedUsers.length,
      itemBuilder: (context, index) {
        userID = reservedUsers[index].userID;
        userName = reservedUsers[index].userName;
        userProfilePicUrl = reservedUsers[index].profilePickLink;
        return Card(
          child: ListTile(
            leading: _userProfilePic(userProfilePicUrl),
            title: Text(userName),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Inside final choice');
    print(usersList);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        //centerTitle: true,
        backgroundColor: Colors.red.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              BuildJobInformation(curJob: curJob),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Valda',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.001,
                  width: MediaQuery.of(context).size.width * 0.83,
                  color: Colors.black12,
                ),
              ),
              buildSelectUserListView(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              //---------------

              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.001,
                  width: MediaQuery.of(context).size.width * 0.83,
                  color: Colors.black12,
                ),
              ),*/
              Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                'Reserver',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.001,
                  width: MediaQuery.of(context).size.width * 0.83,
                  color: Colors.black12,
                ),
              ),
              buildReservedListView(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              //---------------

              Padding(
                padding: EdgeInsets.only(top: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: Text(
                'Bekräfta',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
      ),
    );
  }
}
