import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/profileImage.dart';
import 'package:stamp_app/models/user.dart';

class StudentProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentProfileState();
  }
}

class StudentProfileState extends State<StudentProfile> {
  String _userName = '';
  String _userNumber = '';
  String _userEmail = '';
  String _userBio = '';
  String _profileImageUrl = '';

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // reuseable profile image widget
  Widget profilePic() {
    return ProfileImage(profileImagUrl: _profileImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediQuearyData = MediaQuery.of(context);
    final _currentUser = Provider.of<User>(context);
    if (_currentUser != null) {
      return StreamBuilder<UserData>(
        stream: DatabaseService(userId: _currentUser.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _userName = snapshot.data.name;
            _userEmail = snapshot.data.email;
            _userBio = snapshot.data.bio;

            //If user has not profile picture
            snapshot.data.imageUrl == null
                ? _profileImageUrl = 'noImage'
                : _profileImageUrl = snapshot.data.imageUrl;

            //If user has no phonenummer
            snapshot.data.phoneNumer == null || snapshot.data.phoneNumer.isEmpty
                ? _userNumber = 'Telefonnummer saknas'
                : _userNumber = snapshot.data.phoneNumer;

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Image.asset('assets/images/uuLogaNew.png',
                    fit: BoxFit.cover),
                centerTitle: true,
                backgroundColor: Colors.red.shade900,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Tillbaka',
                ),
                //TODO: Chat icon future implementation
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Stack(
                          children: [
                            Text(
                              'Din profil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 215,
                            ),
                            Positioned(
                              bottom: 0,
                              right: _mediQuearyData.size.width * -0.05,
                              child: RawMaterialButton(
                                  child: Icon(Icons.edit_rounded, size: 33),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileEdit(
                                          userID: _currentUser.uid,
                                          userName: _userName,
                                          userEmail: _userEmail,
                                          userNumber: _userNumber,
                                          userBio: _userBio,
                                          userProfileImgUrl: _profileImageUrl,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        Text(
                          _userName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        profilePic(),
                        //_profilePicture(),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                        ),
                        Text(
                          _userNumber,
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                        ),
                        Text(
                          _userEmail,
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                        ),
                        Text(
                          _userBio,
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Text(
                          'Jobb 1',
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Text(
                          'Jobb 2',
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Text(
                          'Jobb 3',
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
                            height: _mediQuearyData.size.height * 0.001,
                            width: _mediQuearyData.size.width * 0.83,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: TextButton(
                              child: Text(
                                'Redigera profil',
                                style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileEdit(
                                      userID: _currentUser.uid,
                                      userName: _userName,
                                      userEmail: _userEmail,
                                      userNumber: _userNumber,
                                      userBio: _userBio,
                                      userProfileImgUrl: _profileImageUrl,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60),
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
    } else {
      return LoadingScreen();
    }
  }
}
