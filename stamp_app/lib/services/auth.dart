import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/models/user.dart';
import 'database.dart';
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

  // Sign in anon method for testing. Async method
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
  // register with email and password
  Future registerWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
         User usr = result.user;
        await DatabaseService(uid: usr.uid).updateUserData('newuser', 'gholam@uu.se', '0701234567', 'jaggillarkakor123', 'jaggillarkakor123', 'jaggillarkakor123', 'student', 'it', 'google.se/gholam');      
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // sign out
  Future signOutUser() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
