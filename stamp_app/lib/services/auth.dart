import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Connecting to the firebase authentication (instance of firebaseauth)
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in anon method for testing. Async method
  Future signInAnon() async {
    try {
      // Signing in anon and getting a usercredential object
      UserCredential result = await _auth.signInAnonymously();

      // User object that we can extract from the usercredential object
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
