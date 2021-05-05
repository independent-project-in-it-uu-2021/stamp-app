import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stamp_app/screens/autenticate/autenticate.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Current user that we get in the steamprovider
    final currentUser = Provider.of<User>(context);
    print(currentUser.uid);
    // return either Home or Autenicate widget
    return Authenticate();
  }
}
