import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stamp_app/services/database.dart';

import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';

class OthersProfile extends StatelessWidget {
  final String userID;
  OthersProfile({@required this.userID});

  Widget showProfileImage(String profileImagUrl) {
    if (profileImagUrl == 'noImage') {
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
          minRadius: 60,
          maxRadius: 80,
          backgroundColor: Colors.white);
    } else {
      return CircleAvatar(
          backgroundImage: NetworkImage(profileImagUrl),
          minRadius: 60,
          maxRadius: 80,
          backgroundColor: Colors.white);
    }
  }

  Widget lowerHalfOfProfile(BuildContext context, String accountType) {
    if (accountType == 'student') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Senaste Jobb',
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
          Padding(
            padding: EdgeInsets.only(top: 30),
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
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: locator.get<DatabaseService>().getUserFromDatabase(this.userID),
        builder: (BuildContext, snapshot) {
          if (snapshot.hasData) {
            String userName = snapshot.data.name;
            String userEmail = snapshot.data.email;
            String profileImage = snapshot.data.imageUrl == null
                ? 'noImage'
                : snapshot.data.imageUrl;
            String phoneNumber = snapshot.data.phoneNumer == null ||
                    snapshot.data.phoneNumer.isEmpty
                ? 'Telefonnumer saknas'
                : snapshot.data.phoneNumer;
            String userBio = snapshot.data.bio;
            String accountType = snapshot.data.accountType;

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Image.asset('assets/images/uuLogaNew.png',
                    fit: BoxFit.cover),
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
                      Text(
                        userName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      showProfileImage(profileImage),
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
                        padding: EdgeInsets.only(top: 12),
                      ),
                      Text(
                        phoneNumber,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
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
                        padding: EdgeInsets.only(top: 12),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
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
                        padding: EdgeInsets.only(top: 12),
                      ),
                      Text(
                        userBio,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
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
                      lowerHalfOfProfile(context, accountType),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
