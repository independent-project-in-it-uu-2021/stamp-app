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

//Updating the accountType of a user
  Future updateStatus(String accountType) async {
    if (accountType == 'student') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'admin',
        },
      );
    }
    if (accountType == 'admin') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'student',
        },
      );
    }
    if (accountType == 'inactive') {
      return await userCollection.doc(userId).set(
        {
          'accountType': 'student',
        },
      );
    } else {
      return await userCollection.doc(userId).set(
        {
          'accountType': accountType,
        },
      );
    }
  }

  // Get user information stream
  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(userId).snapshots();
  }
}
         
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
