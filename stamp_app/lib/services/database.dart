import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;

  //Class constracter
  DatabaseService({this.userId});

  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

//updateUserData(userName, userPhoneNumber, userProgram, userProfilePic)
  // method to update user data
  Future updateUserData(String userName, String userPhoneNumber,
      String userProgram, String userProfilePicUrl, String accountType) async {
    return await userCollection.doc(userId).set(
      {
        'name': userName,
        'phoneNumber': userPhoneNumber,
        'userProgram': userProgram,
        'userProfilePicUrl': userProfilePicUrl,
        'accountType': accountType,
      },
    );
  }
}
