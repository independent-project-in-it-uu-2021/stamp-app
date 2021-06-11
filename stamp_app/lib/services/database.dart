//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/models/user.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;
  final String documentId;
  //Class constracter
  DatabaseService({this.userId, this.documentId});
  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

//updateUserData(userName, userPhoneNumber, userProgram, userProfilePic)
  // method to update user data
  Future updateUserData(
      String userName,
      String userEmail,
      String userPhoneNumber,
      String userBio,
      String userProfilePicUrl,
      String accountType) async {
    return await userCollection.doc(userId).set(
      {
        'userName': userName,
        'userEmail': userEmail,
        'userPhoneNumber': userPhoneNumber,
        'userBio': userBio,
        'userProfilePicUrl': userProfilePicUrl,
        'accountType': accountType,
      },
    );
  }

  /*StreamBuilder getUserData(BuildContext context) {
    final _currentUser = Provider.of<User>(context);
    String _userName = '';
    String _userNumber = '';
    String _userEmail = '';
    String _userBio = '';
    String userAccountType = '';
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(userId: _currentUser.uid).userData,
        builder: (context, snapshot) {
          _userName = snapshot.data['userName'];
          _userNumber = snapshot.data['userPhoneNumber'];
          _userEmail = snapshot.data['userEmail'];
          _userBio = snapshot.data['userProgram'];
          userAccountType = snapshot.data['accountType'];
        });
  }*/

  /*
  Future getUser(BuildContext context) async {
    final _currentUser = Provider.of<User>(context);
    String _accountType = '';

    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(userId: _currentUser.uid).userData,
      builder: (context, snapshot) {
        _accountType = snapshot.data['accountType'];

        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
      },
    return Scaffold(
        );
        );
  }*/
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: userId,
      name: snapshot.data()['userName'],
      email: snapshot.data()['userEmail'],
      phoneNumer: snapshot.data()['userPhoneNumber'],
      bio: snapshot.data()['userBio'],
      imageUrl: snapshot.data()['userProfilePicUrl'],
      accountType: snapshot.data()['accountType'],
    );
  }

  // Get user information stream
  Stream<UserData> get userData {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }


/*
//Updating the accountType of a user
  Future updateStatus(BuildContext context) async {
    StreamBuilder userData = getUserData(context);

    if (userData.userAccountType == 'student') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'admin',
        },
      );
    }
    if (userAccountType == 'admin') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'student',
        },
      );
    }
    if (userAccountType == 'inactive') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'student',
        },
      );
    } else {
      return await userCollection.doc(userId).set(
        {
          'accountType': userAccountType,
        },
      );
    }
  }
}*/

//final String documentId;
//GetUserName(this.documentId);
/*
_getUser(context) {
  return FutureBuilder<DocumentSnapshot>(
    future: users.doc('users').get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data.exists) {
        return Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data.data();
        print(data);
        return Text("Full Name: ${data['userName']} ${data['userBio']}");
      }

      return Text("loading");
    },
  );
  print(users);

  setState(() {
    //getIsNewUSer=document['IsNewUser'];
    print(users);
  });

  /*FirebaseFirestore.instance
        .document('users/$uid')
        .get()
        .then((DocumentSnapshot document) {
      print("document_build:$document");
      setState(() {
        getIsNewUSer = document['accountType'];
        print("getIsNewUSe:$getIsNewUSer");
      });
    });*/
}
/*
  _makeAdmin() {
    FirebaseFirestore.instance
        .collection('users')
        .document(uid)
        .updateData({"accountType": "admin"}).then((result) {
      print("User is now admin");
    }).catchError((onError) {
      print("onError");
    });
  }*/
  */
}
