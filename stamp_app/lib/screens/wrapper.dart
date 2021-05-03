import 'package:flutter/material.dart';
import 'package:stamp_app/screens/autenticate/autenticate.dart';
import 'package:stamp_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either home or Autenicate widget
    return Authenticate();
  }
}
