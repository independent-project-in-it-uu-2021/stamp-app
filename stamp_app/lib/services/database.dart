import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/models/user.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;
  //Amount of users in the database
  int allUsersCount;

  //Class constracter
  DatabaseService({this.userId, this.allUsersCount});

  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference jobsCollection =
      FirebaseFirestore.instance.collection('jobs');

  //------------------Job related methods----------------------//
  //-----------------------------------------------------------//
  //Create job
  Future createJob(
    String name,
    String location,
    String desc,
    int maxStudents,
    String date,
    String time,
    String endTime,
    String icon,
    String category,
  ) async {
    Map reserveList = {};
    Map acceptedList = {};
    Map interestList = {};

    return await jobsCollection.add({
      'title': name,
      'description': desc,
      'date': date,
      'location': location,
      'time': time,
      'endTime': endTime,
      'completed': false,
      'count': 0,
      'maxCount': maxStudents,
      'reserveCount': 0,
      'currentReserve': reserveList,
      'currentAccepted': acceptedList,
      'currentInterest': interestList,
      'icon': icon,
      'category': category,
    });
  }

  //Stores job object in list
  List<Jobs> _jobsFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Jobs(
        jobID: doc.id,
        title: doc.data()['title'],
        description: doc.data()['description'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        endTime: doc.data()['endTime'],
        location: doc.data()['location'],
        count: doc.data()['count'],
        maxCount: doc.data()['maxCount'],
        reserveCount: doc.data()['reserveCount'],
        category: doc.data()['category'],
        currentReserve: doc.data()['currentReserve'],
        currentAccepted: doc.data()['currentAccepted'],
        currentInterest: doc.data()['currentInterest'],
      );
    }).toList();
  }

  // Gets the job that user is either reserved or accepted
  Future getUserJob(String userID, Map jobMap) async {
    List jobKey = jobMap.keys.toList();
    List<Jobs> userJobs = [];
    jobKey.forEach((element) async {
      final doc = await jobsCollection.doc(element).get();
      userJobs.add(Jobs(
        jobID: doc.id,
        title: doc.data()['title'],
        description: doc.data()['description'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        endTime: doc.data()['endTime'],
        location: doc.data()['location'],
        count: doc.data()['count'],
        maxCount: doc.data()['maxCount'],
        reserveCount: doc.data()['reserveCount'],
        category: doc.data()['category'],
        currentReserve: doc.data()['currentReserve'],
        currentAccepted: doc.data()['currentAccepted'],
        currentInterest: doc.data()['currentInterest'],
      ));
    });
  }

  // Method is called when user show interest for a job
  Future showInterestJob(String jobID, String userID, String userName,
      String userProfileLink) async {
    Map userInformation = {
      'userName': userName,
      'userProfilePicUrl': userProfileLink,
    };

    try {
      // Add userinformation to job object in database
      await jobsCollection.doc(jobID).update({
        //'reserveCount': FieldValue.arrayUnion([userID]),
        'currentInterest.' + userID: userInformation,
      });

      // Add jobid to user object in the database
      await userCollection
          .doc(userID)
          .update({'shownInterest.' + jobID: 'showInterest'});
    } on FirebaseException catch (e) {
      print('Show instresset job');
      print(e.code);
    }
  }

  // Method for user that are selected for a work
  Future selectedAndUserJob(List<UserJob> userInfoList, String jobID,
      String rollList, int count, int reservCount) async {
    String selectedList = '';
    // Checks if the users show go in selected list or reserve list
    rollList == 'selected'
        ? selectedList = 'currentAccepted'
        : selectedList = 'currentReserve';
    Map userInfo = {};
    Map jobInfo = {};

    // Loops through the list and adds the users info to the job
    userInfoList.forEach((curUser) async {
      userInfo = {
        'userName': curUser.userName,
        'userProfilePicUrl': curUser.profilePickLink
      };
      jobInfo = {'roll': 'selected'};
      try {
        await jobsCollection.doc(jobID).update({
          selectedList + '.' + curUser.userID: userInfo,
          'currentInterest.' + curUser.userID: FieldValue.delete(),
        });
        await userCollection.doc(curUser.userID).update({
          'jobs.' + jobID: rollList,
        });
      } on FirebaseException catch (e) {
        print('SelectedUers');
        print(e.code);
      }
      jobsCollection.doc(jobID).update({
        'count': count,
        'reserveCount': reservCount,
      });
    });
  }

  // Method for user that are reserved for a work

  //Get jobs stream
  Stream<List<Jobs>> get allJobs {
    return jobsCollection.snapshots().map(_jobsFromDatabase);
  }

  //------------Methods that are used for user-----------------//
  //-----------------------------------------------------------//

  Future<UserData> getUserFromDatabase(String userID) async {
    UserData userInfo;
    try {
      final element = await userCollection.doc(userID).get();
      userInfo = UserData(
          uid: userID,
          name: element.data()['userName'],
          email: element.data()['userEmail'],
          phoneNumer: element.data()['userPhoneNumber'],
          bio: element.data()['userBio'],
          imageUrl: element.data()['userProfilePicUrl'],
          accountType: element.data()['accountType'],
          jobs: element.data()['jobs']);
      return userInfo;
    } on FirebaseException catch (e) {
      print('getUserFromDataBase');
      print(e.code);
    }
    //return userInfo;
  }

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
    Map jobs = {};
    return await userCollection.doc(userId).set(
      {
        'userName': userName,
        'userEmail': userEmail,
        'userPhoneNumber': userPhoneNumber,
        'userBio': userBio,
        'userProfilePicUrl': userProfilePicUrl,
        'accountType': accountType,
        'jobs': jobs,
      },
    );
  }

  // Change profileimage url
  Future updateProfileImgUrl(String userID, String imgUrl) async {
    // Updates user profile image link in the job object
    await _updateUserInfoJobObject(userID, 'userProfilePicUrl', imgUrl);
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
    //Update user name in job object
    await _updateUserInfoJobObject(userID, 'userName', userName);
    return await userCollection.doc(userID).update({
      'userName': userName,
      //'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'userBio': userBio,
    });
  }

  // Updates user profile image link in the job object
  Future _updateUserInfoJobObject(
      String userID, String keyName, String newData) async {
    final currentUser = await userCollection.doc(userID).get();
    try {
      // Update user profile in job object
      if (currentUser.data()['accountType'] == 'student') {
        Map currentJobs = currentUser.data()['jobs'];
        // List of the jobs that user is either accepted or is reserv
        List jobIDs = currentJobs.keys.toList();

        // Loops through and change it in different map
        jobIDs.forEach((curJobID) async {
          // Checks if user is accepted or is reserve
          if (currentJobs[curJobID.toString()] == 'selected') {
            print('Inside if');
            await jobsCollection
                .doc(curJobID)
                .update({'currentAccepted.' + userID + '.' + keyName: newData});
          } else if (currentJobs[curJobID.toString()] == 'reserve') {
            print('Inside else if');
            await jobsCollection
                .doc(curJobID)
                .update({'currentReserve.' + userID + '.' + keyName: newData});
          }
        });
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  //Updates user email in the database when email is changed
  //in Autentication
  Future updaterUserEmailInDatabase(String userID, String userEmail) async {
    return await userCollection.doc(userID).update({'userEmail': userEmail});
  }

  Future<List<UserData>> getAllUsers() async {
    List<UserData> userDataList = [];
    try {
      final users = await userCollection.get();
      users.docs.forEach((element) {
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
    try {
      final result =
          await userCollection.doc(userID).update({'accountType': newRoll});
    } on FirebaseException catch (e) {
      print('Change user roll');
      print(e.code);
    }
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
      jobs: snapshot.data()['jobs'],
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
