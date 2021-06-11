import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/screens/wrapper.dart';
import 'package:stamp_app/services/auth.dart';

void main() async {
  // Needed inorder to use firebase authentication. init firebase connection here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SteamProvider listing to Steam and exposes its content to child
    // in our case it is the current user
    return StreamProvider<User>.value(
      // Initial data that is used until stream emits a value
      initialData: null,
      value: AuthService().curUser,
      child: MaterialApp(
        showSemanticsDebugger: false,
        title: 'Registrera konto',
        home: Wrapper(),
      ),
    );
  }
}
