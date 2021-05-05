import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/models/user.dart';

class AuthService {
  // Connecting to the firebase authentication (instance of firebaseauth)
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a user object based on firebase user objece
  OurUser _curUserFromFirebase(User user) {
    return user != null ? OurUser(uid: user.uid) : null;
  }

  // Sign in anon method for testing. Async method
  Future signInAnon() async {
    try {
      // Signing in anon and getting a usercredential object
      // Authresult = UserCredential
      UserCredential result = await _auth.signInAnonymously();

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
  // sign out
}
