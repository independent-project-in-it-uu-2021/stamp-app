import 'package:flutter/material.dart';
import 'package:stamp_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Needed inorder to use firebase authentication. init firebase connection here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Wrapper(),
      title: 'Registrera konto',
      home: Wrapper(),
    );
  }
}
