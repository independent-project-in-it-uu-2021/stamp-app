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

  //Job list
  List<Jobs> _jobsFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Jobs(
        title: doc.data()['jobName'],
        description: doc.data()['description'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        location: doc.data()['location'],
        count: doc.data()['numberOfStudents'],
        maxCount: doc.data()['maxStudents'],
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

  // Get user information stream
  Stream<UserData> get userData {
    return userCollection.doc(userId).snapshots().map(_userDataFromSnapshot);
  }
}
