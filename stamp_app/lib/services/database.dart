import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Parameter to user id created with firebase autentication
  final String userId;

  //Class constracter
  DatabaseService({this.userId});

  // reference to the user collection in firestore database
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  // method to update user data
  Future updateUserData(String name, String email, String phoneNumber) async {
    return await userCollection.doc(userId).set(
      {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      },
    );
  }
}
