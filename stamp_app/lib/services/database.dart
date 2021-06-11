import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stamp_app/models/jobsModel.dart';

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
      String userProgram,
      String userProfilePicUrl,
      String accountType) async {
    return await userCollection.doc(userId).set(
      {
        'userName': userName,
        'userEmail': userEmail,
        'userPhoneNumber': userPhoneNumber,
        'userProgram': userProgram,
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

  // Get user information stream
  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(userId).snapshots();
  }
}
