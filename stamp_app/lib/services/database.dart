import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;

  //Class constracter
  DatabaseService({this.userId});

  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference jobsCollection =
      FirebaseFirestore.instance.collection('jobs');

//updateUserData(userName, userPhoneNumber, userProgram, userProfilePic)
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
        description: doc.data()['description'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        endTime: doc.data()['endTime'],
        location: doc.data()['location'],
        count: doc.data()['numberOfStudents'],
        maxCount: doc.data()['maxStudents'],
        reserveCount: doc.data()['currentReserve'],
      );
    }).toList();
  }

  //Get jobs stream
  Stream<List<Jobs>> get allJobs {
    return jobsCollection.snapshots().map(_jobsFromDatabase);
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
