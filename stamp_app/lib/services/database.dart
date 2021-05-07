import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{ //Here we will have all the operations for the database

  final String uid;
  DatabaseService({ this.uid });//To pass on the uid for future instances of the class

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String email, String phone, String password, String passwordConfirmation, String passwordNew, String role, String program, String imageURL) async{//Asynchronus func (future).
  
    return await userCollection.document(uid).setData({

      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'passwordNew': passwordNew,
      'role': role,
      'program': program,
      'imageURL': imageURL,
    });
  
  }

}



