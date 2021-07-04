import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;
  int allUsersCount;

  //Class constracter
  DatabaseService({this.userId, this.allUsersCount});

  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference jobsCollection =
      FirebaseFirestore.instance.collection('jobs');

  //Create job
  Future createJob(
    String name,
    String location,
    String desc,
    String maxStudents,
    String date,
    String time,
    String endTime,
    String icon,
  ) async {
    Map reserveList = {};
    Map acceptedList = {};
    Map interestList = {};
    return await jobsCollection.add({
      'jobName': name,
      'location': location,
      'description': desc,
      'numberOfStudents': maxStudents,
      'data': date,
      'time': time,
      'endTime': endTime,
      'completed': false,
      'currentReserve': reserveList,
      'currentAccepted': acceptedList,
      'currentInterest': interestList,
      'icon': icon,
    }); //serializeIcon(_icon),})
  }

  //Job list
  List<Jobs> _jobsFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Jobs(
          title: doc.data()['jobName'],
          date: doc.data()['date'],
          time: doc.data()['time'],
          location: doc.data()['location'],
          count: doc.data()['numberOfStudents']);
    }).toList();
  }

  //Get jobs stream
  Stream<List<Jobs>> get allJobs {
    return jobsCollection.snapshots().map(_jobsFromDatabase);
  }

  //------------Methods that are used for user-----------------//
  //-----------------------------------------------------------//

  List<UserData> _usersFromDataBase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
        uid: doc.id,
        name: doc.data()['userName'],
        email: doc.data()['userEmail'],
        phoneNumer: doc.data()['userPhoneNumber'],
        bio: doc.data()['userBio'],
        imageUrl: doc.data()['userProfilePicUrl'],
        accountType: doc.data()['accountType'],
      );
    }).toList();
  }

  // method to update user data
  Future createUserData(
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

  // Change profileimage url
  Future updateProfileImgUrl(String userID, String imgUrl) async {
    return await userCollection
        .doc(userID)
        .update({'userProfilePicUrl': imgUrl});
  }

  // Updates user information used in editprofile view
  Future updateUserData(
    String userID,
    String userName,
    //String userEmail,
    String userPhoneNumber,
    String userBio,
  ) async {
    return await userCollection.doc(userID).update({
      'userName': userName,
      //'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'userBio': userBio,
    });
  }

  //Updates user email in the database when email is changed
  //in Autentication
  Future updaterUserEmailInDatabase(String userID, String userEmail) async {
    return await userCollection.doc(userID).update({'userEmail': userEmail});
  }

  Future<List<UserData>> getAllUsers() async {
    //final users = await userCollection.get();
    List<Map<String, dynamic>> usersList = [];
    List<UserData> userDataList = [];
    try {
      final users = await userCollection.get();
      users.docs.forEach((element) {
        /*usersList.add({
          'uid': element.id,
          'name': element.data()['userName'],
          'email': element.data()['userEmail'],
          'phoneNumber': element.data()['userPhoneNumber'],
          'bio': element.data()['userBio'],
          'imageUrl': element.data()['userProfileUrl'],
          'accontType': element.data()['accountType']
        });*/
        userDataList.add(UserData(
            uid: element.id,
            name: element.data()['userName'],
            email: element.data()['userEmail'],
            phoneNumer: element.data()['userPhoneNumber'],
            bio: element.data()['userBio'],
            imageUrl: element.data()['userProfilePicUrl'],
            accountType: element.data()['accountType']));
      });

      // Sort users according to their name
      userDataList.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      allUsersCount = userDataList.length;
      return userDataList;
    } catch (e) {
      print('Error inside getAllUsers');
      print(e);
    }
  }

  // Change user account roll ex. from inactive to student
  Future changeAccountRoll(String userID, String newRoll) async {
    return await userCollection.doc(userID).update({'accountType': newRoll});
  }

  // User model for stream
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

  // Deteles user info from databas, if called from deleteAccount method
  // in auth aka when user wants to delete account
  Future deleteUserInfo(String userID) async {
    await userCollection.doc(userID).delete();
  }

  // Get user information stream
  Stream<UserData> get userData {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }
}
