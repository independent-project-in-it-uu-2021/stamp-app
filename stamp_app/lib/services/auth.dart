import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/services/storage.dart';

class AuthService {
  // Connecting to the firebase authentication (instance of firebaseauth)
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create a user object based on firebase user objece
  // NOTE: Not used right now
  /*OurUser _curUserFromFirebase(User user) {
    return user != null ? OurUser(uid: user.uid) : null;
  }*/

  // auth change user stream
  // listingen for auth changes, if user logged in user object
  // is return otherwise null is return
  Stream<User> get curUser {
    return _firebaseAuth.authStateChanges();
  }

  // NOT USED: Sign in anon method for testing. Async method
  Future signInAnon() async {
    try {
      // Signing in anon and getting a usercredential object
      // Authresult = UserCredential
      UserCredential result = await _firebaseAuth.signInAnonymously();

      // User object that we can extract from the usercredential object
      // FirebaseUser = User
      User curUser = result.user;
      return curUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signing in with email & password
  Future signInWithEmailAndPassword(
      String userEmail, String userPassword) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: userEmail, password: userPassword);
    return result.user;
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String userEmail,
      String userPassword,
      String userName,
      String userPhoneNumber,
      String userProgram,
      String userProfilePicUrl,
      String accountType,
      [String bio]) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      // Create a empty document inside user collection in the db
      await DatabaseService(userId: result.user.uid).createUserData(
          userName,
          userEmail,
          userPhoneNumber,
          userProgram,
          userProfilePicUrl,
          accountType);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  //Update user email
  Future updateEmail(String userEmail) async {
    //try {
    final curUser = _firebaseAuth.currentUser;
    final result = await curUser.updateEmail(userEmail);

    // Update email adress in the database
    final upp = await locator
        .get<DatabaseService>()
        .updaterUserEmailInDatabase(curUser.uid, userEmail);
    return result;
  }

  //Update user password
  Future updatePassword(String userPassword) async {
    try {
      final result = _firebaseAuth.currentUser.updatePassword(userPassword);
      return result;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  // When user wants to delete the acount this method is called
  Future deleteAccount(String userId, String userProfilePicUrl) async {
    try {
      final _curUser = _firebaseAuth.currentUser;

      await _curUser.delete();
      //await _firebaseAuth.signOut();
      print(userProfilePicUrl);
      await locator.get<StorageServices>().deleteImg(userProfilePicUrl);
      await locator.get<DatabaseService>().deleteUserInfo(userId);
    } catch (e) {
      print('deleteAccount');
      print(e);
    }
  }

  // sign out
  Future signOutUser() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
